-- Creates an imgui button
-- Parameters
--    text       : text on the button [String]
--    size       : dimensions of the button [Table]
--    func       : function to execute once button is pressed [Function]
--    globalVars : list of variables used globally across all menus [Table]
--    menuVars   : list of variables used for the current menu [Table]
function button(text, size, func, globalVars, menuVars)
    if not imgui.Button(text, size) then return end
    if globalVars and menuVars then
        func(globalVars, menuVars)
        return
    end
    if globalVars then
        func(globalVars)
        return
    end
    if menuVars then
        func(menuVars)
        return
    end
    func()
end
