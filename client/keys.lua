-- Key registering
if Config.radio.key ~= nil then
	Keys.Register(Config.radio.key, "-openRadioMenu", _U("key_desc"), function()
		if not Config.radio.useRadioAsItem then
			openMenu()
			return
		end
		ESX.TriggerServerCallback("epyi_rpradio:hasItem", function(result)
			if not result then
				ESX.ShowNotification(_U("missing_radio_item"))
				return
			end
			openMenu()
		end, Config.radio.radioItemName, 1)
	end)
end
