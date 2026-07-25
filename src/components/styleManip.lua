COLOR_STACK_SIZE = 0
VAR_STACK_SIZE = 0

---Pushes a style color and increments the stack size.
---@param idx ImGuiCol
---@param val Vector4
function PushStyleColor(idx, val)
    imgui.PushStyleColor(idx, val)
    COLOR_STACK_SIZE = COLOR_STACK_SIZE + 1
end

function PopStyleColor(count)
    if not count then count = 1 end
    if count > COLOR_STACK_SIZE then count = COLOR_STACK_SIZE end
    if count == 0 then return end
    imgui.PopStyleColor(count)
    COLOR_STACK_SIZE = COLOR_STACK_SIZE - count
end

function PopAllStyleColors() PopStyleColor(COLOR_STACK_SIZE) end

---Pushes a style var and increments the stack size.
---@param idx ImGuiStyleVar
---@param val number|Vector2
function PushStyleVar(idx, val)
    imgui.PushStyleVar(idx, val)
    VAR_STACK_SIZE = VAR_STACK_SIZE + 1
end

function PopStyleVar(count)
    if not count then count = 1 end
    if count > VAR_STACK_SIZE then count = VAR_STACK_SIZE end
    if count == 0 then return end
    imgui.PopStyleVar(count)
    VAR_STACK_SIZE = VAR_STACK_SIZE - count
end

function PopAllStyleVars() PopStyleVar(VAR_STACK_SIZE) end
