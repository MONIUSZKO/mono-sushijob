ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('mono-sushi:givesalomon', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('sushi_salmon', 1)
end)

ESX.RegisterServerCallback('mono-sushi:givenori', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('sushi_nori', 1)
end)

ESX.RegisterServerCallback('mono-sushi:givesalmon2', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('sushi_salmon', 1)
    xPlayer.addInventoryItem('sushi_salmon2', 1)
end)

ESX.RegisterServerCallback('mono-sushi:giverice', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('sushi_rice', 1)
end)

ESX.RegisterServerCallback('mono-sushi:giverice2', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('sushi_rice', 1)
    xPlayer.addInventoryItem('sushi_rice2', 1)
end)

ESX.RegisterServerCallback('mono-sushi:giverice3', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('sushi_rice2', 1)
    xPlayer.addInventoryItem('sushi_rice3', 1)
end)

ESX.RegisterServerCallback('mono-sushi:makesushi', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('sushi_salmon2', 1)
    xPlayer.removeInventoryItem('sushi_rice3', 1)
    xPlayer.removeInventoryItem('sushi_nori', 1)
    xPlayer.addInventoryItem('sushi_sushi', 9)
end)

ESX.RegisterServerCallback('mono-sushi:sell', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local SUSHU = xPlayer.getInventoryItem('sushi_sushi').count
    xPlayer.removeInventoryItem('sushi_sushi', SUSHU)
    xPlayer.addMoney(SUSHU * 5)
end)