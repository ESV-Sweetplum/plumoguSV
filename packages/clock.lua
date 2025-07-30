clock = {}

---Returns true every `interval` ms.
---@param id string The unique identifier of the clock.
---@param interval integer The interval at which the clock should run.
---@return boolean ev True if the clock has reached its interval time.
function clock.listen(id, interval)
    local currentTime = state
        .UnixTime -- Avoid calling state global multiple times, which causes a heavy load on performance
    local stateId = table.concat({ "clock_", id })
    if (not state.GetValue(stateId)) then
        state.SetValue(stateId,
            currentTime)
    end
    local previousExecutionTime = state.GetValue(stateId)
    if (currentTime - previousExecutionTime > interval) then
        state.SetValue(stateId, currentTime)
        return true
    end

    return false
end
