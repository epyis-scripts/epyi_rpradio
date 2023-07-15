-- Key registering
if Config.Radio.key ~= nil then
	Keys.Register(Config.Radio.key, "-openRadioMenu", _U("key_desc"), function()
		if not Config.Radio.useRadioAsItem then
			openMenu()
			return
		end
		ESX.TriggerServerCallback("epyi_rpradio:hasItem", function(result)
			if not result then
				ESX.ShowNotification(_U("missing_radio_item"))
				return
			end
			openMenu()
		end, Config.Radio.radioItemName, 1)
	end)
end
