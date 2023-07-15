-- Key registering
if Config.Radio.Key ~= nil then
	Keys.Register(Config.Radio.key, "-openRadioMenu", TranslateCap("key_description"), function()
		if not Config.Radio.useRadioAsItem then
			openRadioMenu()
			return
		end
		ESX.TriggerServerCallback("epyi_rpradio:hasItem", function(result)
			if not result then
				ESX.ShowNotification(TranslateCap("missing_radio_item"))
				return
			end
			openRadioMenu()
		end, Config.Radio.radioItemName, 1)
	end)
end
