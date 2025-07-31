---Removes and adds SVs.
---@param svsToRemove ScrollVelocity[]
---@param svsToAdd ScrollVelocity[]
function removeAndAddSVs(svsToRemove, svsToAdd)
    local tolerance = 0.035
    if #svsToAdd == 0 then return end
    for idx, sv in pairs(svsToRemove) do
        local baseSV = game.getSVStartTimeAt(sv.StartTime)
        if (math.abs(baseSV - sv.StartTime) > tolerance) then
            table.remove(svsToRemove, idx)
        end
    end
    local editorActions = {
        utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove),
        utils.CreateEditorAction(action_type.AddScrollVelocityBatch, svsToAdd)
    }
    actions.PerformBatch(editorActions)
    toggleablePrint("s!", "Created " .. #svsToAdd .. pluralize(" SV.", #svsToAdd, -2))
end

function removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
    if #ssfsToAdd == 0 then return end
    local editorActions = {
        utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, ssfsToAdd)
    }
    actions.PerformBatch(editorActions)
    toggleablePrint("s!", "Created " .. #ssfsToAdd .. pluralize(" SSF.", #ssfsToAdd, -2))
end
