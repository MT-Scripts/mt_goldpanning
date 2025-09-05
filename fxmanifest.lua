fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Martttins'
description 'Simple free FiveM gold-panning script'

client_script 'resource/client.lua'
server_script 'resource/server.lua'
shared_script '@ox_lib/init.lua'

files {
    'locales/*.json',
    'modules/**/*.lua',
    'config/*.lua'
}

dependencies {
    'ox_lib',
    'ox_inventory'
}