Config = {}

-------------------------------------------------------
-- Main
-------------------------------------------------------

Config.Language    = 'PL'                            -- Ustaw język: ('PL' // 'ENG') // Set language: ('PL' // 'ENG')
Config.Notify      = 'ESX'                           -- 'ESX' // 'OX' // 'OKOK' 
Config.JobLabel    = 'sushi'                         -- don't touch
Config.NotifyTime  = 5000                            -- Tutaj ustawiasz czas wyświetlania powiadomień // Here you set the display time for notifications

-------------------------------------------------------
-- Blips
-------------------------------------------------------

Config.BlipName    = '[#1] Sushi HUB'                -- Tekst blipu // Blip Text
Config.BlipCoords  = vector3(-169.79, 286.46, 93.76) -- Koordynaty blipu // Blip Coords
Config.BlipSprite  = 590                             -- Ikona Blipu // Blip Icon (https://docs.fivem.net/docs/game-references/blips/)
Config.BlipColor   = 0                               -- Kolor ikonki // Icon color (https://docs.fivem.net/docs/game-references/blips/)
Config.BlipScale   = 0.7                             -- Skala blipu // Blip scale
Config.BlipShort   = true                            -- Blip ma krótki zasięg? // Blip is short range?

Config.BlipName2   = '[#2] Sale Point'
Config.BlipCoords2 = vector3(-1011.02, -479.64, 39.97-0.99)
Config.BlipSprite2 = 280
Config.BlipColor2  = 2
Config.BlipScale2  = 0.7
Config.BlipShort2  = true

-------------------------------------------------------
-- Peds
-------------------------------------------------------

Config.PedModel    = "csb_agent"                     -- Model peda od garażu (https://wiki.rage.mp/index.php?title=Peds) // Garage ped model (https://wiki.rage.mp/index.php?title=Peds)
Config.PedX        = -171.26                         
Config.PedY        = 284.64
Config.PedZ        = 93.76
Config.PedHeading  = 213.82

Config.PedModel2   = "csb_anita"                     -- Model peda od sprzedaży // Sales ped model
Config.PedHeading2 = 127.43

-------------------------------------------------------
-- Garage
-------------------------------------------------------

Config.PlateText   = 'SHU'                           -- Tekst na tablicy // Text on the board
Config.CarName     = 'asbo'                          -- Model pojazdu // Vehicle model
Config.CarSpawnX   = -170.31
Config.CarSpawnY   = 277.32
Config.CarSpawnZ   = 93.40
Config.CarSpawnHE  = 170.09

-------------------------------------------------------
-- Clothes
-------------------------------------------------------

Config.Clothes = {
    male = {
        ['tshirt_1'] = 0, ['tshirt_2'] = 0,
        ['torso_1'] = 468, ['torso_2'] = 8,
        ['decals_1'] = 0, ['decals_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 1,
        ['pants_2'] = 0,
        ['helmet_1'] = -1,
        ['helmet_2'] = 0,
        ['shoes_1'] = 7,
        ['shoes_2'] = 1,
        ['chain_1'] = 0,
        ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
        ['torso_1'] = 0, ['torso_2'] = 5,
        ['decals_1'] = 0, ['decals_2'] = 0,
        ['arms'] = 14, ['pants_1'] = 201,
        ['pants_2'] = 0, ['shoes_1'] = 24,
        ['shoes_2'] = 0, ['chain_1'] = 0,
        ['chain_2'] = 0
    },
}