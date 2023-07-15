if Config.Radio.openRadioMenuKeyValue ~= nil then
	Keys.Register(Config.Radio.openRadioMenuKeyValue, "-openRadioMenu", Locale.openRadioMenuKeyDesc, function()
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
