function selectBookmarkMenu()
    local bookmarks = map.bookmarks

    local selectedIndex = state.GetValue("selectedIndex") or 0
    local searchTerm = state.GetValue("searchTerm") or ""
    local filterTerm = state.GetValue("filterTerm") or ""
    local times = {}

    if (#bookmarks == 0) then
        imgui.TextWrapped("There are no bookmarks! Add one to navigate.")
    else
        imgui.PushItemWidth(70)

        _, searchTerm = imgui.InputText("Search", searchTerm, 4096)
        KeepSameLine()
        _, filterTerm = imgui.InputText("Ignore", filterTerm, 4096)

        imgui.Columns(3)

        imgui.Text("Time")
        imgui.NextColumn()
        imgui.Text("Bookmark Label")
        imgui.NextColumn()
        imgui.Text("Leap")
        imgui.NextColumn()

        imgui.Separator()

        local skippedBookmarks = 0
        local skippedIndices = 0

        for idx, bm in pairs(bookmarks) do
            if (bm.StartTime < 0) then
                skippedBookmarks = skippedBookmarks + 1
                skippedIndices = skippedIndices + 1
                goto continue
            end

            if (searchTerm:len() > 0) and (not bm.Note:find(searchTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto continue
            end
            if (filterTerm:len() > 0) and (bm.Note:find(filterTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto continue
            end

            vPos = 126.5 + (idx - skippedBookmarks) * 32

            imgui.SetCursorPosY(vPos)

            table.insert(times, bm.StartTime)
            imgui.Text(bm.StartTime)
            imgui.NextColumn()

            imgui.SetCursorPosY(vPos)

            bmData = {}

            bmData.Note = bm.Note:fixToSize(110)

            imgui.NextColumn()

            if (imgui.Button("Go to #" .. idx - skippedIndices, vector.New(65, 24))) then
                actions.GoToObjects(bm .. StartTime)
            end
            imgui.NextColumn()

            if (idx ~= #bookmarks) then imgui.Separator() end
            ::continue::
        end

        local maxTimeLength = #tostring(math.max(table.unpack(times) or 0))

        imgui.SetColumnWidth(0, maxTimeLength * 10.25)
        imgui.SetColumnWidth(1, 110)
        imgui.SetColumnWidth(2, 80)

        imgui.PopItemWidth()
        imgui.Columns(1)
    end

    state.SetValue("selectedIndex", selectedIndex)
    state.SetValue("searchTerm", searchTerm)
    state.SetValue("filterTerm", filterTerm)
end
