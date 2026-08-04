PopAllStyleColors()
PopAllStyleVars()
PopAllItemWidths()

PLUGIN_NAME = 'plumoguSV-dev'

if globalVars.capybaraMode then
    cache.set('windows/settings', false)
    capybaraModeWindow()
    return
end

local performanceMode = globalVars.performanceMode

if not performanceMode then
    setPluginAppearance()
    drawCapybaraParent()
    drawCursorTrail()
    pulseController()
    checkForGlobalHotkeys()
    checkForActionWheel()
end

startNextWindowNotCollapsed(PLUGIN_NAME)
imgui.SetNextWindowSizeConstraints(vector.New(276, 0), vector.Max(table.vectorize2(state.WindowSize) / 2, vctr2(676))) -- RAHHHH 6 7 6 7 6 7 6 7 6 7 6 7

if not performanceMode then renderBackground() end
imgui.Begin(PLUGIN_NAME, 72)

if not performanceMode then addGradient() end

PushItemWidth(DEFAULT_WIDGET_WIDTH)
imgui.BeginTabBar('SV tabs', imgui_tab_bar_flags.FittingPolicyScroll)
for i = 1, #TAB_MENUS do
    createMenuTab(TAB_MENUS[i])
end
imgui.EndTabBar()

imgui.SetWindowFontScale(1)

if not performanceMode then
    if globalVars.showVibratoWidget then
        PushItemWidth(DEFAULT_WIDGET_WIDTH)
        imgui.Begin('plumoguSV-vibrato', imgui_window_flags.AlwaysAutoResize)
        placeVibratoSVMenu(true)
        imgui.End()
        PopItemWidth()
    end
    if globalVars.showNoteDataWidget then renderNoteDataWidget() end
    if globalVars.showMeasureDataWidget then renderMeasureDataWidget() end
end
if cache.get('windows/tutorial') then showTutorialWindow() end
if cache.get('windows/settings') then showPluginSettingsWindow() end
if cache.get('windows/patch_notes') then showPatchNotesWindow() end
PopItemWidth()
-- if not performanceMode and map.ToString():sub(1, 49) == 'elxnce2 - DJ ELXNCE BRINGS BACK EARLY 2021 VIBES ' then
--     runTest()
-- end
imgui.End()

logoThread()

local groups = cache.lists_timingGroups
if state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex] then
    globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
end

_QParcelConfig.ignoreNotesOutsideTg = globalVars.ignoreNotesOutsideTg
_QParcelConfig.useEndTimeOffsets = globalVars.useEndTimeOffsets

cache.set('map_edited', false)
