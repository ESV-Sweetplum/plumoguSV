require('packages.table.contains')

---Returns true if the given key combo is pressed (e.g. "Ctrl+Shift+L")
---@param keyCombo string
---@return boolean
function kbm.pressedKeyCombo(keyCombo)
    if (imgui.IsAnyItemActive() or not keyCombo or keyCombo == 'NONE') then return false end
    keyCombo = keyCombo:upper()
    local comboList = {}
    for v in keyCombo:gmatch('[%u%d]+') do
        table.insert(comboList, v)
    end
    local keyReq = comboList[#comboList]
    local ctrlHeld = utils.IsKeyDown(keys.LeftControl) or utils.IsKeyDown(keys.RightControl)
    local shiftHeld = utils.IsKeyDown(keys.LeftShift) or utils.IsKeyDown(keys.RightShift)
    local altHeld = utils.IsKeyDown(keys.LeftAlt) or utils.IsKeyDown(keys.RightAlt)
    if (table.contains(comboList, 'CTRL') ~= ctrlHeld) then
        return false
    end
    if (table.contains(comboList, 'SHIFT') ~= shiftHeld) then
        return false
    end
    if (table.contains(comboList, 'ALT') ~= altHeld) then
        return false
    end
    local keyReqNum = keys[keyReq]
    if (keyReq:find('^%d$')) then
        keyReqNum = tn(keyReq) + 48
    end
    if (not keyReqNum) then
        return false
    end
    return utils.IsKeyPressed(keyReqNum)
end

kbm.executedKeyCombo = kbm.pressedKeyCombo
