Config = { radio = {} }
Config.Locale = GetConvar("epyi_rpradio:locale", "en") -- EN/FR/ES/IT/NL

Config.menuStyle = {
	margins = { left = 10, top = 10 }, -- [table] → Set the menu margins
	bannerStyle = {
		color = { r = 150, g = 50, b = 50, a = 100 }, -- [table] → Set the banner color if no custom banner image is set
		useHeader = true, -- [boolean] → Use the RageUI header or not
		useGlareEffect = true, -- [boolean] → Use the glare effect or not
		useInstructionalButtons = true, -- [boolean] → Use the instructionals buttons or not
		imageUrl = nil, -- [nil/string] → Set a custom image url if you want (if set, it will disable the color configuration)
		imageSize = { width = 512, height = 128 }, -- [table] → Set the image (imageUrl) size un pixels
		widthOffset = 0, -- [integer] → Offset of the menu (default rageui: 0, max: 100)
	},
}

Config.radio.key = "F9" -- [nil/string] → Key to open the radio menu (can be set to nil if you want only the items work)
Config.radio.useRadioAsItem = true -- [boolean] → Do you want to use radio as item ?
Config.radio.radioItemName = "radio" -- [string] → If "useRadioAsItem" is true, set the radio item name
Config.radio.maxFrequencySize = 3 -- [integer] → Set the maximum number of numbers in the frequency (example: 3 makes three-digit frequencies like "374", 4 makes four-digit frequencies like "7854", 5 makes five-digit frequencies like "98763")
Config.radio.disconnectRadioOnDeath = true -- [boolean] → Do you want the radio to automatically disconnect when the player dies?
Config.radio.canChangeVolume = true -- [boolean] → Do you want players to be able to change their radio volume?
Config.radio.sounds = {
	radioOn = true, -- [boolean] → Do you want the script play a sound when the radio is turned on ?
	radioOff = true, -- [boolean] → Do you want the script play a sound when the radio is turned off ?
	radioClicks = true, -- [boolean] → Do you want the script play a sound when the player is talking on the radio ?
}
Config.radio.privateJobsFrequency = {
	[1] = { "police", "fbi" },
	[2] = { "police", "fbi" },
	[3] = { "police", "fbi" },
	[4] = { "ambulance", "police", "fbi" },
	[5] = { "fbi" },
}
