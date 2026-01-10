function jumpToTg()
    if (not truthy(state.SelectedHitObjects)) then return end
    local tgId = game.get.uniqueNotesBetweenSelected()[1].TimingGroup
    for _, ho in pairs(state.SelectedHitObjects) do
        if (ho.TimingGroup ~= tgId) then return end
    end
    state.SelectedScrollGroupId = tgId
end
