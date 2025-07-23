local VORPcore = exports.vorp_core:GetCore()

local active = false


RegisterNetEvent('mms-goldpfanne:client:startgoldpfanne')
AddEventHandler('mms-goldpfanne:client:startgoldpfanne',function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x, coords.y, coords.z) -- GetWaterMapZoneAtCoords
    if active == false then
        for k, _ in pairs(Config.locations) do
            if water == Config.locations[k].hash and IsPedOnFoot(playerPed) and IsEntityInWater(playerPed) then
                active = true
                TriggerServerEvent('mms-goldpfanne:server:ToolUsage')
                Goldpan()
            end
        end
    end
end)

function Goldpan()
    local playerPed = PlayerPedId()
    local goldpan = CreateObject(GetHashKey('p_cs_miningpan01x'), GetEntityCoords(playerPed), true, true, true)
    local righthand = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    AttachEntityToEntity(goldpan, playerPed, righthand, 0.2, 0.0, -0.20, -100.0, -50.0, 0.0, false, false, false, true, 2, true)
    VORPcore.NotifyTip(_U('YouAreGoldpaning') , Config.GoldPanTime)
    Citizen.Wait(1000)
    CrouchAnim()
    Citizen.Wait(5000)
    GoldShake()
    Citizen.Wait(Config.GoldPanTime - 5000)
    local success = not Config.DoSkillCheck or DoSkillCheck()
    ClearPedTasks(playerPed)
    DeleteObject(goldpan)
    if success then
        TriggerServerEvent('mms-goldpfanne:server:addreward')
    else
        VORPcore.NotifyTip(_U('FailedSkillcheck') , 5000)
    end
    active = false
end

function DoSkillCheck()
    -- Keep in mind that these client-side games are only effective against macros and won't protect against other forms of exploits.
    local randomizer = math.random(Config.MaxDifficulty, Config.MinDifficulty)
    local skillCheckResult = exports["syn_minigame"]:taskBar(randomizer, 7)
    return skillCheckResult == 100
end


--- UTILS ---

function CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

function GoldShake()
    local dict = "script_re@gold_panner@gold_success"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "SEARCH02", 1.0, 8.0, -1, 1, 0, false, false, false)
end
