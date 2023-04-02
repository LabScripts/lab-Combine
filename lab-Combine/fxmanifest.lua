fx_version 'cerulean'
game 'gta5' 
lua54 'yes'

author 'Lab Scripts'
description 'Combine items for ox_inventory'
version '1.1'

dependencies { 'ox_lib', 'ox_inventory'}

shared_scripts {'@ox_lib/init.lua'}

server_scripts {
	'server.lua'
}

client_scripts {
	'client.lua'
}
