Config = {
    Locale = {
        usedLocale = "fr"; -- the locale prefix [string] -- > What language do you want the resource to use? (en/fr avalaible)
    },
    Radio = {
        useRadioAsItem = true, -- true/false [boolean] -- > Do you want to use radio as item ?
        radioItemName = "radio", -- the item name [string] -- > If "useRadioAsItem" is true, set the radio item name
        openRadioMenuKeyValue = "F9", -- the key [string] -- > Set the key to open the radio. You can set to nil if you want the player to only be able to open the menu using the radio item
        openRadioMenuKeyDesc = "Open the radio menu", -- description [string] -- > Set the description of the key
        maxFrequencySize = 3, -- number of digits [integer] -- > Set the maximum number of numbers in the frequency (example: 3 makes three-digit frequencies like "374", 4 makes four-digit frequencies like "7854", 5 makes five-digit frequencies like "98763")
        disconnectRadioOnDeath = true, -- true/false [boolean] -- > Do you want the radio to automatically disconnect when the player dies?
        canChangeVolume = true, -- true/false [boolean] -- > Do you want players to be able to change their radio volume?
        Sounds = {
            radioOn = true, -- true/false [boolean] -- > Do you want the script play a sound when the radio is turned on ?
            radioOff = true, -- true/false [boolean] -- > Do you want the script play a sound when the radio is turned off ?
            radioClicks = true, -- true/false [boolean] -- > Do you want the script play a sound when the player is talking on the radio ?
        },
        PrivateJobsFrequency = {
            [1] = {"police", "fbi"},
            [2] = {"police", "fbi"},
            [3] = {"police", "fbi"},
            [4] = {"ambulance", "police", "fbi"},
            [5] = {"fbi"},
        },
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