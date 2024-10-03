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
    local totalMoney = SUSHU * Config.SellPrice
    
    xPlayer.removeInventoryItem('sushi_sushi', SUSHU)
    xPlayer.addMoney(totalMoney)

if Config.UsingHook then
    local playerId = source
    local SIGMA = Config.HookURL

    local WRIZZ = {
        username = "Sushi Bot",
        embeds = {
            {
                title = "Sushi Sold",
                description = Translations[Config.Language]["WEB_PLAYER"] .. "**" .. playerId .. "**" .. Translations[Config.Language]["WEB_SELL"] .. "**" .. SUSHU .. "**" .. Translations[Config.Language]["WEB_FOR"] .. "**" .. totalMoney .. "$**."
                color = 65280
            }
        }
    }
    PerformHttpRequest(SIGMA, function(err, text, headers) end, 'POST', json.encode(WRIZZ), { ['Content-Type'] = 'application/json' })
else 
end
end)
