-- Threads pre init
_threads = {
	radio_active = {},
}

-- Thread initialization
-- Thread → Radio active
_threads.radio_active.isActivated = false
_threads.radio_active.enable = function()
	Citizen.CreateThread(function()
		if _threads.radio_active.isActivated then
			return
		end
		_threads.radio_active.isActivated = true
		while _threads.radio_active.isActivated do
			local player = PlayerPedId()
			AddEventHandler("pma-voice:radioActive", function(value)
				_var.menus.radio.isTalkingOnRadio = value
			end)
			playAnimWhenTalking(player)
			disconnectIfNoItem()
			disconnectRadioIfDead(player)
			Citizen.Wait(1000)
		end
	end)
end
_threads.radio_active.disable = function()
	_threads.radio_active.isActivated = false
end
