function jumpToTg()
    local tgId = state.SelectedHitObjects[1].TimingGroup
    for _, ho in pairs(state.SelectedHitObjects) do
        if (ho.TimingGroup ~= tgId) then return end
    end
    state.SelectedScrollGroupId = tgId
end
