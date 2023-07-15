-- Variables initialization
-- init some local variables
local isRadioMenuOpened = false
local activeFrequency = 0
local isRadioActive = false
local isTalkingOnRadio = false
local isPlayingTalkingAnim = false
local animDictionary = { "cellphone@", "cellphone@in_car@ds", "cellphone@str", "random@arrests" }
local animAnimation = { "cellphone_text_in", "cellphone_text_out", "cellphone_call_listen_a", "generic_radio_chatter" }
local propHandle = nil
local radioVolume = 100

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
		Locale.menuTitle,
		Locale.menuSubtitle,
		Config.RageUI.marginLeft,
		Config.RageUI.marginTop,
		menuTexture,
		menuTexture
	)
)
RMenu:Get("epyi_rpradio", "main").Closed = function()
	isRadioMenuOpened = false
end
RMenu:Get("epyi_rpradio", "main"):SetRectangleBanner(
	Config.RageUI.defaultBanner.colorR,
	Config.RageUI.defaultBanner.colorG,
	Config.RageUI.defaultBanner.colorB,
	Config.RageUI.defaultBanner.colorA
)

---epyi_rpradio:openMenu [EVENT] → Execute the openMenu function
---@return void
RegisterNetEvent("epyi_rpradio:openMenu")
AddEventHandler("epyi_rpradio:openMenu", function()
	openRadioMenu()
end)

---closeRadioMenuAnimation [FUNCTION] → Play animation when closing radio menu
---@return void
function closeRadioMenuAnimation()
	DetachEntity(propHandle, true, false)
	DeleteEntity(propHandle)
	local player = PlayerPedId()
	local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
	local animationType = 1 + (isRadioMenuOpened and 0 or 1)
	local dictionary = animDictionary[dictionaryType]
	local animation = animAnimation[animationType]
	while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(100)
	end
	TaskPlayAnim(player, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
	Citizen.Wait(700)
	StopAnimTask(player, dictionary, animation, 1.0)
end

---openRadioMenuAnimation [FUNCTION] → Play animation when openning the radio menu
---@return void
function openRadioMenuAnimation()
	local player = PlayerPedId()
	local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
	local animationType = 1 + (isRadioMenuOpened and 0 or 1)
	local dictionary = animDictionary[dictionaryType]
	local animation = animAnimation[animationType]
	RequestModel(GetHashKey("prop_cs_hand_radio"))
	while not HasModelLoaded(GetHashKey("prop_cs_hand_radio")) do
		Citizen.Wait(100)
	end
	propHandle = CreateObject(GetHashKey("prop_cs_hand_radio"), 0.0, 0.0, 0.0, true, true, false)
	local bone = GetPedBoneIndex(player, 28422)
	SetCurrentPedWeapon(player, unarmed, true)
	AttachEntityToEntity(propHandle, player, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 2, true)
	RequestAnimDict(dictionary)
	while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(100)
	end
	TaskPlayAnim(player, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
end

-- # // MENU FUNCTION \\ # --
function openRadioMenu()
    if isRadioMenuOpened then
        RageUI.CloseAll()
        isRadioMenuOpened = false
        closeRadioMenuAnimation()
    else
        isRadioMenuOpened = true
        openRadioMenuAnimation()
        -- # // RAGEUI MENU \\ # --
        RageUI.Visible(RMenu:Get('epyi_rpradio', 'main'), true, true, false)
        while isRadioMenuOpened do
            exports["pma-voice"]:setVoiceProperty("micClicks", Config.Radio.Sounds.radioClicks)
            local activeFrequencyString = nil
            if activeFrequency == 0 then
                activeFrequencyString = Locale.frequencyColor .. Locale.noFrequencySelectedMenu
            else
                activeFrequencyString = Locale.frequencyColor .. activeFrequency .. Locale.frequencySymbol
            end
            RageUI.IsVisible(RMenu:Get('epyi_rpradio', 'main'), true, true, true, function()
                RageUI.Separator("")
                if isRadioActive then
                    RageUI.Separator(Locale.radioState .. Locale.stateOn)
                else
                    RageUI.Separator(Locale.radioState .. Locale.stateOff)
                end
                RageUI.Separator(Locale.radioFrequency .. activeFrequencyString)
                if Config.Radio.canChangeVolume then
                    RageUI.Separator(Locale.radioVolume .. radioVolume .. "%")
                end
                RageUI.Separator("")
                if not isRadioActive then
                    RageUI.ButtonWithStyle(Locale.enableRadio, Locale.enableRadioDescription, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            if activeFrequency ~= 0 then
                                isRadioActive = true
                                if Config.Radio.Sounds.radioOn then
                                    SendNUIMessage({ sound = "audio_on", volume = 0.3})
                                end
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
                            if Config.Radio.Sounds.radioOff then
                                SendNUIMessage({ sound = "audio_off", volume = 0.3})
                            end
                            exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
                        end
                    end)
                end
                RageUI.ButtonWithStyle(Locale.changeFrequency, Locale.changeFrequencyDescription, {}, not isRadioActive, function(Hovered, Active, Selected)
                    if Selected then
                        local newFrequency = TextEntry(Locale.textEntryDescription, "", Config.Radio.maxFrequencySize)
                        if newFrequency ~= nil then
                            if OnlyContainNumber(newFrequency) then
                                local firstCharacter = string.sub(newFrequency, 1, 1)
                                if firstCharacter == "0" then
                                    ESX.ShowNotification(Locale.firstCharacterError)
                                else
                                    local canJoinFrequency = false
                                    if Config.Radio.PrivateJobsFrequency[tonumber(newFrequency)] ~= nil then
                                        local PlayerData = ESX.GetPlayerData()
                                        for k,v in pairs(Config.Radio.PrivateJobsFrequency[tonumber(newFrequency)]) do
                                            if v == PlayerData.job.name then
                                                canJoinFrequency = true
                                            end
                                        end
                                    else
                                        canJoinFrequency = true
                                    end
                                    if canJoinFrequency then
                                        activeFrequency = tonumber(newFrequency)
                                    else
                                        ESX.ShowNotification(Locale.cantJoinFrequencyDueToPrivateFrequency)
                                    end
                                end
                            else
                                ESX.ShowNotification(Locale.onlyNumbers)
                            end
                        end
                    end
                end)
                if Config.Radio.canChangeVolume then
                    RageUI.Progress(Locale.changeRadioVolume .. " (" .. radioVolume .. "%)", radioVolume/10, 10, Locale.changeRadioVolumeDescription, true, true, function(Hovered, Active, Selected, Index)
                        radioVolume = math.round(Index * 10)
                        if Active then
                            exports['pma-voice']:setRadioVolume(radioVolume)
                        end
                    end)
                end
            end)
            Citizen.Wait(1)
        end
    end
end
Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        if isRadioActive or isRadioMenuOpened then
            fpsBoost = false
            AddEventHandler('pma-voice:radioActive', function(value)
                isTalkingOnRadio = value
            end)
            -- # // DEFINE THE ANIM TYPE \\ # --
            local broadcastType = 4 + (isRadioMenuOpened and -1 or 0)
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
                if isRadioMenuOpened then
                    local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
                    local animationType = 1 + (isRadioMenuOpened and 0 or 1)
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
                        isRadioMenuOpened = false
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
                    isRadioMenuOpened = false
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