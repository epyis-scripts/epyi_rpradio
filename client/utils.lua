---TextEntry
---@param textEntry string
---@param inputText string
---@param maxLength integer
---@return string
function TextEntry(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(1.0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

---OnlyContainNumber
---@param source string
---@return boolean
function OnlyContainNumber(source)
    if not string.match(source, "^%d+$") then
        return false
    end
    return true
end