require("packages.table.contains")

---Returns true if the given key combo is pressed (e.g. "Ctrl+Shift+L")
---@param keyCombo string
---@return boolean
function kbm.pressedKeyCombo(keyCombo)
    keyCombo = keyCombo:upper()
    local comboList = {}
    for v in keyCombo:gmatch("%u+") do
        table.insert(comboList, v)
    end
    local keyReq = comboList[#comboList]
    local ctrlHeld = utils.IsKeyDown(keys.LeftControl) or utils.IsKeyDown(keys.RightControl)
    local shiftHeld = utils.IsKeyDown(keys.LeftShift) or utils.IsKeyDown(keys.RightShift)
    local altHeld = utils.IsKeyDown(keys.LeftAlt) or utils.IsKeyDown(keys.RightAlt)
    if (table.contains(comboList, "CTRL") ~= ctrlHeld) then
        return false
    end
    if (table.contains(comboList, "SHIFT") ~= shiftHeld) then
        return false
    end
    if (table.contains(comboList, "ALT") ~= altHeld) then
        return false
    end
    return utils.IsKeyPressed(keys[keyReq])
end

kbm.executedKeyCombo = kbm.pressedKeyCombo
