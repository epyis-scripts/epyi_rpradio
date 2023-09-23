fx_version("cerulean")
game("gta5")

name("epyi_rpradio")
description("RageUI Radio script for pma-voice API")
author("Epyi (https://discord.gg/VyRPheG6Es)")
version("1.7.1")

ui_page("ui/index.html")

files({
	"ui/index.html",
	"ui/on.ogg",
	"ui/off.ogg",
})

shared_scripts({
	"shared/locale.lua",
	"locales/*.lua",

	"@es_extended/imports.lua",
	"config.lua",
})

client_scripts({
	"src/RMenu.lua",
	"src/menu/RageUI.lua",
	"src/menu/Menu.lua",
	"src/menu/MenuController.lua",
	"src/components/*.lua",
	"src/menu/elements/*.lua",
	"src/menu/items/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/windows/*.lua",

	"client/var_init.lua",
	"client/menu_init.lua",
	"client/keys.lua",
	"client/thread.lua",
	"client/utils.lua",
	"client/menus/main.lua",
})

server_scripts({
	"server/version.lua",
	"server/main.lua",
})

dependencies({
	"es_extended",
	"pma-voice",
})
