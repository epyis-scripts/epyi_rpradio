-- # // VARIABLES INIT \\ --
local isRadioMenuOpened = false
local activeFrequency = 0
local isRadioActive = false
local isTalkingOnRadio = false

-- # // CHECK RESOURCE VALIDITY \\ # --
if canStartResource then
    -- # // INIT RAGEUI MENU \\ # --
    if Config.RageUI.customBanner.url == nil then
        RMenu.Add('epyi_rpradio', 'main', RageUI.CreateMenu(Config.RageUI.menuTitle, Config.RageUI.menuSubtitle, Config.RageUI.marginLeft, Config.RageUI.marginTop))
        RMenu:Get('epyi_rpradio', 'main').Closed = function()
            isRadioMenuOpened = false
        end;
        RMenu:Get("epyi_rpradio", "main"):SetRectangleBanner(Config.RageUI.defaultBanner.colorR, Config.RageUI.defaultBanner.colorG, Config.RageUI.defaultBanner.colorB, Config.RageUI.defaultBanner.colorA)
    else
        local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head')
        local Object = CreateDui(Config.Menu.menuCustomBanner, Config.RageUI.customBanner.imageWidth, Config.RageUI.customBanner.imageHeight)
        _G.Object = Object
        local TextureThing = GetDuiHandle(Object)
        local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head', TextureThing)
        local Menuthing = "Custom_Menu_Head"
        RMenu.Add('epyi_rpradio', 'main', RageUI.CreateMenu(Config.RageUI.menuTitle, Config.RageUI.menuSubtitle, Config.RageUI.marginLeft, Config.RageUI.marginTop, Menuthing, Menuthing))
        RMenu:Get('epyi_rpradio', 'main').Closed = function()
            isRadioMenuOpened = false
        end;
    end
    -- # // MENU EVENT \\ # --
    RegisterNetEvent("epyi_rpradio:openMenu")
    AddEventHandler("epyi_rpradio:openMenu", function()
        openRadioMenu()
    end)
    -- # // MENU FUNCTION \\ # --
    function openRadioMenu()
        if isRadioMenuOpened then
            RageUI.CloseAll()
            isRadioMenuOpened = false
        else
            isRadioMenuOpened = true
            RageUI.Visible(RMenu:Get('epyi_rpradio', 'main'), true, true, false)
            while isRadioMenuOpened do
                local activeFrequencyString = nil
                if activeFrequency == 0 then
                    activeFrequencyString = Locale.frequencyColor .. Locale.noFrequencySelectedMenu
                else
                    activeFrequencyString = Locale.frequencyColor .. activeFrequency .. Locale.frequencySymbol
                end
                RageUI.IsVisible(RMenu:Get('epyi_rpradio', 'main'), true, true, true, function()
                    if isRadioActive then
                        RageUI.Separator(Locale.radioState .. Locale.stateOn)
                    else
                        RageUI.Separator(Locale.radioState .. Locale.stateOff)
                    end
                    RageUI.Separator(Locale.radioFrequency .. activeFrequencyString)
                    RageUI.Separator("")
                    if not isRadioActive then
                        RageUI.ButtonWithStyle(Locale.enableRadio, Locale.enableRadioDescription, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                if activeFrequency ~= 0 then
                                    isRadioActive = true
                                    SendNUIMessage({ sound = "audio_on", volume = 0.3})
                                    exports["pma-voice"]:setRadioChannel(activeFrequency)
                                    exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
                                else
                                    ESX.ShowNotification(Locale.noFrequencySelectedNotification)
                                end
                            end
                        end)
                    else
                        RageUI.ButtonWithStyle(Locale.disableRadio, Locale.disableRadioDescription, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                isRadioActive = false
                                SendNUIMessage({ sound = "audio_off", volume = 0.3})
                                exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
                            end
                        end)
                    end
                    RageUI.ButtonWithStyle(Locale.changeFrequency, Locale.changeFrequencyDescription, {}, not isRadioActive, function(Hovered, Active, Selected)
                        if Selected then
                            local newFrequency = TextEntry(Locale.textEntryDescription, "", Config.Radio.maxFrequencySize)
                            if newFrequency ~= nil then
                                if onlyContainNumber(newFrequency) then
                                    local firstCharacter = string.sub(newFrequency, 1, 1)
                                    if firstCharacter == "0" then
                                        ESX.ShowNotification(Locale.firstCharacterError)
                                    else
                                        activeFrequency = tonumber(newFrequency)
                                    end
                                else
                                    ESX.ShowNotification(Locale.onlyNumbers)
                                end
                            end
                        end
                    end)
                end)
                Citizen.Wait(1)
            end
        end
    end
    Citizen.CreateThread(function()
        while true do
            if isRadioActive then
                fpsBoost = false
                AddEventHandler('pma-voice:radioActive', function(value)
                    isTalkingOnRadio = value
                end)
                -- # // PLAY ANIM WHEN TALKING \\ # --
                if isTalkingOnRadio then
                    ESX.ShowHelpNotification("JE PARLE")
                end
                -- # // DISABLE RADIO IF PLAYER LOST THE ITEM \\ # --
                if Config.Radio.useRadioAsItem then
                    ESX.TriggerServerCallback("epyi_rpradio:hasItem", function(result)
                        if not result then
                            RageUI.CloseAll()
                            exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
                            isRadioMenuOpened = false
                            activeFrequency = 0
                            isRadioActive = false
                        end
                    end, Config.Radio.radioItemName, 1)
                end
            end
            
            if fpsBoost then
                Citizen.Wait(1000)
            else
                Citizen.Wait(1)
                fpsBoost = true
            end
        end
    end)
    -- # // KEY REGISTERING \\ # --
    if Config.Radio.openRadioMenuKeyValue ~= nil then
        Keys.Register(Config.Radio.openRadioMenuKeyValue, "-openRadioMenu", Config.Radio.openRadioMenuKeyDesc, function()
            if Config.Radio.useRadioAsItem then
                ESX.TriggerServerCallback("epyi_rpradio:hasItem", function(result)
                    if result then
                        openRadioMenu()
                    else
                        ESX.ShowNotification(Locale.missingRadioItem)
                    end
                end, Config.Radio.radioItemName, 1)
            else
                openRadioMenu()
            end
        end)
    end
else
    print("^5 epyi_rpradio ^4The resource could not be started correctly. Make sure the resource name is epyi_rpradio.")
end