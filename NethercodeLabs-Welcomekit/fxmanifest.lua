fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'NetherCode Labs'
description 'Universal One-Time Welcome Kit for ESX/QBCore'
version '2.0.0'

shared_script 'config.lua'

-- Wichtige Dependencies als '@' (Weak Dependencies), da nicht alle gleichzeitig existieren.
shared_script '@es_extended/imports.lua'   -- Für ESX (Alt & Neu)
--shared_script '@qb-core/exports.lua'       -- Für QBCore
server_script '@oxmysql/lib/MySQL.lua'     -- Für die 'only once' Datenbankprüfung

server_script 'server/main.lua'
client_script 'client/main.lua'