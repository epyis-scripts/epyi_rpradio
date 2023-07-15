-- # // RADIO AS ITEM \\ # --
ESX.RegisterUsableItem("radio", function(source)
	TriggerClientEvent("epyi_rpradio:openMenu", source)
end)

-- # // HASITEM CALLBACK \\ # --
ESX.RegisterServerCallback("epyi_rpradio:hasItem", function(source, cb, itemName, itemCount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.hasItem(itemName)
	if not item or item.count < itemCount then
		cb(false)
		return
	end
	cb(true)
end)
