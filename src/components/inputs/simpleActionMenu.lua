---Creates a big button that runs a function when clicked. If the number of notes selected is less than `minimumNotes`, returns a textual placeholder instead.
---@param buttonText string The text that should be rendered on the button.
---@param minimumNotes integer The minimum number of notes that are required to select berfore the button appears.
---@param actionfunc fun(...): any The function to run on button press.
---@param menuVars? { [string]: any } Optional menu variable parameter.
---@param hideNoteReq? boolean Whether or not to hide the textual placeholder if the selected note requirement isn't met.
---@param disableKeyInput? boolean Whether or not to disallow keyboard inputs as a substitution to pressing the button.
---@param optionalKeyOverride? string (Assumes `disableKeyInput` is false) Optional string to change the activation keybind.
function simpleActionMenu(buttonText, minimumNotes, actionfunc, menuVars, hideNoteReq, disableKeyInput,
                          optionalKeyOverride)
    local enoughSelectedNotes = checkEnoughSelectedNotes(minimumNotes)
    local infoText = "Select " .. minimumNotes .. " or more " .. pluralize("note", minimumNotes)
    if (not enoughSelectedNotes) then
        if (not hideNoteReq) then imgui.Text(infoText) end
        return
    end
    FunctionButton(buttonText, ACTION_BUTTON_SIZE, actionfunc, menuVars)
    if (disableKeyInput) then return end
    local keyCombo = optionalKeyOverride or globalVars.hotkeyList[1 + tn(hideNoteReq)]
    local tooltip = ToolTip("Press \'" .. keyCombo ..
        "\' on your keyboard to do the same thing as this button")
    executeFunctionIfTrue(kbm.pressedKeyCombo(keyCombo), actionfunc, menuVars)
end

---Runs a function with the given parameters if the given `condition` is true.
---@param condition boolean The condition that is used.
---@param fn fun(...): nil The function to run if the condition is true.
---@param menuVars? { [string]: any } Optional menu variable parameter.
function executeFunctionIfTrue(condition, fn, menuVars)
    if not condition then return end
    if menuVars then
        fn(menuVars)
        return
    end
    fn()
end
