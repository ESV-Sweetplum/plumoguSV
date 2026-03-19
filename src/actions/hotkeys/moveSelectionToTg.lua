function moveSelectionToTg()
    if (not isTruthy(state.SelectedHitObjects)) then return end
    actions.MoveObjectsToTimingGroup(state.SelectedHitObjects, state.SelectedScrollGroupId)
end
