-- # // CONFIG INIT [DON'T TOUCH] \\ # --
Config = {
    Radio = {},
    RageUI = {
        customBanner = {},
        defaultBanner = {}
    }
}

-- # // CONFIGURATION OF RADIO \\ # --
Config.Radio.useRadioAsItem = false -- true/false [boolean] -- > Do you want to use radio as item ?
Config.Radio.radioItemName = "radio" -- the item name [string] -- > If "useRadioAsItem" is true, set the radio item name
Config.Radio.openRadioMenuKeyValue = "F9" -- the key [string] -- > Set the key to open menu, you can set to nil to have only the item work6
Config.Radio.openRadioMenuKeyDesc = "Open the radio menu" -- description [string] -- > Set the description of the key

-- # // CONFIGURATION OF RAGEUI VISUAL \\ # --
Config.RageUI.menuTitle = "Radio menu" -- the menu title [string] -- > Set the menu title
Config.RageUI.menuSubtitle = "This the menu for your radio" -- the menu subtitle [string] -- > Set the menu subtitle
Config.RageUI.marginLeft = 10 -- the margin left [integer] -- > Set the margin between the left side of the screen and the right side of the menu
Config.RageUI.marginTop = 10 -- the margin top [integer] -- > Set the margin between the top of the screen and the top of the menu
Config.RageUI.customBanner.url = nil -- nil/an url [nil/string] -- > If you want, you can set here an url pointing to an image to have a custom RageUI banner.
Config.RageUI.customBanner.imageWidth = 512 -- width of custom banner [integer] -- > If "customBanner.url" is set, set this to the width of the image
Config.RageUI.customBanner.imageHeight = 128 -- height of custom banner [integer] -- > If "customBanner.url" is set, set this to the the height of the image
Config.RageUI.defaultBanner.colorR = 255 -- red color of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the red value (RGB) for the banner color
Config.RageUI.defaultBanner.colorG = 100 -- green color of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the green value (RGB) for the banner color
Config.RageUI.defaultBanner.colorB = 100 -- blue color of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the blue value (RGB) for the banner color
Config.RageUI.defaultBanner.colorA = 100 -- alpha of the banner [integer] -- > If "customBanner.url" isn't set (nil value), set this to the alpha value (transparency) for the banner