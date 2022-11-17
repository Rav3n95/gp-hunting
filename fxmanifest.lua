fx_version   'cerulean'
lua54        'yes'
game         'gta5'

name            'gp-hunting'
author          'Rav3n95#2849 - https://github.com/Rav3n95'
description     'Simple hunting system'
version         '1.0.1'

shared_scripts {
    '@qb-core/shared/locale.lua',
    '@ox_lib/init.lua',
    'config.lua',
    'lang/en.lua'
}

client_script 'client.lua'
server_script 'server.lua'

dependency 'qb-core'
dependency 'ox_lib'
dependency 'ox_inventory'
dependency 'ox_target'