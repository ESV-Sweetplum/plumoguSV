---Returns the number of milliseconds the plugin has been active.
---@return number lifetime
function clock.getTime()
    return (state.UnixTime - clock.prevTime) / 1000
end
