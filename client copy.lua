local QBCore = exports['qb-core']:GetCoreObject()

local models = {
    'a_c_deer',
    'a_c_boar',
    'a_c_mtlion',
    'a_c_coyote',
    'a_c_rabbit_01',
    'a_c_cow',
    'a_c_pig'
  }

CreateThread(function()

    exports['qb-target']:AddTargetModel(models, {
        options = {
          {
            type = "client",
            action = function(entity)
                TriggerEvent('rn-hunting:client:Processing', entity)
              end,
            icon = 'fas fa-solid fa-paw',
            label = Lang:t('task.process'),
            canInteract = function(entity) 
              if IsPedOnFoot(PlayerPedId()) and IsPedDeadOrDying(entity) and (GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('weapon_knife') or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('weapon_dagger') or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('weapon_switchblade')) then return true end
              return false
            end,
          }
        },
        distance = 1.5,
      }
    )
end)

RegisterNetEvent('rn-hunting:client:Processing', function(entity)

    if NetworkGetPlayerIndexFromPed(PlayerPedId()) == NetworkGetEntityOwner(entity) then
      QBCore.Functions.Progressbar('processAnimal', Lang:t('info.process'), 30000, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {
          animDict = 'amb@world_human_gardener_plant@male@base',
          anim = 'base',
          flags = 1,
      }, {}, {}, function() -- Done
          StopAnimTask(PlayerPedId(), 'amb@world_human_gardener_plant@male@base', 'base', 1.0)
          local meat

          if GetEntityModel(entity) == GetHashKey('a_c_pig') then
            meat = 'pork'
          elseif GetEntityModel(entity) == GetHashKey('a_c_cow') then
            meat  = 'beef'
          else
            meat  = 'meat'
          end
          TriggerServerEvent('rn-hunting:server:Reward', meat)
          
          DeleteEntity(entity)
      end, function() -- Cancel
          StopAnimTask(PlayerPedId(), 'amb@world_human_gardener_plant@male@base', 'base', 1.0)
      end)
    else
      QBCore.Functions.Notify(Lang:t('error.owner'), 'error')
    end

end)