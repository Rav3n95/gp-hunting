local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory
local DropQ = {}

local function CreateCustomDrop()
    local src = tonumber(source) or source
    local Pos = GetEntityCoords(GetPlayerPed(source))
    ox_inventory:CustomDrop('Reward', DropQ[src], Pos)
    DropQ[src] = {}
end

local function AddItem(item, quantity, metadata)
    local success, response = ox_inventory:AddItem(source, item, quantity)

    if not success then
        return print(response)
    end
end

local function CanCarry(item, quantity, metadata)
    if ox_inventory:CanCarryItem(source, item, quantity, metadata) then
        AddItem(item, quantity, metadata)
    else
        DropQ[source][#DropQ[source]+1] = {item, quantity, metadata}
    end
end

-- #TODO: Add quality metadata
RegisterNetEvent('gp_hunting:server:Reward', function(meatType)
    print(meatType)
    local meatQuantityRng = math.random(Config.reward.meat[1], Config.reward.meat[2])
    local hideQuantityRng = math.random(Config.reward.hide[1], Config.reward.hide[2])
    local quality = math.random(1, 3)
    local metadata = {}
    
    CanCarry('water', meatQuantityRng, metadata)
    CanCarry('sandwich', hideQuantityRng, metadata)
    if next(DropQ[source]) then CreateCustomDrop() end
end)

AddEventHandler('playerJoining', function()
    DropQ[source] = {}
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for _, playerId in pairs(GetPlayers()) do
        DropQ[tonumber(playerId)] = {}
    end
end)