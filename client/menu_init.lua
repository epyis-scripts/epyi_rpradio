-- Variables initialization
-- init some local variables
isMenuOpened = false
menuCooldown = false
activeFrequency = 0
isRadioActive = false
isTalkingOnRadio = false
isPlayingTalkingAnim = false
animDictionary = { "cellphone@", "cellphone@in_car@ds", "cellphone@str", "random@arrests" }
animAnimation = { "cellphone_text_in", "cellphone_text_out", "cellphone_call_listen_a", "generic_radio_chatter" }
propHandle = nil
radioVolume = 100
activeFrequencyString = nil

-- Menu texture initialization
-- create the menu texture with the config parameters
if Config.MenuStyle.BannerStyle.ImageUrl ~= nil then
	local runtimeTXD = CreateRuntimeTxd("radio_custom_header")
	local Object = CreateDui(
		Config.MenuStyle.BannerStyle.ImageUrl,
		Config.MenuStyle.BannerStyle.ImageSize.Width,
		Config.MenuStyle.BannerStyle.ImageSize.Height
	)
	_G.Object = Object
	local objectTexture = GetDuiHandle(Object)
	local Texture = CreateRuntimeTextureFromDuiHandle(runtimeTXD, "radio_custom_header", objectTexture)
	menuTexture = "radio_custom_header"
end

-- RageUI menu initialization
-- init the rageui menu with the config parameters
RMenu.Add(
	"epyi_rpradio",
	"main",
	RageUI.CreateMenu(
		_("menu_title"),
		_U("menu_subtitle"),
		Config.MenuStyle.Margins.left,
		Config.MenuStyle.Margins.top,
		menuTexture,
		menuTexture
	)
)
RMenu:Get("epyi_rpradio", "main").Closed = function()
	isMenuOpened = false
end
if Config.MenuStyle.BannerStyle.ImageUrl == nil then
	RMenu:Get("epyi_rpradio", "main"):SetRectangleBanner(
		Config.MenuStyle.BannerStyle.Color.r,
		Config.MenuStyle.BannerStyle.Color.g,
		Config.MenuStyle.BannerStyle.Color.b,
		Config.MenuStyle.BannerStyle.Color.a
	)
end

---openMenu → Function to open the radio main menu
---@return void
function openMenu()
	-- Cooldown for realistic animation & avoid spamming error
	if menuCooldown then
		return
	end
	menuCooldown = true
	Citizen.SetTimeout(800, function()
		menuCooldown = false
	end)

	if isMenuOpened then
		isMenuOpened = false
		return
	end
	isMenuOpened = true
	RageUI.Visible(RMenu:Get("epyi_rpradio", "main"), true)
	openRadioMenuAnimation()
	_threads.radio_active.enable()
	while isMenuOpened do
		exports["pma-voice"]:setVoiceProperty("micClicks", Config.Radio.Sounds.radioClicks)
		if activeFrequency == 0 then
			activeFrequencyString = _("frequency_color") .. _U("no_frequency_selected_menu")
		else
			activeFrequencyString = _("frequency_color") .. activeFrequency .. _("frequency_symbol")
		end
		RageUI.IsVisible(
			RMenu:Get("epyi_rpradio", "main"),
			Config.MenuStyle.BannerStyle.UseHeader,
			Config.MenuStyle.BannerStyle.UseGlareEffect,
			Config.MenuStyle.BannerStyle.UseInstructionalButtons,
			function()
				main_showContentThisFrame()
			end
		)
		Citizen.Wait(0)
	end
	RageUI.CloseAll()
	stopThreadLegacy()
	closeRadioMenuAnimation()
end
