Citizen.CreateThread(function()
	while true do
		if isRadioActive or isMenuOpened then
			local player = PlayerPedId()
			fpsBoost = false
			AddEventHandler("pma-voice:radioActive", function(value)
				isTalkingOnRadio = value
			end)
			PlayAnimWhenTalking(player)
			DisconnectIfNoItem()
			DisconnectRadioIfDead(player)
		end
		if fpsBoost then
			Citizen.Wait(1000)
			return
		end
		Citizen.Wait(100)
		fpsBoost = true
	end
end)
