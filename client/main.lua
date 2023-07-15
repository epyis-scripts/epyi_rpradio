
-- # // MENU FUNCTION \\ # --
function openRadioMenu()
    if isMenuOpened then
        RageUI.CloseAll()
        isMenuOpened = false
        closeRadioMenuAnimation()
    else
        isMenuOpened = true
        openRadioMenuAnimation()
        -- # // RAGEUI MENU \\ # --
        RageUI.Visible(RMenu:Get('epyi_rpradio', 'main'), true, true, false)
        while isMenuOpened do
            exports["pma-voice"]:setVoiceProperty("micClicks", Config.Radio.Sounds.radioClicks)
            local activeFrequencyString = nil
            if activeFrequency == 0 then
                activeFrequencyString = Locale.frequencyColor .. Locale.noFrequencySelectedMenu
            else
                activeFrequencyString = Locale.frequencyColor .. activeFrequency .. Locale.frequencySymbol
            end
            RageUI.IsVisible(RMenu:Get('epyi_rpradio', 'main'), true, true, true, function()
                
            end)
            Citizen.Wait(1)
        end
    end
end
Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        if isRadioActive or isMenuOpened then
            fpsBoost = false
            AddEventHandler('pma-voice:radioActive', function(value)
                isTalkingOnRadio = value
            end)
            -- # // DEFINE THE ANIM TYPE \\ # --
            local broadcastType = 4 + (isMenuOpened and -1 or 0)
            local broadcastDictionary = animDictionary[broadcastType]
            local broadcastAnimation = animAnimation[broadcastType]
            -- # // PLAY ANIM WHEN TALKING \\ # --
            if isTalkingOnRadio and not isPlayingTalkingAnim then
                isPlayingTalkingAnim = true
                RequestAnimDict(broadcastDictionary)
                while not HasAnimDictLoaded(broadcastDictionary) do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(player, broadcastDictionary, broadcastAnimation, 8.0, -8, -1, 49, 0, 0, 0, 0)
            elseif not isTalkingOnRadio and isPlayingTalkingAnim then
                isPlayingTalkingAnim = false
                StopAnimTask(player, broadcastDictionary, broadcastAnimation, -4.0)
                if isMenuOpened then
                    local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
                    local animationType = 1 + (isMenuOpened and 0 or 1)
                    local dictionary = animDictionary[dictionaryType]
                    local animation = animAnimation[animationType]
                    TaskPlayAnim(player, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
                end
            end
            -- # // DISABLE RADIO IF PLAYER LOST THE ITEM \\ # --
            if Config.Radio.useRadioAsItem then
                ESX.TriggerServerCallback("epyi_rpradio:hasItem", function(result)
                    if not result then
                        RageUI.CloseAll()
                        exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
                        isMenuOpened = false
                        activeFrequency = 0
                        isRadioActive = false
                        closeRadioMenuAnimation()
                    end
                end, Config.Radio.radioItemName, 1)
            end
            -- # // DISCONNECT RADIO IF PLAYER IS DEAD \\ # --
            if Config.Radio.disconnectRadioOnDeath then
                if IsEntityDead(player) then
                    RageUI.CloseAll()
                    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
                    isMenuOpened = false
                    activeFrequency = 0
                    isRadioActive = false
                    closeRadioMenuAnimation()
                end
            end
        end
        if fpsBoost then
            Citizen.Wait(1000)
        else
            Citizen.Wait(100)
            fpsBoost = true
        end
    end
end)