ESX = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function cam()
    for _,v in pairs (Config.Camera) do  
        local camveh = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(camveh, true)
        SetCamParams(camveh, v.PositionCam , 0.0 , 0.0 , v.HeadingCam, 42.2442, 0, 1, 1, 2)
        SetCamFov(camveh, 60.0 --[[ distance (Field Of View) ]])
        RenderScriptCams(true, true --[[ activer l'animation ]], 5000 --[[ temps de l'animation ]], true, true)
    end
end

function veh()
    for _,v in pairs (Config.Vehicule) do  
        local model = GetHashKey("panto")
        RequestModel(model)
        while not HasModelLoaded(model) do Citizen.Wait(10) end
        local pos = GetEntityCoords(PlayerPedId())
        local vehicle = CreateVehicle(model, -307.9053, -1005.491149, 30.3850, 67.35, true, true)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end
end


local open = false
local mainMenu = RageUI.CreateMenu('Location', ' ', 0,50)
mainMenu.Closed = function()
    FreezeEntityPosition(PlayerPedId(), false)
    DestroyCam(camveh)
    ClearFocus()
    RenderScriptCams(0, 0, 300, 1, 1, 0)
    open = false
end

function Location()
    FreezeEntityPosition(PlayerPedId(), true)
     if open then
         open = false
         RageUI.Visible(mainMenu, false)
         return
     else
         open = true
         RageUI.Visible(mainMenu, true)
         CreateThread(function()
         while open do
            RageUI.IsVisible(mainMenu,function()
                for _,var in pairs (Config.Location) do
                    RageUI.Button(var.VehiculeLable, nil, {RightLabel = var.price, RightBadge = RageUI.BadgeStyle.Car, LeftBadge = RageUI.BadgeStyle.Star}, true , {
                        onSelected = function()
                            TriggerServerEvent("izakkk:location")
                            RageUI.CloseAll()
                            FreezeEntityPosition(PlayerPedId(), false)
                            cam()
                            Wait(1000)
                            local model = GetHashKey(var.VehiculeName)
                            RequestModel(model)
                            while not HasModelLoaded(model) do Citizen.Wait(10) end
                            local pos = GetEntityCoords(PlayerPedId())
                            local vehicle = CreateVehicle(model, var.PositionVeh, var.HeadingVeh, true, true)
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            Citizen.Wait(6000)
                            DestroyCam(camveh)
                            ClearFocus()
                            RenderScriptCams(0, 0, 300, 1, 1, 0)
                        end
                    })
                end
            end)
          Wait(0)
         end
      end)
   end
end
