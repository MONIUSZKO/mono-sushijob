ESX = exports["es_extended"]:getSharedObject()

---------------------------------------------------
-- Variables
---------------------------------------------------

local OnDuty = false
local PlayerData = {}
local HaveCar = false
local veh = nil
local CarHash = Config.CarName
local Ped1Hash = GetHashKey(Config.PedModel)
local Ped2Hash = GetHashKey(Config.PedModel2)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    OnDuty = false
    BlipMain()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    OnDuty = false
    BlipMain()
end)

---------------------------------------------------
-- Main
---------------------------------------------------

WorkClothesSet = function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.male)
            OnDuty = true
            CreateFridgeZone()
            SpawnGaragePed()
            CreateFishZone()
            WashRiceZone()
            CookRiceZone()
            MakeSushiZone()
            GaragePedZone()
            if Config.Notify == 'ESX' then
                ESX.ShowNotification(Translations[Config.Language]["STARTED_WORK"], Config.NotifyTime)
            elseif Config.Notify == 'OX' then 
                lib.notify({
                    title = Translations[Config.Language]["NOTIFICATION"],
                    description = Translations[Config.Language]["STARTED_WORK"],
                    duration = Config.NotifyTime,
                })
            elseif Config.Notify == 'OKOK' then
                exports['okokNotify']:Alert(Translations[Config.Language]["NOTIFICATION"], Translations[Config.Language]["STARTED_WORK"], Config.NotifyTime, 'info', false)
            end
        else
            TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.female)
            OnDuty = true
            CreateFridgeZone()
            SpawnGaragePed()
            CreateFishZone()
            WashRiceZone()
            CookRiceZone()
            MakeSushiZone()
            GaragePedZone()
            if Config.Notify == 'ESX' then
                ESX.ShowNotification(Translations[Config.Language]["STARTED_WORK"], Config.NotifyTime)
            elseif Config.Notify == 'OX' then 
                lib.notify({
                    title = Translations[Config.Language]["NOTIFICATION"],
                    description = Translations[Config.Language]["STARTED_WORK"],
                    duration = Config.NotifyTime,
                })
            elseif Config.Notify == 'OKOK' then
                exports['okokNotify']:Alert(Translations[Config.Language]["NOTIFICATION"], Translations[Config.Language]["STARTED_WORK"], Config.NotifyTime, 'info', false)
            end

        end
    end)
end

CitizenClothesSet = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
        OnDuty = false
        RemoveGaragePed()
        RemoveFridgeZone()
        RemoveFishZone()
        RemoveWashRiceZone()
        RemoveSushiZone()
        RemoveCookRiceZone()
        if Config.Notify == 'ESX' then
            ESX.ShowNotification(Translations[Config.Language]["ENDED_WORK"], Config.NotifyTime)
        elseif Config.Notify == 'OX' then 
            lib.notify({
                title = Translations[Config.Language]["NOTIFICATION"],
                description = Translations[Config.Language]["ENDED_WORK"],
                duration = Config.NotifyTime,
            })
        elseif Config.Notify == 'OKOK' then
            exports['okokNotify']:Alert(Translations[Config.Language]["NOTIFICATION"], Translations[Config.Language]["ENDED_WORK"], Config.NotifyTime, 'info', false)
        end
    end)
end

function SpawnGaragePed()  
    RequestModel(GetHashKey(Config.PedModel))
    while not HasModelLoaded(GetHashKey(Config.PedModel)) do
    Wait(1)
    end

    GaragePed =  CreatePed(1, Ped1Hash, Config.PedX, Config.PedY, Config.PedZ-0.9, Config.PedHeading, false, true)
    SetEntityHeading(GaragePed, Config.PedHeading)
    FreezeEntityPosition(GaragePed, true)
    SetEntityInvincible(GaragePed, true)
    SetBlockingOfNonTemporaryEvents(GaragePed, true)
end

function RemoveGaragePed()
  DeletePed(GaragePed)
end

function SpawnSellPed()  
    RequestModel(GetHashKey(Config.PedModel2))
    while not HasModelLoaded(GetHashKey(Config.PedModel2)) do
    Wait(1)
    end

    SellPed =  CreatePed(1, Ped2Hash, vector3(Config.BlipCoords2), Config.PedHeading2, false, true)
    SetEntityHeading(SellPed, Config.PedHeading2)
    FreezeEntityPosition(SellPed, true)
    SetEntityInvincible(SellPed, true)
    SetBlockingOfNonTemporaryEvents(SellPed, true)
end

function RemoveSellPed()
  DeletePed(SellPed)
end

SpawnCar = function()
    ESX.Game.SpawnVehicle(CarHash, vector3(Config.CarSpawnX, Config.CarSpawnY, Config.CarSpawnZ), Config.CarSpawnHE, function(vehicle)
        local plateText = string.upper(Config.PlateText) .. tostring(math.random(100, 999))
        SetVehicleNumberPlateText(vehicle, plateText)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SellBlip()
        SpawnSellPed()
        SellPedZone()
        HaveCar = true
        veh = vehicle
    end)
end

DeleteCar = function()
    if HaveCar then
        local vehicle2 = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
        if vehicle2 then
            if vehicle2 == veh then
                HaveCar = false
                DeleteVehicle(veh)
                RemoveSellPed()
                RemoveSellBlip()
                RemoveSellPedZone()
                veh = nil
            end
        end
    end
end

---------------------------------------------------
-- Blips
---------------------------------------------------

function BlipMain()
    if PlayerData.job.name == Config.JobLabel then
        local SushiBlip = AddBlipForCoord(Config.BlipCoords)
	    SetBlipSprite      (SushiBlip, Config.BlipSprite)
	    SetBlipDisplay     (SushiBlip, 4)
	    SetBlipScale       (SushiBlip, Config.BlipScale)
	    SetBlipColour      (SushiBlip, Config.BlipColor)
	    SetBlipAsShortRange(SushiBlip, Config.BlipShort)
	    BeginTextCommandSetBlipName('STRING')
	    AddTextComponentSubstringPlayerName(Config.BlipName)
	    EndTextCommandSetBlipName(SushiBlip)
    else 
        RemoveBlip(SushiBlip)
    end
end

function SellBlip()
        SellBlip = AddBlipForCoord(Config.BlipCoords2)
	    SetBlipSprite      (SellBlip, Config.BlipSprite2)
	    SetBlipDisplay     (SellBlip, 4)
	    SetBlipScale       (SellBlip, Config.BlipScale2)
	    SetBlipColour      (SellBlip, Config.BlipColor2)
	    SetBlipAsShortRange(SellBlip, Config.BlipShort2)
	    BeginTextCommandSetBlipName('STRING')
	    AddTextComponentSubstringPlayerName(Config.BlipName2)
	    EndTextCommandSetBlipName(SellBlip)
end

function RemoveSellBlip()
    RemoveBlip(SellBlip)
end

---------------------------------------------------
-- Menus
---------------------------------------------------

ClothesMenuMain = function()
        lib.registerContext({
            id = 'DressMenu',
            title = Translations[Config.Language]["DRESS_MENU"],
            menu = 'DressMenu',
            options = {
              {
                title = Translations[Config.Language]["WORK_CLOTHES"],
                description = Translations[Config.Language]["WORK_CLOTHES2"],
                onSelect = WorkClothesSet,
                icon = 'shirt',
                arrow = false,
              },
              {
                title = Translations[Config.Language]["MY_CLOTHES"],
                description = Translations[Config.Language]["MY_CLOTHES2"],
                onSelect = CitizenClothesSet,
                icon = 'shirt',
                arrow = false,
              }
            }
          })
          lib.showContext('DressMenu')
end

FridgeMenuMain = function()
    lib.registerContext({
        id = 'FridgeContext',
        title = Translations[Config.Language]["FRIDGE_MENU"],
        menu = 'FridgeContext',
        options = {
        {
            title = Translations[Config.Language]["TAKE_SALMON"],
            onSelect = function()
                ESX.TriggerServerCallback('mono-sushi:givesalomon', function(source) end)
            end,
            icon = 'fish',
            arrow = false,
        },
        {
            title = Translations[Config.Language]["TAKE_RICE"],
            onSelect = function()
                ESX.TriggerServerCallback('mono-sushi:giverice', function(source) end)
            end,
            icon = 'bowl-food',
            arrow = false,
        },
        {
            title = Translations[Config.Language]["TAKE_NORI"],
            onSelect = function()
                ESX.TriggerServerCallback('mono-sushi:givenori', function(source) end)
            end,
            icon = 'leaf',
            arrow = false,
        },
        }
    })
    lib.showContext('FridgeContext')
end

---------------------------------------------------
-- Target
---------------------------------------------------

exports.ox_target:addBoxZone({
	name = "SushiClothes",
	coords = vec3(-173.15, 306.35, 101.0),
	size = vec3(2.8, 0.10000000000001, 1.55),
	rotation = 0.0,
    debug = false,
    options = {
        {
            onSelect = ClothesMenuMain,
            label = Translations[Config.Language]["DRESS_TARGET"],
            icon = 'fa-solid fa-shirt',
            distance = 2.5,
            canInteract = function()
                return PlayerData.job.name
            end,
        },
    },
})

function CreateFridgeZone()
    exports.ox_target:addBoxZone({
        name = "FridgeMenu",
        coords = vec3(-177.6, 306.35, 97.8),
        size = vec3(1.45, 0.3, 1.65),
        rotation = 0.0,
        debug = false,
        options = {
            {
                onSelect = FridgeMenuMain,
                label = Translations[Config.Language]["FRIDGE_TARGET"],
                icon = 'fa-solid fa-bag-shopping',
                distance = 1.5,
                canInteract = function()
                    return OnDuty and PlayerData.job.name
                end,
            },
        },
    })
end

function RemoveFridgeZone()
    exports.ox_target:removeZone("FridgeMenu")
end

function CreateFishZone()
    exports.ox_target:addBoxZone({
        name = "MakeFilet",
        coords = vec3(-174.15, 304.0, 97.4),
        size = vec3(0.25000000000001, 0.20000000000001, 0.1),
        rotation = 0.0,
        debug = false,
        options = {
            {
                onSelect = function()
                    local success = lib.skillCheck({'easy', 'easy', 'easy'}, {'1', '2', '3'})
                    if success then
                    lib.progressBar({
                        duration = 15000,
                        label = Translations[Config.Language]["PROGRESS1"],
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            move = true,
                            combat = true,
                        },
                        anim = {
                            dict = 'anim@amb@business@coc@coc_unpack_cut_left@',
                            clip = 'coke_cut_v4_coccutter',
                        },
                        prop = {
                            model = `prop_knife`,
                            pos = vec3(0.00, 0.00, 0.00),
                            rot = vec3(0.0, 0.0, 0.0)
                        },
                    })
                    ESX.TriggerServerCallback('mono-sushi:givesalmon2', function(source) end)
                else
                end
                end,
                label = Translations[Config.Language]["FISH_TARGET"],
                icon = 'fa-solid fa-fish',
                items = {'sushi_salmon'},
                distance = 1.5,
                canInteract = function()
                    return OnDuty and PlayerData.job.name
                end,
            },
        },
    })
end

function WashRiceZone()
exports.ox_target:addBoxZone({
	name = "WashRice",
	coords = vec3(-176.55, 303.95, 97.25),
	size = vec3(0.55, 0.45000000000001, 0.50000000000001),
	rotation = 0.0,
    debug = false,
    options = {
        {
            onSelect = function()
                local success = lib.skillCheck({'easy', 'easy', 'easy'}, {'1', '2', '3'})
                if success then
                lib.progressBar({
                    duration = 20000,
                    label = Translations[Config.Language]["PROGRESS2"],
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        move = true,
                        combat = true,
                    },
                    anim = {
                        scenario = 'PROP_HUMAN_BUM_BIN',
                    },
                })
                ESX.TriggerServerCallback('mono-sushi:giverice2', function(source) end)
            else
            end
            end,
            label = Translations[Config.Language]["RICE_TARGET"],
            icon = 'fa-solid fa-hands-bubbles',
            items = {'sushi_rice'},
            distance = 1.5,
            canInteract = function()
                return OnDuty and PlayerData.job.name
            end,
        },
    },
})
end

function MakeSushiZone()
    exports.ox_target:addBoxZone({
        name = "MakeSushi",
        coords = vec3(-175.0, 303.05, 97.05),
        size = vec3(1.3, 0.40000000000001, 0.95),
        rotation = 0.0,
        debug = false,
        options = {
            {
            onSelect = function()
                lib.progressBar({
                    duration = 10000,
                    label = Translations[Config.Language]["PROGRESS3"],
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        move = true,
                        combat = true,
                    },
                    anim = {
                        scenario = 'PROP_HUMAN_BUM_BIN',
                    },
                })
                ESX.TriggerServerCallback('mono-sushi:makesushi', function(source) end)
            end,
            label = Translations[Config.Language]["MAKE_TARGET"],
            icon = 'fa-solid fa-utensils',
            items = {['sushi_rice3'] = 1, ['sushi_salmon2'] = 1, ['sushi_nori'] = 1},
            distance = 1.5,
            canInteract = function()
                return OnDuty and PlayerData.job.name
            end,
            },
        },
    })
end

function CookRiceZone()
    exports.ox_target:addBoxZone({
        name = "sushiCook",
        coords = vec3(-178.2, 300.55, 97.6),
        size = vec3(0.25, 0.25000000000001, 0.40000000000001),
        rotation = 0.0,
        debug = false,
        options = {
            {
                onSelect = function()
                    local success = lib.skillCheck({'easy', 'easy', 'easy'}, {'1', '2', '3'})
                    if success then
                    lib.progressBar({
                        duration = 15000,
                        label = Translations[Config.Language]["PROGRESS4"],
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            move = true,
                            combat = true,
                        },
                        anim = {
                            scenario = 'PROP_HUMAN_BUM_BIN',
                        },
                    })
                ESX.TriggerServerCallback('mono-sushi:giverice3', function(source) end)
                else
                end
                end,
                label = Translations[Config.Language]["COOK_TARGET"],
                icon = 'fa-solid fa-bowl',
                items = {['sushi_rice2'] = 1},
                distance = 2.2,
                canInteract = function()
                    return OnDuty and PlayerData.job.name
                end,
            },
        },
    })
end

function GaragePedZone()
modelList = GetHashKey(Config.PedModel)
local OpTions = {
    {
    onSelect = SpawnCar,
    label = Translations[Config.Language]["CAR_TARGET"],
    icon = 'fa-solid fa-car',
    distance = 1.5,
    canInteract = function()
        return OnDuty and PlayerData.job.name
    end,
    num = 1,
    },
    {
        onSelect = DeleteCar,
        label = Translations[Config.Language]["DEL_TARGET"],
        icon = 'fa-solid fa-car',
        distance = 1.5,
        canInteract = function()
            return OnDuty and PlayerData.job.name
        end,
        num = 2,
    },
}
exports.ox_target:addModel(modelList, OpTions)
end

function SellPedZone()
    MoDeL = GetHashKey(Config.PedModel2)
    local settings = {
        {
            onSelect = function()
                ESX.TriggerServerCallback('mono-sushi:sell', function(source) end)
                SetBlipRoute(SellBlip, false)
            end,
            label = Translations[Config.Language]["SELL_TARGET"],
            icon = 'fa-solid fa-user',
            distance = 1.5,
            canInteract = function()
                return OnDuty and PlayerData.job.name
            end,
            items = {['sushi_sushi'] = 1},
        },
    }
exports.ox_target:addModel(MoDeL, settings)
end

function RemoveWashRiceZone()
    exports.ox_target:removeZone("WashRice")
end

function RemoveFishZone()
    exports.ox_target:removeZone("MakeFilet")
end

function RemoveSushiZone()
    exports.ox_target:removeZone("MakeSushi")
end

function RemoveCookRiceZone()
    export.ox_target:removeZone("sushiCook")
end

function RemoveGaragePedZone()
    exports.ox_target:removeModel(modelList)
end

function RemoveSellPedZone()
    exports.ox_target:removeModel(MoDeL)
end