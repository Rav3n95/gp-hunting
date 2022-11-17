local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

local function CreateCustomDrop(item, quantity, metadata)
    local Pos = GetEntityCoords(GetPlayerPed(source))

    ox_inventory:CustomDrop('Reward', {
        {item, quantity, metadata},
    }, Pos)
end

local function AddItem(item, quantity, metadata)
    local success, response = ox_inventory:AddItem(source, item, quantity)

    if not success then
        CreateCustomDrop(item, quantity)
        return print(response)
    end
end

local function CanCarry(item, quantity, metadata)
    if ox_inventory:CanCarryItem(source, item, quantity) then
        AddItem(item, quantity, metadata)
    else
        CreateCustomDrop(item, quantity, metadata)
    end
    
    
end

RegisterNetEvent('gp_hunting:server:Reward', function(meatType)
    print(meatType)
    local meatQuantityRng = math.random(Config.reward.meat[1], Config.reward.meat[2])
    local hideQuantityRng = math.random(Config.reward.hide[1], Config.reward.hide[2])
    local quality = math.random(1, 3)
    local metadata = {}
    
    CanCarry('water', meatQuantityRng, metadata)
    CanCarry('sandwich', hideQuantityRng, metadata)
end)
