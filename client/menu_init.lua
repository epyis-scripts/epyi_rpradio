-- Variables initialization
-- init some local variables
isMenuOpened = false
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
if Config.RageUI.customBanner.url ~= nil then
	local Object = CreateDui(
		Config.RageUI.customBanner.url,
		Config.RageUI.customBanner.imageWidth,
		Config.RageUI.customBanner.imageHeight
	)
	_G.Object = Object
	menuTexture = "Custom_Menu_Head"
end

-- RageUI menu initialization
-- init the rageui menu with the config parameters
RMenu.Add(
	"epyi_rpradio",
	"main",
	RageUI.CreateMenu(
		_("menu_title"),
		_("menu_subtitle"),
		Config.RageUI.marginLeft,
		Config.RageUI.marginTop,
		menuTexture,
		menuTexture
	)
)
RMenu:Get("epyi_rpradio", "main").Closed = function()
	isMenuOpened = false
end
RMenu:Get("epyi_rpradio", "main"):SetRectangleBanner(
	Config.RageUI.defaultBanner.colorR,
	Config.RageUI.defaultBanner.colorG,
	Config.RageUI.defaultBanner.colorB,
	Config.RageUI.defaultBanner.colorA
)

---openMenu → Function to open the radio main menu
---@return void
function openMenu()
    if isMenuOpened then
        RageUI.CloseAll()
        isMenuOpened = false
		CloseRadioMenuAnimation()
    else
        isMenuOpened = true
        OpenRadioMenuAnimation()
        RageUI.Visible(RMenu:Get('epyi_rpradio', 'main'), true, true, false)
        while isMenuOpened do
            exports["pma-voice"]:setVoiceProperty("micClicks", Config.Radio.Sounds.radioClicks)
            if activeFrequency == 0 then
                activeFrequencyString = _("frequency_color") .. _U("no_frequency_selected_menu")
            else
                activeFrequencyString = _("frequency_color") .. activeFrequency .. _("frequency_symbol")
            end
            RageUI.IsVisible(RMenu:Get('epyi_rpradio', 'main'), true, true, true, function()
                main_showContentThisFrame()
            end)
            Citizen.Wait(1)
        end
    end
end