function moveSelectionToTg()
    if (not truthy(state.SelectedHitObjects)) then return end
    actions.MoveObjectsToTimingGroup(state.SelectedHitObjects, state.SelectedScrollGroupId)
end
