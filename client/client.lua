local VORPcore = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()
local FeatherMenu =  exports['feather-menu'].initiate()
local progressbar = exports.vorp_progressbar:initiate()

local ChoppedCactus = {}
local ChoppedCactusProps = false
local Distance = 11
local Chopped = false

local Toolout = false
local ToolId = nil
local CurrentItem = nil
local CurrentItemMaxUses = nil

-- Axe out

RegisterNetEvent('mms-cactus:client:ToolOut')
AddEventHandler('mms-cactus:client:ToolOut',function(ItemId,UsedItem,MaxUses)
    ToolId = ItemId
    CurrentItem = UsedItem
    CurrentItemMaxUses = MaxUses
    MyPed = PlayerPedId()
    if not Toolout then
        Wait(500)
        Tool = CreateObject(Config.ToolHash, GetOffsetFromEntityInWorldCoords(MyPed, 0.0, 0.0, 0.0), true, true, true)
        AttachEntityToEntity(Tool, MyPed, GetPedBoneIndex(MyPed, 7966), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1, 0, 0)
        Citizen.InvokeNative(0x923583741DC87BCE, MyPed, 'arthur_healthy')
        Citizen.InvokeNative(0x89F5E7ADECCCB49C, MyPed, "carry_pitchfork")
        Citizen.InvokeNative(0x2208438012482A1A, MyPed, true, true)
        ForceEntityAiAndAnimationUpdate(Tool, 1)
        Citizen.InvokeNative(0x3A50753042B6891B, MyPed, "PITCH_FORKS")
        Toolout = true
    elseif Toolout then
        Wait(500)
        DeleteObject(Tool)
        Citizen.InvokeNative(0x923583741DC87BCE, MyPed, 'arthur_healthy')
        Citizen.InvokeNative(0x2208438012482A1A, MyPed, false, false)
        Citizen.InvokeNative(0x58F7DB5BD8FA2288, PlayerPedId())
        ClearPedTasks(MyPed)
        Toolout = false
    end
end)

--- Get New ToolID

RegisterNetEvent('mms-cactus:client:UpdateItemId')
AddEventHandler('mms-cactus:client:UpdateItemId',function(NewToolId)
    ToolId = NewToolId
end)

-- Main Thred

Citizen.CreateThread(function ()
    local ChopCactusPrompt = BccUtils.Prompts:SetupPromptGroup()
    local ChopCactus = ChopCactusPrompt:RegisterPrompt(_U('Chop'), 0x760A9C6F, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
while true do
    Citizen.Wait(1500)

    while Toolout do
        Wait(3)
        Chopped = false
        local sleep = true
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for h,v in ipairs(Config.CactusProps) do
            local FoundCactus = Citizen.InvokeNative(0xBFA48E2FF417213F, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 1.5,
            GetHashKey(v.Prop), 0)
            if FoundCactus then
                CloseCactus = FoundCactus
            end
        end
        for h,v in ipairs(ChoppedCactus) do
            Distance = #(v - PlayerCoords)
            if Distance < 5 then
                Chopped = true
            end
        end
        if CloseCactus and not Chopped then
            sleep = false
            ChopCactusPrompt:ShowGroup(_U('Cactus'))
            
            if ChopCactus:HasCompleted() then
                Wait(200)
                ChoppedCactus[#ChoppedCactus + 1] = PlayerCoords
                ChoppedCactusProps = true
                ChopCactus:TogglePrompt(false)
                Wait(200)
                ChopCactus:TogglePrompt(true)
                TriggerEvent('mms-cactus:client:ChopCactus',ToolId)
            end
            Chopped = false
        end
        CloseCactus = false
        if sleep then
            Wait(200)
        end
    end
end
end)

-- Getting Cactus

RegisterNetEvent('mms-cactus:client:ChopCactus')
AddEventHandler('mms-cactus:client:ChopCactus',function(ToolId)
    Citizen.Wait(100)
    local MyPed = PlayerPedId()
    Anim(MyPed, "amb_work@world_human_tree_chop_new@working@pre_swing@male_a@trans", "pre_swing_trans_after_swing",
    -1, 7)
    Progressbar(Config.ChopTime,_U('WorkingHere'))
    TriggerServerEvent('mms-cactus:server:FinishChoppingcactus',ToolId,CurrentItem,CurrentItemMaxUses)
end)

--- Refresh Them

Citizen.CreateThread(function()
    while not ChoppedCactusProps do
        Citizen.Wait(5000)
        if ChoppedCactusProps then
            while true do
                Citizen.Wait(Config.ResetCactusTimer * 60000)
                for i, v in ipairs(ChoppedCactus) do  -- Tabelle leeren
                    ChoppedCactus[i] = nil
                    ChoppedCactusProps = false
                end
            end
        end
    end
end)




----------------- Utilities -----------------


------ Progressbar

function Progressbar(Time,Text)
    progressbar.start(Text, Time, function ()
    end, 'linear')
    Wait(Time)
    ClearPedTasks(PlayerPedId())
end

------ Animation

function CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local MyPed = PlayerPedId()
    local coords = GetEntityCoords(MyPed)
    TaskPlayAnim(MyPed, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        local dur = duration or -1
        local flag = flags or 1
        local intro = tonumber(introtiming) or 1.0
        local exit = tonumber(exittiming) or 1.0
        timeout = 5
        while (not HasAnimDictLoaded(dict) and timeout > 0) do
            timeout = timeout - 1
            if timeout == 0 then
                print("Animation Failed to Load")
            end
            Citizen.Wait(300)
        end
        TaskPlayAnim(actor, dict, body, intro, exit, dur, flag --[[1 for repeat--]], 1, false, false, false, 0, true)
    end)
end