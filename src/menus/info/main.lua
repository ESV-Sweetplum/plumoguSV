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
        state.SetValue("showSettingsWindow", true)
        local windowDim = state.WindowSize
        local pluginDim = imgui.GetWindowSize()
        local centeringX = (windowDim[1] - pluginDim.x) * 0.5
        local centeringY = (windowDim[2] - pluginDim.y) * 0.5
        local coordinatesToCenter = vector.New(centeringX, centeringY)
        imgui.SetWindowPos("plumoguSV Settings", coordinatesToCenter)
    end
    if (state.GetValue("showSettingsWindow")) then
        showPluginSettingsWindow()
    end
    if (imgui.Button("Click Here to Get Map Stats", ACTION_BUTTON_SIZE)) then
        local currentTg = state.SelectedScrollGroupId
        local tgList = map.GetTimingGroupIds()
        local svSum = 0
        local ssfSum = 0
        for _, tg in ipairs(tgList) do
            state.SelectedScrollGroupId = tg
            svSum = svSum + #map.ScrollVelocities
            ssfSum = ssfSum + #map.ScrollSpeedFactors
        end
        print("s!",
            "That's an average of " ..
            math.round(svSum * 1000 / map.TrackLength, 2) ..
            " SVs per second, or " .. math.round(ssfSum * 1000 / map.TrackLength, 2) .. " SSFs per second.")
        print("s!", "This map also contains " .. #map.TimingPoints .. " timing points.")
        print("s!",
            "This map has " .. svSum .. " SVs and " .. ssfSum .. " SSFs across " .. #tgList .. " timing groups.")
        print("w!",
            "Remember that the quality of map has no correlation with the object count! Try to be optimal in your object usage.")
        state.SelectedScrollGroupId = currentTg
    end
    if (imgui.Button("Click Here to View Various Tutorials", ACTION_BUTTON_SIZE)) then
        state.SetValue("showTutorialWindow", true)
    end
end
