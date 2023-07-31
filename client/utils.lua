---textEntry
---@param textEntry string
---@param inputText string
---@param maxLength integer
---@return string
function textEntry(textEntry, inputText, maxLength)
	AddTextEntry("FMMC_KEY_TIP1", textEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(1.0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end

---epyi_rpradio:OpenMenu → Execute the openMenu function
---@return void
RegisterNetEvent("epyi_rpradio:openMenu")
AddEventHandler("epyi_rpradio:openMenu", function()
	openMenu()
end)

---closeRadioMenuAnimation → Play animation when closing radio menu
---@return void
function closeRadioMenuAnimation()
	DetachEntity(_var.menus.radio.propHandle, true, false)
	DeleteEntity(_var.menus.radio.propHandle)
	local player = PlayerPedId()
	local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
	local animationType = 1 + (_var.menus.radio.rageObject and 0 or 1)
	local dictionary = _var.menus.radio.animDictionary[dictionaryType]
	local animation = _var.menus.radio.animAnimation[animationType]
	while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(100)
	end
	TaskPlayAnim(player, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
	Citizen.Wait(700)
	StopAnimTask(player, dictionary, animation, 1.0)
end

---openRadioMenuAnimation → Play animation when openning the radio menu
---@return void
function openRadioMenuAnimation()
	local player = PlayerPedId()
	local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
	local animationType = 1 + (_var.menus.radio.rageObject and 0 or 1)
	local dictionary = _var.menus.radio.animDictionary[dictionaryType]
	local animation = _var.menus.radio.animAnimation[animationType]
	RequestModel(GetHashKey("prop_cs_hand_radio"))
	while not HasModelLoaded(GetHashKey("prop_cs_hand_radio")) do
		Citizen.Wait(100)
	end
	_var.menus.radio.propHandle = CreateObject(GetHashKey("prop_cs_hand_radio"), 0.0, 0.0, 0.0, true, true, false)
	local bone = GetPedBoneIndex(player, 28422)
	SetCurrentPedWeapon(player, unarmed, true)
	AttachEntityToEntity(
		_var.menus.radio.propHandle,
		player,
		bone,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		true,
		false,
		false,
		false,
		2,
		true
	)
	RequestAnimDict(dictionary)
	while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(100)
	end
	TaskPlayAnim(player, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
end

---disconnectRadioIfDead
---@param player ped
---@return void
function disconnectRadioIfDead(player)
	if not Config.radio.disconnectRadioOnDeath then
		return
	end
	if not IsEntityDead(player) then
		return
	end
	RageUI.Visible(_var.menus.radio.rageObject, false)
	exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
	_var.menus.radio.activeFrequency = 0
	_var.menus.radio.isRadioActive = false
	closeRadioMenuAnimation()
end

---disconnectIfNoItem
---@return void
function disconnectIfNoItem()
	if not Config.radio.useRadioAsItem then
		return
	end
	ESX.TriggerServerCallback("epyi_rpradio:hasItem", function(result)
		if result then
			return
		end
		RageUI.Visible(_var.menus.radio.rageObject, false)
		exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
		_var.menus.radio.activeFrequency = 0
		_var.menus.radio.isRadioActive = false
		closeRadioMenuAnimation()
	end, Config.radio.radioItemName, 1)
end

---playAnimWhenTalking
---@param player ped
---@return void
function playAnimWhenTalking(player)
	local broadcastType = 4 + (_var.menus.radio.rageObject and -1 or 0)
	local broadcastDictionary = _var.menus.radio.animDictionary[broadcastType]
	local broadcastAnimation = _var.menus.radio.animAnimation[broadcastType]
	if _var.menus.radio.isTalkingOnRadio and not _var.menus.radio.isPlayingTalkingAnim then
		_var.menus.radio.isPlayingTalkingAnim = true
		RequestAnimDict(broadcastDictionary)
		while not HasAnimDictLoaded(broadcastDictionary) do
			Citizen.Wait(100)
		end
		TaskPlayAnim(player, broadcastDictionary, broadcastAnimation, 8.0, -8, -1, 49, 0, 0, 0, 0)
	elseif not _var.menus.radio.isTalkingOnRadio and _var.menus.radio.isPlayingTalkingAnim then
		_var.menus.radio.isPlayingTalkingAnim = false
		StopAnimTask(player, broadcastDictionary, broadcastAnimation, -4.0)
		if _var.menus.radio.rageObject then
			local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
			local animationType = 1 + (_var.menus.radio.rageObject and 0 or 1)
			local dictionary = _var.menus.radio.animDictionary[dictionaryType]
			local animation = _var.menus.radio.animAnimation[animationType]
			TaskPlayAnim(player, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
		end
	end
end

---stopThreadLegacy
---@return void
function stopThreadLegacy()
	if _var.menus.radio.isRadioActive then
		return
	end
	_threads.radio_active.disable()
end
