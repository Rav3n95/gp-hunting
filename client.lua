local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local currentWeapon = nil

-- Functions
    local function CorrectTool()
        if not currentWeapon then return false end
        for i = 1, #Config.authorisedTools do
            if Config.authorisedTools[i] == currentWeapon then
                return true
            end
        end
    end

    local function GetMeatType(prey)
        if not prey then return 'wild' end
        DeleteEntity(prey)

        local preyMeat
        local preyModel = GetEntityModel(prey)
        
        if preyModel == `a_c_deer` then
            preyMeat = 'deer'
        elseif preyModel == `a_c_boar` then
            preyMeat = 'boar'
        elseif preyModel == `a_c_rabbit_01` then
            preyMeat = 'rabit'
        elseif preyModel == `a_c_cow` then
            preyMeat = 'cow'
        elseif preyModel == `a_c_pig` then
            preyMeat = 'pork'
        else
            preyMeat = 'wild'
        end

        return preyMeat
    end

    local function ProcessPrey(prey)
        if not prey then return end

        NetworkRequestControlOfEntity(prey)
        while not NetworkHasControlOfEntity(prey) do
            Wait(10)
        end

        

        if lib.progressCircle({
            duration = Config.processTime * 1000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'amb@world_human_gardener_plant@male@base',
                clip = 'base',
                flag = '1'
            },
        }) then TriggerServerEvent('gp_hunting:server:Reward', GetMeatType(prey)) else print('Do stuff when cancelled') end
        --DeleteEntity(prey)
    end

    local function EnableTarget()
        local targetOption = {
            {
                name = 'gp_hunting:process',
                onSelect = function(data)
                    TriggerEvent('gp_hunting:client:ProcessPrey', data.entity)
                end,
                icon = 'fa-solid fa-road',
                label = Lang:t('task.process'),
                canInteract = function(entity, distance, coords, name, bone)
                    if not IsPedOnFoot(cache.ped) then return false end
                    if not IsPedDeadOrDying(entity, false) then return false end
                    if PlayerData.metadata['inlaststand'] or PlayerData.metadata['isdead'] then return false end
                    if CorrectTool() then return true end
                    return false
                end
              }
          }
          exports.ox_target:addModel(Config.authorisedPeds, targetOption)
    end

    local function DisableTarget()
        exports.ox_target:removeModel(Config.authorisedPeds, 'gp_hunting:process')
    end

-- Events
    RegisterNetEvent('gp_hunting:client:ProcessPrey', ProcessPrey)

-- Handlers
    AddEventHandler('ox_inventory:currentWeapon', function(item)
        if item then currentWeapon = item.hash else currentWeapon = nil end
    end)

    AddEventHandler('onResourceStart', function(resource)
       if resource ~= GetCurrentResourceName() then return end
       PlayerData = QBCore.Functions.GetPlayerData()
       EnableTarget()
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
        EnableTarget()
    end)
    
    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData = {}
        DisableTarget()
        currentWeapon = nil
    end)
    
    RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
        PlayerData = val
    end)

RegisterCommand('tool', function(source)

end, false)