---TextEntry
---@param textEntry string
---@param inputText string
---@param maxLength integer
---@return string
function TextEntry(textEntry, inputText, maxLength)
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

---OnlyContainNumber
---@param source string
---@return boolean
function OnlyContainNumber(source)
	if not string.match(source, "^%d+$") then
		return false
	end
	return true
end

---epyi_rpradio:OpenMenu → Execute the openMenu function
---@return void
RegisterNetEvent("epyi_rpradio:OpenMenu")
AddEventHandler("epyi_rpradio:OpenMenu", function()
	openRadioMenu()
end)

---CloseRadioMenuAnimation → Play animation when closing radio menu
---@return void
function CloseRadioMenuAnimation()
	DetachEntity(propHandle, true, false)
	DeleteEntity(propHandle)
	local player = PlayerPedId()
	local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
	local animationType = 1 + (isMenuOpened and 0 or 1)
	local dictionary = animDictionary[dictionaryType]
	local animation = animAnimation[animationType]
	while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(100)
	end
	TaskPlayAnim(player, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
	Citizen.Wait(700)
	StopAnimTask(player, dictionary, animation, 1.0)
end

---OpenRadioMenuAnimation → Play animation when openning the radio menu
---@return void
function OpenRadioMenuAnimation()
	local player = PlayerPedId()
	local dictionaryType = 1 + (IsPedInAnyVehicle(player, false) and 1 or 0)
	local animationType = 1 + (isMenuOpened and 0 or 1)
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
