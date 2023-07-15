Locales = {}

function Translate(str, ...)
	if not str then
		print(
			("[^1ERROR^7] Resource ^5%s^7 You did not specify a parameter for the Locale function or the value is nil!"):format(
				GetInvokingResource() or GetCurrentResourceName()
			)
		)
		return "Given translate function parameter is nil!"
	end
	if Locales[Config.Locale] then
		if Locales[Config.Locale][str] then
			return string.format(Locales[Config.Locale][str], ...)
		elseif Config.Locale ~= "en" and Locales["en"] and Locales["en"][str] then
			return string.format(Locales["en"][str], ...)
		else
			return "Translation [" .. Config.Locale .. "][" .. str .. "] does not exist"
		end
	elseif Config.Locale ~= "en" and Locales["en"] and Locales["en"][str] then
		return string.format(Locales["en"][str], ...)
	else
		return "Locale [" .. Config.Locale .. "] does not exist"
	end
end

function TranslateCap(str, ...)
	return _(str, ...):gsub("^%l", string.upper)
end

_ = Translate
_U = TranslateCap
