ESX = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- PED

Citizen.CreateThread(function()
    for _,v in pairs(Config.Ped) do
        local hash = GetHashKey(v.name)
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        ped = CreatePed("PED_TYPE_CIVFEMALE", v.name, v.position-1, false, true)
        SetEntityHeading(ped, v.heading)
        FreezeEntityPosition(ped, true)
	    SetEntityInvincible(ped, true)
	    SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

-- BLIP

Citizen.CreateThread(function()
    for _,v in pairs(Config.Blip) do
        local blip = AddBlipForCoord(v.pos)
        SetBlipSprite(blip, v.id)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, v.color)
        SetBlipAsShortRange(blip, true)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- ACTION 

Citizen.CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local acfps = false
        local dst = GetDistanceBetweenCoords(pCoords, true)
        for _,v in pairs(Config.Position) do
            if #(pCoords - v.pos) < 1.5 then 
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour louer un vehicule")
                if IsControlJustPressed(1, 51) then 
                    Location()
                end
            acfps = true
            end
        end
        if acfps then
            Wait(1)
        else
            Wait(500)
        end
    end
end)