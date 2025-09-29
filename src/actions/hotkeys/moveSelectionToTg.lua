function moveSelectionToTg()
    actions.Perform(createEA(action_type.MoveObjectsToTimingGroup, state.SelectedHitObjects, state.SelectedScrollGroupId))
end
