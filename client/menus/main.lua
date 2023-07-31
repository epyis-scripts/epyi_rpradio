---main_showContentThisFrame → Function to show the main menu content
---@return void
function main_showContentThisFrame()
	RageUI.Separator("")
	if _var.menus.radio.isRadioActive then
		RageUI.Separator(_U("radio_state") .. _("state_on"))
	else
		RageUI.Separator(_U("radio_state") .. _("state_off"))
	end
	RageUI.Separator(_U("radio_frequency") .. _var.menus.radio.activeFrequencyString)
	if Config.radio.canChangeVolume then
		RageUI.Separator(_U("radio_volume") .. _var.menus.radio.radioVolume .. "%")
	end
	RageUI.Separator("")
	if not _var.menus.radio.isRadioActive then
		RageUI.ButtonWithStyle(
			_U("enable_radio"),
			_U("enable_radio_desc"),
			{},
			not _var.menus.radio.cooldowns.items,
			function(_, _, Selected)
				if Selected then
					if _var.menus.radio.activeFrequency == 0 then
						ESX.ShowNotification(_U("no_frequency_selected_notif"))
						return
					end
					_var.menus.radio.isRadioActive = true
					if Config.radio.sounds.radioOn then
						SendNUIMessage({ sound = "audio_on", volume = 0.3 })
					end
					exports["pma-voice"]:setRadioChannel(_var.menus.radio.activeFrequency)
					exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
				end
			end
		)
	else
		RageUI.ButtonWithStyle(
			_U("disable_radio"),
			_U("disable_radio_desc"),
			{},
			not _var.menus.radio.cooldowns.items,
			function(_, _, Selected)
				if Selected then
					_var.menus.radio.isRadioActive = false
					if Config.radio.sounds.radioOff then
						SendNUIMessage({ sound = "audio_off", volume = 0.3 })
					end
					exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
				end
			end
		)
	end
	RageUI.ButtonWithStyle(
		_U("change_frequency"),
		_U("change_frequency_desc"),
		{},
		not _var.menus.radio.isRadioActive and not _var.menus.radio.cooldowns.items,
		function(_, _, Selected)
			if Selected then
				_var.menus.radio.cooldowns.items = true
				Citizen.CreateThread(function()
					local newFrequency = textEntry(_U("text_entry_desc"), "", Config.radio.maxFrequencySize)
					if newFrequency == nil or newFrequency == "" then
						_var.menus.radio.cooldowns.items = false
						return
					end
					if string.find(newFrequency, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("only_numbers"))
						_var.menus.radio.cooldowns.items = false
						return
					end
					local firstCharacter = string.sub(newFrequency, 1, 1)
					if firstCharacter == "0" then
						ESX.ShowNotification(_U("first_character_error"))
						_var.menus.radio.cooldowns.items = false
						return
					end
					local canJoinFrequency = false
					if Config.radio.privateJobsFrequency[tonumber(newFrequency)] ~= nil then
						local PlayerData = ESX.GetPlayerData()
						for _, v in pairs(Config.radio.privateJobsFrequency[tonumber(newFrequency)]) do
							if v == PlayerData.job.name then
								canJoinFrequency = true
							end
						end
					else
						canJoinFrequency = true
					end
					if not canJoinFrequency then
						ESX.ShowNotification(_U("cant_join_frequency"))
						_var.menus.radio.cooldowns.items = false
						return
					end
					_var.menus.radio.activeFrequency = tonumber(newFrequency)
					_var.menus.radio.cooldowns.items = false
				end)
			end
		end
	)
	if Config.radio.canChangeVolume then
		RageUI.Progress(
			_U("change_radio_volume") .. " (" .. _var.menus.radio.radioVolume .. "%)",
			_var.menus.radio.radioVolume / 10,
			10,
			_U("change_radio_volume_desc"),
			true,
			not _var.menus.radio.cooldowns.items,
			function(_, Active, _, Index)
				_var.menus.radio.radioVolume = math.round(Index * 10)
				if Active then
					exports["pma-voice"]:setRadioVolume(_var.menus.radio.radioVolume)
				end
			end
		)
	end
end
