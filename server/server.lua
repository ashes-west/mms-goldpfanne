local VORPcore = exports.vorp_core:GetCore()

-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/RetryR1v2/mms-goldpfanne/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return
        end


        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('Current Version: %s'):format(currentVersion))
            versionCheckPrint('success', ('Latest Version: %s'):format(text))
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

exports.vorp_inventory:registerUsableItem(Config.GoldPanItem, function(data)
    local source = data.source
    TriggerClientEvent('mms-goldpfanne:client:startgoldpfanne',source)
end)


RegisterServerEvent('mms-goldpfanne:server:addreward')
AddEventHandler('mms-goldpfanne:server:addreward', function()
    local src = source

    -- Determine whether gold panning was successful
    if math.random(1,100) > Config.RewardChance then
        VORPcore.NotifyTip(src, _U('NothingFound'), 5000)
        return
    end

    -- Determine the reward
    local Chance =  math.random(1,100)
    local RewardItem = nil
    if Chance <= Config.NormalChance then
        local TableMaxIndex = #Config.NormalItems
        local TableRandomIndex = math.random(1,TableMaxIndex)
        RewardItem = Config.NormalItems[TableRandomIndex]
    else
        local TableMaxIndex = #Config.RareItems
        local TableRandomIndex = math.random(1,TableMaxIndex)
        RewardItem = Config.RareItems[TableRandomIndex]
    end

    -- Try to hand the player their reward
    local RewardAmount = RewardItem.Amount
    local Handed = false
    repeat
        local CanCarry = exports.vorp_inventory:canCarryItem(src, RewardItem.Name, RewardAmount)
        if CanCarry then
            exports.vorp_inventory:addItem(src, RewardItem.Name, RewardAmount)
            VORPcore.NotifyTip(src, _U('YouFound') .. RewardAmount .. ' ' .. RewardItem.Label, 5000)
            Handed = true
        else
            RewardAmount = RewardAmount - 1
        end
    until Handed or RewardAmount <= 0

    if not Handed then
        VORPcore.NotifyTip(src, _U('InvFull'), 5000)
    end

end)

RegisterServerEvent('mms-goldpfanne:server:ToolUsage',function()
    local src = source
    local user = VORPcore.getUser(src)
    if not user then return end
    local toolItem = Config.GoldPanItem
    local toolUsage = Config.ToolUsage
    local tool = exports.vorp_inventory:getItem(src, toolItem)
    local toolMeta =  tool['metadata']

    if next(toolMeta) == nil then
        exports.vorp_inventory:subItem(src, toolItem, 1, {})
        exports.vorp_inventory:addItem(src, toolItem, 1, { description = _U('UsageLeft') .. 100 - toolUsage, durability = 100 - toolUsage })
    else
        local durabilityValue = toolMeta.durability - toolUsage
        exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)

        if durabilityValue >= toolUsage then
            exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)
            exports.vorp_inventory:addItem(src, toolItem, 1, { description = _U('UsageLeft') .. durabilityValue, durability = durabilityValue })
        elseif durabilityValue < toolUsage then
            exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)
            VORPcore.NotifyRightTip(src, _U('needNewTool'), 4000)
        end
    end
end)



--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()