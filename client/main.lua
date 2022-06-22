local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


RegisterNetEvent('police:garage')
AddEventHandler('police:garage', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 455.19, ['y'] = -1019.8, ['z'] = 28.33, ['h'] = 90.44 }
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        -- SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
        SetVehicleNumberPlateText(vehicle, plate)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        SetEntityHeading(veh, coords.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)     
    Wait(100)
    TriggerEvent("police:client:SaveCar") --- event to buy the car
end)

RegisterNetEvent('police:client:SaveCar', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if veh ~= nil and veh ~= 0 then
        local plate = QBCore.Functions.GetPlate(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        local hash = props.model
        local vehname = GetDisplayNameFromVehicleModel(hash):lower()
        if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
            TriggerServerEvent('police:server:SaveCarData', props, QBCore.Shared.Vehicles[vehname], `veh`, plate)
            print(plate)
        else
            QBCore.Functions.Notify('You cant store this vehicle in your garage..', 'error')
        end
    else
        QBCore.Functions.Notify('You are not in a vehicle..', 'error')
    end
end)

RegisterNetEvent('police:client:menu', function(vehName)
            local myMenu = {
                {
                    id = 1,
                    header = 'police vehicle shop',
                    txt = ''
                },
                {
                    id = 2,
                    header = "< buy",
                    txt = "police ford vic",
                    params = {
                        event = "police:garage", --- event name
                        args = {
                            vehicle = 'npolvic', --- the car name 
                            
                        }
                    }
                },
                {
                    id = 3,
                    header = "< buy",
                    txt = "police dodge charger",
                    params = {
                        event = "police:garage", --- event name
                        args = {
                            vehicle = 'polchar',  --- the car name
                            
                        }
                    }
                },
                {
                    id = 4,
                    header = '< close',
                    txt = '',
                    params = {
                        event = 'qb-menu:close',
                    }
                },
            }
            exports['qb-menu']:openMenu(myMenu)
end)

RegisterCommand('livery', function(source, args)
	if (PlayerJob.name == "police") then
    local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
        local liveryID = tonumber(args[1])
        
        SetVehicleLivery(Veh, liveryID)
        else
            QBCore.Functions.Notify('you don`t have the job', "error", 5000)
    end
    end, false)
-- Citizen.CreateThread(function()
-- exports['qb-target']:SpawnPed({
--     model = 'ig_trafficwarden',
--     coords = vector4(441.87, -1014.97, 28.65, 189.94),
--     minusOne = true,
--     freeze = true,
--     invincible = true,
--     blockevents = true,
--     scenario = 'WORLD_HUMAN_CLIPBOARD', -- This is the scenario that will play the whole time the ped is spawned, this cannot pair with anim and animDict (OPTIONAL)
--     animDict = 'abigail_mcs_1_concat-0', -- This is the animation dictionairy to load the animation to play from (OPTIONAL)
--     target = {
--       options = {
--         {
--           type = "client",
--           event = "dacca:client:menu",
--           icon = 'fas fa-car',
--           label = 'police garage',
--           job = 'police'
--         }
--       },
--       distance = 2.5,
--     },
--     currentpednumber = 0,
--   })
-- end
