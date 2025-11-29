function measureMenu()
    local menuVars = getMenuVars("measure")
    menuVars.unrounded = RadioButtons("View values:", menuVars.unrounded, { "Rounded", "Unrounded" }, { false, true })

    AddSeparator()
    if menuVars.unrounded then
        displayMeasuredStatsUnrounded(menuVars)
    else
        displayMeasuredStatsRounded(menuVars)
    end
    AddPadding()
    imgui.TextDisabled("*** Measuring disclaimer ***")
    HoverToolTip("Measured values might not be 100%% accurate & may not work on older maps")

    simpleActionMenu("Measure SVs between selected notes", 2, measureSVs, menuVars)
    cache.saveTable("measureMenu", menuVars)
end

function displayMeasuredStatsRounded(menuVars)
    imgui.Columns(2, "Measured SV Stats", false)
    imgui.Text("NSV distance:")
    imgui.Text("SV distance:")
    imgui.Text("Average SV:")
    imgui.Text("Start displacement:")
    imgui.Text("End displacement:")
    imgui.Text("True average SV:")
    imgui.NextColumn()
    imgui.Text(menuVars.roundedNSVDistance .. " msx")
    HelpMarker("The normal distance between the start and the end, ignoring SVs")
    imgui.Text(menuVars.roundedSVDistance .. " msx")
    HelpMarker("The actual distance between the start and the end, calculated with SVs")
    imgui.Text(menuVars.roundedAvgSV .. "x")
    imgui.Text(menuVars.roundedStartDisplacement .. " msx")
    HelpMarker("Calculated using plumoguSV displacement metrics, so might not always work")
    imgui.Text(menuVars.roundedEndDisplacement .. " msx")
    HelpMarker("Calculated using plumoguSV displacement metrics, so might not always work")
    imgui.Text(menuVars.roundedAvgSVDisplaceless .. "x")
    HelpMarker("Average SV calculated ignoring the start and end displacement")
    imgui.Columns(1)
end

function displayMeasuredStatsUnrounded(menuVars)
    CopiableBox("NSV distance", "##nsvDistance", menuVars.nsvDistance)
    CopiableBox("SV distance", "##svDistance", menuVars.svDistance)
    CopiableBox("Average SV", "##avgSV", menuVars.avgSV)
    CopiableBox("Start displacement", "##startDisplacement", menuVars.startDisplacement)
    CopiableBox("End displacement", "##endDisplacement", menuVars.endDisplacement)
    CopiableBox("True average SV", "##avgSVDisplaceless", menuVars.avgSVDisplaceless)
end

-- Creates a copy-pastable text box
-- Parameters
--    text    : text to put above the box [String]
--    label   : label of the input text [String]
--    content : content to put in the box [String]
function CopiableBox(text, label, content)
    imgui.TextWrapped(text)
    imgui.PushItemWidth(imgui.GetContentRegionAvailWidth())
    imgui.InputText(label, content, #content, imgui_input_text_flags.AutoSelectAll)
    imgui.PopItemWidth()
    AddPadding()
end
