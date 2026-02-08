function infoTab()
    imgui.SeparatorText("Welcome to plumoguSV!")
    imgui.TextWrapped("This plugin is your one-stop shop for all of \nyour SV needs. Using it is quick and easy:")
    AddPadding()
    imgui.BulletText("Choose an SV tool in the Create tab.")
    imgui.BulletText("Adjust the tool's settings to your liking.")
    imgui.BulletText("Select notes to use the tool at.")
    imgui.BulletText("Press the '" .. globalVars.hotkeyList[hotkeys_enum.exec_primary] .. "' hotkey.")
    AddPadding()
    imgui.SeparatorText("Special thanks to:")
    AddPadding()
    imgui.BulletText("kloi34, for being the original dev.")
    imgui.BulletText("kusa, for some handy widgets.")
    imgui.BulletText("7xbi + nethen for some useful PRs.")
    imgui.BulletText("Emik + William for plugin help.")
    imgui.BulletText("ESV members for constant support.")
    imgui.Dummy(vctr2(10))
    if (not globalVars.disableKofiMessage) then
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 153) / 2)
        imgui.Text("If you enjoy using this plugin,")
        imgui.SetCursorPosX((imgui.GetWindowWidth() - 172) / 2)
        imgui.Text("consider supporting me on")
        imgui.SameLine(0, 3)
        imgui.TextLinkOpenURL("ko-fi!", "https://ko-fi.com/plummyyummy")
        imgui.Dummy(vctr2(10))
    end
    if (imgui.Button("Edit Settings", HALF_ACTION_BUTTON_SIZE)) then
        cache.windows.showSettingsWindow = not cache.windows.showSettingsWindow
        local coordinatesToCenter = game.window.getCenter() - vector.New(216.5, 200)
        imgui.SetWindowPos("plumoguSV Settings", coordinatesToCenter)
    end
    HoverToolTip("Edit various functions of the plugin, such as the appearance or internal calculations.")
    KeepSameLine()
    if (imgui.Button("See Patch Notes", HALF_ACTION_BUTTON_SIZE)) then
        cache.windows.showPatchNotesWindow = not cache.windows.showPatchNotesWindow
        local coordinatesToCenter = game.window.getCenter() - vector.New(300, 250)
        imgui.SetWindowPos("plumoguSV Patch Notes", coordinatesToCenter)
    end
    HoverToolTip("Keep up with the progress of plumoguSV, and see what the newest updates have in store for you.")
    if (imgui.Button("Get Map Stats", HALF_ACTION_BUTTON_SIZE)) then
        getMapStats()
    end
    HoverToolTip("A quick and easy way to view SV/SSF counts and some other minute pieces of data.")
    KeepSameLine()
    if (imgui.Button("View Tutorials", HALF_ACTION_BUTTON_SIZE)) then
        cache.windows.showTutorialWindow = not cache.windows.showTutorialWindow
        local coordinatesToCenter = game.window.getCenter() - vector.New(300, 250)
        imgui.SetWindowPos("plumoguSV Tutorial Menu", coordinatesToCenter)
    end
    HoverToolTip("New to SV? View interactive tutorials that will help you navigate the plugin for your first time.")
end
