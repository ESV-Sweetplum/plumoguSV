function applyTheme(themeData, imguiOnly)
    if themeData.imguiData then
        for styleKey, colorObj in pairs(themeData.imguiData) do
            local imguiId = imgui_col[styleKey]
            if imguiId then
                imgui.PushStyleColor(imguiId, colorObj)
            end
        end
    end

    if themeData.loadupData and not imguiOnly then
        for varName, colorObj in pairs(themeData.loadupData) do
            globalCustomStyle['loadup' .. varName] = colorObj
        end
    end

    if (not imguiOnly) then
        globalCustomStyle.border = themeData.border
        globalCustomStyle.pulse = themeData.pulse
    end

    return themeData
end
