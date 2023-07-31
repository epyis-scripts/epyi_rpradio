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
if Config.menuStyle.bannerStyle.imageUrl ~= nil then
	local runtimeTXD = CreateRuntimeTxd("radio_custom_header")
	local Object = CreateDui(
		Config.menuStyle.bannerStyle.imageUrl,
		Config.menuStyle.bannerStyle.imageSize.Width,
		Config.menuStyle.bannerStyle.imageSize.Height
	)
	_G.Object = Object
	local objectTexture = GetDuiHandle(Object)
	local Texture = CreateRuntimeTextureFromDuiHandle(runtimeTXD, "radio_custom_header", objectTexture)
	menuTexture = "radio_custom_header"
end

---openMenu → Function to open the radio main menu
---@return void
function openMenu()
	-- Cooldown for realistic animation
	if menuCooldown then
		return
	end
	menuCooldown = true
	Citizen.SetTimeout(800, function()
		menuCooldown = false
	end)

	-- Close menu if already opened
	if _var.menus.radio.rageObject then
		RageUI.Visible(_var.menus.radio.rageObject, false)
		return
	end

	-- RageUI menu initialization
	-- init the rageui menu with the config parameters
	_var.menus.radio.rageObject = RageUI.CreateMenu(
		_("menu_title"),
		_U("menu_subtitle"),
		Config.menuStyle.margins.left,
		Config.menuStyle.margins.top,
		menuTexture,
		menuTexture
	)
	if Config.menuStyle.bannerStyle.imageUrl == nil then
		_var.menus.radio.rageObject:SetRectangleBanner(
			Config.menuStyle.bannerStyle.color.r,
			Config.menuStyle.bannerStyle.color.g,
			Config.menuStyle.bannerStyle.color.b,
			Config.menuStyle.bannerStyle.color.a
		)
	end
	_var.menus.radio.rageObject:SetStyleSize(Config.menuStyle.bannerStyle.widthOffset)
	RageUI.Visible(_var.menus.radio.rageObject, not RageUI.Visible(_var.menus.radio.rageObject))

	-- Functions to execute when opening the menu
	_threads.radio_active.enable()
	openRadioMenuAnimation()

	-- RageUI menu loop
	while _var.menus.radio.rageObject do
		exports["pma-voice"]:setVoiceProperty("micClicks", Config.radio.sounds.radioClicks)
		if activeFrequency == 0 then
			activeFrequencyString = _("frequency_color") .. _U("no_frequency_selected_menu")
		else
			activeFrequencyString = _("frequency_color") .. activeFrequency .. _("frequency_symbol")
		end
		RageUI.IsVisible(
			_var.menus.radio.rageObject,
			Config.menuStyle.bannerStyle.useHeader,
			Config.menuStyle.bannerStyle.useGlareEffect,
			Config.menuStyle.bannerStyle.useInstructionalButtons,
			function()
				main_showContentThisFrame()
			end,
			function()
				-- panels
			end
		)
		if not RageUI.Visible(_var.menus.radio.rageObject) then
			_var.menus.radio.rageObject = RMenu:DeleteType("_var.menus.radio.rageObject", true)

			-- Function to execute when closing the menu
			stopThreadLegacy()
			closeRadioMenuAnimation()
		end
		Citizen.Wait(0)
	end
end
