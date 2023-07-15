---main_showContentThisFrame → Function to show the main menu content
---@return void
function main_showContentThisFrame()
	RageUI.Separator("")
	if isRadioActive then
		RageUI.Separator(TranslateCap("radio_state") .. Translate("state_on"))
	else
		RageUI.Separator(TranslateCap("radio_state") .. Translate("state_off"))
	end
	RageUI.Separator(TranslateCap("radio_frequency") .. activeFrequencyString)
	if Config.Radio.canChangeVolume then
		RageUI.Separator(_U("radio_volume") .. radioVolume .. "%")
	end
	RageUI.Separator("")
	if not isRadioActive then
		RageUI.ButtonWithStyle(
			_U("enable_radio"),
			_U("enable_radio_desc"),
			{},
			true,
			function(_, _, Selected)
				if Selected then
					if activeFrequency ~= 0 then
						isRadioActive = true
						if Config.Radio.Sounds.radioOn then
							SendNUIMessage({ sound = "audio_on", volume = 0.3 })
						end
						exports["pma-voice"]:setRadioChannel(activeFrequency)
						exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
					else
						ESX.ShowNotification(_U("no_frequency_selected_notif"))
					end
				end
			end
		)
	else
		RageUI.ButtonWithStyle(
			_U("disable_radio"),
			_U("disable_radio_desc"),
			{},
			true,
			function(_, _, Selected)
				if Selected then
					isRadioActive = false
					if Config.Radio.Sounds.radioOff then
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
		not isRadioActive,
		function(_, _, Selected)
			if Selected then
				local newFrequency = TextEntry(_U("text_entry_desc"), "", Config.Radio.maxFrequencySize)
				if newFrequency ~= nil then
					if OnlyContainNumber(newFrequency) then
						local firstCharacter = string.sub(newFrequency, 1, 1)
						if firstCharacter == "0" then
							ESX.ShowNotification(_U("first_character_error"))
						else
							local canJoinFrequency = false
							if Config.Radio.PrivateJobsFrequency[tonumber(newFrequency)] ~= nil then
								local PlayerData = ESX.GetPlayerData()
								for k, v in pairs(Config.Radio.PrivateJobsFrequency[tonumber(newFrequency)]) do
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
								ESX.ShowNotification(_U("cant_join_frequency"))
							end
						end
					else
						ESX.ShowNotification(_U("only_numbers"))
					end
				end
			end
		end
	)
	if Config.Radio.canChangeVolume then
		RageUI.Progress(
			_U("change_radio_volume") .. " (" .. radioVolume .. "%)",
			radioVolume / 10,
			10,
			_U("change_radio_volume_desc"),
			true,
			true,
			function(_, Active, _, Index)
				radioVolume = math.round(Index * 10)
				if Active then
					exports["pma-voice"]:setRadioVolume(radioVolume)
				end
			end
		)
	end
end

for k,v in ipairs() do
end