-- # // VERSION CHECKER \\ # --
Citizen.CreateThread( function()
    function checkVersion(err,responseText, headers)
        curVersion = LoadResourceFile(GetCurrentResourceName(), "version")
        if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            print("^5epyi_rpradio ^4n'est pas à jour. La dernière version est "..responseText.." mais votre version est "..curVersion.." -- > Mettez la ressource à jour via ce lien github : https://github.com"..updatePath)
        elseif tonumber(curVersion) > tonumber(responseText) then
            print("^5epyi_rpradio ^4Il semble que le serveur de mise à jour soit inaccessible. Nous ne pouvons pas vérifier si la ressource est à jour.")
        end
    end
    PerformHttpRequest("https://raw.githubusercontent.com/J4thgit/epyi_rpradio/main/version", checkVersion, "GET")
end)