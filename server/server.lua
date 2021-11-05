ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('izakkk:location')
AddEventHandler('izakkk:location', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Prix = 50
    local _source = source
    if xPlayer.getMoney() >= Prix then
        xPlayer.removeMoney(50)
        TriggerClientEvent('esx:showNotification', _source, "<C>~b~Vous avez payé une location.~s~</C>\nMontant: ~g~" ..Prix.. "$")
	elseif xPlayer.getMoney() <= 50 then
        xPlayer.removeMoney(50)
        TriggerClientEvent('esx:showNotification', _source, "<C>~b~Vous avez payé une location.~s~</C>\nMontant: ~g~" ..Prix.. "$")
    end
end)