local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rn-hunting:server:Reward', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local reward = {
        meat = {type, math.random(1,4)},
        hide = {'hide', 1},
    }

    for k,v in pairs(reward) do
        TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items[v[1]], 'add')
        Player.Functions.AddItem(v[1], v[2], false, info)
        TriggerClientEvent("QBCore:Notify", src, Lang:t('info.reward', {value = v[2], value2 = QBCore.Shared.Items[v[1]].label}))
    end

end)