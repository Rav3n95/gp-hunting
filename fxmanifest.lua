fx_version   'cerulean'
lua54        'yes'
game         'gta5'

name            'gp-hunting'
author          'Rav3n95#2849 - https://github.com/Rav3n95'
description     'Simple hunting system'
version         '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'lang/en.lua'
}

client_script 'client.lua'

server_script 'server.lua'

dependency 'qb-core'
dependency 'qb-inventory'
dependency 'qb-target'
