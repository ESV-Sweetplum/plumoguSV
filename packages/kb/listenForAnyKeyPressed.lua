function kb.listenForAnyKeyPressed()
    local isCtrlHeld = utils.IsKeyDown(keys.LeftControl) or utils.IsKeyDown(keys.RightControl)
    local isShiftHeld = utils.IsKeyDown(keys.LeftShift) or utils.IsKeyDown(keys.RightShift)
    local isAltHeld = utils.IsKeyDown(keys.LeftAlt) or utils.IsKeyDown(keys.RightAlt)

    local key = -1

    local prefixes = {}
    if (isCtrlHeld) then table.insert(prefixes, "Ctrl") end
    if (isShiftHeld) then table.insert(prefixes, "Shift") end
    if (isAltHeld) then table.insert(prefixes, "Alt") end

    for i = 65, 90 do
        if (utils.IsKeyPressed(i)) then
            key = i
        end
    end

    return prefixes, key
end
