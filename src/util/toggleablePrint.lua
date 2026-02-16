---Prints a message if creation messages are enabled.
---@param type "e!"|"w!"|"i!"|"s!"
---@param msg string
function toggleablePrint(type, msg)
    local creationMsg = msg:find('Create') and true or false
    if (creationMsg and globalVars.dontPrintCreation) then return end
    print(type, msg)
end
