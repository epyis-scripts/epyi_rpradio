-- # // VARIABLES INIT \\ --
local isRadioMenuOpened = false

-- # // CHECK RESOURCE VALIDITY \\ # --
if canStartResource then
    -- # // INIT RAGEUI MENU \\ # --
    if Config.RageUI.customBanner.url == nil then
        RMenu.Add('epyi_rpradio', 'main', RageUI.CreateMenu(Config.RageUI.menuTitle, Config.RageUI.menuSubtitle, Config.RageUI.marginLeft, Config.RageUI.marginTop))
        RMenu:Get('epyi_rpradio', 'main').Closed = function()
            isRadioMenuOpened = false
        end;
        RMenu:Get("epyi_rpradio", "main"):SetRectangleBanner(Config.RageUI.defaultBanner.colorR, Config.RageUI.defaultBanner.colorG, Config.RageUI.defaultBanner.colorB, Config.RageUI.defaultBanner.colorA)
    else
        local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head')
        local Object = CreateDui(Config.Menu.menuCustomBanner, Config.RageUI.customBanner.imageWidth, Config.RageUI.customBanner.imageHeight)
        _G.Object = Object
        local TextureThing = GetDuiHandle(Object)
        local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head', TextureThing)
        local Menuthing = "Custom_Menu_Head"
        RMenu.Add('epyi_rpradio', 'main', RageUI.CreateMenu(Config.RageUI.menuTitle, Config.RageUI.menuSubtitle, Config.RageUI.marginLeft, Config.RageUI.marginTop, Menuthing, Menuthing))
        RMenu:Get('epyi_rpradio', 'main').Closed = function()
            isRadioMenuOpened = false
        end;
    end
    -- # // MENU FUNCTION \\ # --
    function openRadioMenu()
        if isRadioMenuOpened then
            RageUI.CloseAll()
            isRadioMenuOpened = false
        else
            isRadioMenuOpened = true
            RageUI.Visible(RMenu:Get('epyi_rpradio', 'main'), true, true, false)
            while isRadioMenuOpened do
                RageUI.IsVisible(RMenu:Get('epyi_rpradio', 'main'), true, true, true, function()
                end)
                Citizen.Wait(1)
            end
        end
    end
    -- # // KEY REGISTERING \\ # --
    if Config.Radio.openRadioMenuKeyValue ~= nil then
        Keys.Register(Config.Radio.openRadioMenuKeyValue, "-openRadioMenu", Config.Radio.openRadioMenuKeyDesc, function()
            openRadioMenu()
        end)
    end
else
    print("^5 epyi_rpradio ^4The resource could not be started correctly. Make sure the resource name is epyi_rpradio.")
end