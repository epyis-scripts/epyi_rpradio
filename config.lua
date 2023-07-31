Config = { Radio = {} }
Config.Locale = GetConvar("epyi_rpradio:locale", "en") -- EN/FR/ES/IT/NL

Config.MenuStyle = {
	Margins = { left = 10, top = 10 }, -- [table] → Set the menu margins
	BannerStyle = {
		Color = { r = 150, g = 50, b = 50, a = 100 }, -- [table] → Set the banner color if no custom banner image is set
		UseHeader = true, -- [boolean] → Use the RageUI header or not
		UseGlareEffect = true, -- [boolean] → Use the glare effect or not
		UseInstructionalButtons = true, -- [boolean] → Use the instructionals buttons or not
		ImageUrl = nil, -- [nil/string] → Set a custom image url if you want (if set, it will disable the Color configuration)
		ImageSize = { Width = 512, Height = 128 }, -- [table] → Set the image (ImageUrl) size un pixels
		widthOffset = 100, -- [integer] → Offset of the menu (default: 0, max: 100)
	},
}

Config.Radio.key = "F9" -- [nil/string] → Key to open the radio menu (can be set to nil if you want only the items work)
Config.Radio.useRadioAsItem = true -- [boolean] → Do you want to use radio as item ?
Config.Radio.radioItemName = "radio" -- [string] → If "useRadioAsItem" is true, set the radio item name
Config.Radio.maxFrequencySize = 3 -- [integer] → Set the maximum number of numbers in the frequency (example: 3 makes three-digit frequencies like "374", 4 makes four-digit frequencies like "7854", 5 makes five-digit frequencies like "98763")
Config.Radio.disconnectRadioOnDeath = true -- [boolean] → Do you want the radio to automatically disconnect when the player dies?
Config.Radio.canChangeVolume = true -- [boolean] → Do you want players to be able to change their radio volume?
Config.Radio.Sounds = {
	radioOn = true, -- [boolean] → Do you want the script play a sound when the radio is turned on ?
	radioOff = true, -- [boolean] → Do you want the script play a sound when the radio is turned off ?
	radioClicks = true, -- [boolean] → Do you want the script play a sound when the player is talking on the radio ?
}
Config.Radio.PrivateJobsFrequency = {
	[1] = { "police", "fbi" },
	[2] = { "police", "fbi" },
	[3] = { "police", "fbi" },
	[4] = { "ambulance", "police", "fbi" },
	[5] = { "fbi" },
}
