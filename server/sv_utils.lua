-- # // HASITEM CALLBACK \\ # --
ESX.RegisterServerCallback("epyi_rpradio:hasItem", function(source, cb, itemName, itemCount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.hasItem(itemName)
	if not item then
		cb(false)
		return
	end
	if item.count < itemCount then
		cb(false)
		return
	end
	cb(true)
end)
