fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'M O N O'
description '[ESX/OX_LIB] Sushi Restaurant Job'
version '1.0.0'

client_scripts {
    'source/client.lua',
    'config/config.lua',
    'translations/*.lua',
}

server_scripts {
    'source/server.lua',
    'config/config.lua',
    'translations/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config/config.lua',
    'translations/*.lua',
}