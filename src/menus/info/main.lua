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
    if (imgui.Button("Click Here to Edit Settings", ACTION_BUTTON_SIZE)) then
        cache.windows.showSettingsWindow = not cache.windows.showSettingsWindow
        local windowDim = state.WindowSize
        local pluginDim = imgui.GetWindowSize()
        local centeringX = (windowDim[1] - 433) * 0.5
        local centeringY = (windowDim[2] - 400) * 0.5
        local coordinatesToCenter = vector.New(centeringX, centeringY)
        imgui.SetWindowPos("plumoguSV Settings", coordinatesToCenter)
    end
    if (imgui.Button("Get Map Stats", HALF_ACTION_BUTTON_SIZE)) then
        getMapStats()
    end
    KeepSameLine()
    if (imgui.Button("View Tutorials", HALF_ACTION_BUTTON_SIZE)) then
        cache.windows.showTutorialWindow = not cache.windows.showTutorialWindow
        local windowDim = state.WindowSize
        local pluginDim = imgui.GetWindowSize()
        local centeringX = (windowDim[1] - 600) * 0.5
        local centeringY = (windowDim[2] - 500) * 0.5
        local coordinatesToCenter = vector.New(centeringX, centeringY)
        imgui.SetWindowPos("plumoguSV Settings", coordinatesToCenter)
    end
end
