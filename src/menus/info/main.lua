function infoTab()
    imgui.SeparatorText("Welcome to plumoguSV!")
    imgui.TextWrapped("This plugin is your one-stop shop for all of \nyour SV needs. Using it is quick and easy:")
    AddPadding()
    imgui.BulletText("Choose an SV tool in the Create tab.")
    imgui.BulletText("Adjust the tool's settings to your liking.")
    imgui.BulletText("Select notes to use the tool at.")
    imgui.BulletText("Press the '" .. globalVars.hotkeyList[1] .. "' hotkey.")
    AddPadding()
    imgui.SeparatorText("Special thanks to:")
    AddPadding()
    imgui.BulletText("kloi34, for being the original dev.")
    imgui.BulletText("kusa, for some handy widgets.")
    imgui.BulletText("7xbi + nethen for some useful PRs.")
    imgui.BulletText("Emik + William for plugin help.")
    imgui.BulletText("ESV members for constant support.")
    AddPadding()
    AddPadding()
    if (imgui.Button("Edit Settings", HALF_ACTION_BUTTON_SIZE)) then
        cache.windows.showSettingsWindow = not cache.windows.showSettingsWindow
        local coordinatesToCenter = game.window.getCenter() - vector.New(216.5, 200)
        imgui.SetWindowPos("plumoguSV Settings", coordinatesToCenter)
    end
    KeepSameLine()
    if (imgui.Button("See Patch Notes", HALF_ACTION_BUTTON_SIZE)) then
        cache.windows.showPatchNotesWindow = not cache.windows.showPatchNotesWindow
        local coordinatesToCenter = game.window.getCenter() - vector.New(300, 250)
        imgui.SetWindowPos("plumoguSV Patch Notes", coordinatesToCenter)
    end
    if (imgui.Button("Get Map Stats", HALF_ACTION_BUTTON_SIZE)) then
        getMapStats()
    end
    KeepSameLine()
    if (imgui.Button("View Tutorials", HALF_ACTION_BUTTON_SIZE)) then
        cache.windows.showTutorialWindow = not cache.windows.showTutorialWindow
        local coordinatesToCenter = game.window.getCenter() - vector.New(300, 250)
        imgui.SetWindowPos("plumoguSV Tutorial Menu", coordinatesToCenter)
    end
end
