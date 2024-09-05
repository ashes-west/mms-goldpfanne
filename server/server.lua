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

function keysx(table)
    local keys = 0
    for k,v in pairs(table) do
       keys = keys + 1
    end
    return keys
end

RegisterServerEvent('mms-goldpfanne:server:addreward')
AddEventHandler('mms-goldpfanne:server:addreward', function()
	local _source = source
	local Character = VORPcore.getUser(_source).getUsedCharacter
	local chance =  math.random(1,10)
	local reward = {}
	for k,v in pairs(Config.Items) do 
		if v.chance >= chance then
			table.insert(reward,v)
		end
	end
	local chance2 = math.random(1,keysx(reward))
	local count = math.random(1,reward[chance2].amount)
	exports.vorp_inventory:canCarryItems(tonumber(_source), count, function(canCarry)
		exports.vorp_inventory:canCarryItem(tonumber(_source), reward[chance2].name,count, function(canCarry2)
			if canCarry and canCarry2 then
				exports.vorp_inventory:addItem(_source, reward[chance2].name, count)
				VORPcore.NotifyTip(_source, Config.YouFound .." "..reward[chance2].label, 5000)
			else
				VORPcore.NotifyTip(_source, Config.InvFull .." "..reward[chance2].label, 5000)
			end
		end)
	end) 
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
        exports.vorp_inventory:addItem(src, toolItem, 1, { description = Config.UsageLeft .. 100 - toolUsage, durability = 100 - toolUsage })
    else
        local durabilityValue = toolMeta.durability - toolUsage
        exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)

        if durabilityValue >= toolUsage then
            exports.vorp_inventory:subItem(src, toolItem, 1, toolMeta)
            exports.vorp_inventory:addItem(src, toolItem, 1, { description = Config.UsageLeft .. durabilityValue, durability = durabilityValue })
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