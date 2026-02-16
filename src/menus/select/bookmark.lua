function selectBookmarkMenu()
    local bookmarks = map.Bookmarks

    local menuVars = getMenuVars('selectBookmark')
    local times = {}

    if (not isTruthy(bookmarks)) then
        imgui.TextWrapped('There are no bookmarks! Add one to navigate.')
    else
        imgui.PushItemWidth(70)
        _, menuVars.searchTerm = imgui.InputText('Search', menuVars.searchTerm, 4096)
        KeepSameLine()
        _, menuVars.filterTerm = imgui.InputText('Ignore', menuVars.filterTerm, 4096)

        imgui.Columns(3)

        imgui.Text('Time')
        imgui.NextColumn()
        imgui.Text('Bookmark Label')
        imgui.NextColumn()
        imgui.Text('Leap')
        imgui.NextColumn()

        imgui.Separator()

        local skippedBookmarks = 0
        local skippedIndices = 0

        for idx, bm in ipairs(bookmarks) do
            if (bm.StartTime < 0) then
                skippedBookmarks = skippedBookmarks + 1
                skippedIndices = skippedIndices + 1
                goto nextBookmark
            end

            if (menuVars.searchTerm:len() > 0) and (not bm.Note:find(menuVars.searchTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto nextBookmark
            end
            if (menuVars.filterTerm:len() > 0) and (bm.Note:find(menuVars.filterTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto nextBookmark
            end

            vPos = 126.5 + (idx - skippedBookmarks) * 32

            imgui.SetCursorPosY(vPos)

            table.insert(times, bm.StartTime)
            imgui.Text(bm.StartTime)
            imgui.NextColumn()

            imgui.SetCursorPosY(vPos)

            bmData = {}

            imgui.Text(bm.Note:fixToSize(95))

            imgui.NextColumn()

            buttonText = 'Go to #' .. idx - skippedIndices

            if (imgui.Button(buttonText, vector.New(imgui.CalcTextSize(buttonText).x + 20, 24))) then
                actions.GoToObjects(bm.StartTime)
            end
            imgui.NextColumn()

            if (idx ~= #bookmarks) then imgui.Separator() end
            ::nextBookmark::
        end

        local maxTimeLength = math.log(math.max(table.unpack(times) or 0), 10) + 0.5

        imgui.SetColumnWidth(0, maxTimeLength * 11)
        imgui.SetColumnWidth(1, 110)
        imgui.SetColumnWidth(2, 80)

        imgui.PopItemWidth()
        imgui.Columns(1)
    end

    cache.saveTable('selectBookmarkMenu', menuVars)
end
