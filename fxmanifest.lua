fx_version "cerulean"
game "gta5"

name "epyi_rpradio"
description "Une radio qui utilise l'API Radio de pma-voice"
author "Epyi (https://discord.gg/VyRPheG6Es)"
version "1.0.0"

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/on.ogg",
	"ui/off.ogg",
}

shared_scripts {
    "@es_extended/imports.lua"
}
client_scripts {
	"client/cl_main.lua",
    "client/cl_functions.lua"
}
server_scripts {
	"server/sv_main.lua",
    "server/sv_functions.lua"
}

dependencies {
	"es_extended",
	"pma-voice"
}