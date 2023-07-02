Config = {
    Radio = {
        useRadioAsItem = true, -- true/false [boolean] -- > Do you want to use radio as item ?
        radioItemName = "radio", -- the item name [string] -- > If "useRadioAsItem" is true, set the radio item name
        openRadioMenuKeyValue = "F9", -- the key [string] -- > Set the key to open menu, you can set to nil to have only the item work6
        openRadioMenuKeyDesc = "Open the radio menu", -- description [string] -- > Set the description of the key
        maxFrequencySize = 3, -- number of digits [integer] -- > Set the maximum number of numbers in the frequency (example: 3 should be frequency like 374, 4 should be 7854, 5 should be 98763)
    },
    RageUI = {
        menuTitle = "Radio menu", -- the menu title [string] -- > Set the menu title
        menuSubtitle = "This is the menu for your radio", -- the menu subtitle [string] -- > Set the menu subtitle
        marginLeft = 10, -- the margin left [integer] -- > Set the margin between the left side of the screen and the right side of the menu
        marginTop = 10, -- the margin top [integer] -- > Set the margin between the top of the screen and the top of the menu
        customBanner = {
            url = nil, -- nil/an url [nil/string] -- > If you want, you can set here an url pointing to an image to have a custom RageUI banner.
            imageWidth = 512, -- width of custom banner [integer] -- > If "customBanner.url" is set, set this to the width of the image
            imageHeight = 128, -- height of custom banner [integer] -- > If "customBanner.url" is set, set this to the the height of the image
        },
        defaultBanner = {
            colorR = 255, -- red color of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the red value (RGB) for the banner color
            colorG = 100, -- green color of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the green value (RGB) for the banner color
            colorB = 100, -- blue color of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the blue value (RGB) for the banner color
            colorA = 100, -- alpha of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the alpha value (transparency) for the banner
        }
    }
}

Locale = {
    missingRadioItem = "You don't have a radio in your inventory",
    changeFrequency = "Change the radio frequency",
    changeFrequencyDescription = "Press ~r~[ENTER] ~s~to change the frequency of the radio",
    noFrequencySelectedMenu = "No frequency selected",
    noFrequencySelectedNotification = "You cannot turn the radio on if the frequency isn't set",
    frequencySymbol = " Hz",
    frequencyColor = "~r~",
    textEntryDescription = "Please specify the ~r~new frequency",
    enableRadio = "Switch on the radio",
    enableRadioDescription = "Press ~r~[ENTER] ~s~to switch on the radio",
    disableRadio = "Switch off the radio",
    disableRadioDescription = "Press ~r~[ENTER] ~s~to switch off the radio",
    onlyNumbers = "You can only use number in the frequency.",
    firstCharacterError = "The first number of a frequency cannot be 0",
    radioState = "Radio status: ",
    radioFrequency = "Radio active frequency: ",
    stateOn = "~g~ON",
    stateOff = "~r~OFF",
}