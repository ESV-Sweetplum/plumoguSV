function showStartingTutorial()
    imgui.SeparatorText("The Very Beginning")
    imgui.TextWrapped(
        "So, you want to make some SV maps, or scroll velocity maps. For those who don't know, scroll velocities are objects that change the speed at which notes fall towards the receptor. If you're new to plumogu, welcome! This plugin is your one-stop shop for creating SV maps. However, there are a few things we will need to go over before starting. These are important, so please read them!")
    imgui.SeparatorText("Colors in the Tutorial")
    imgui.Text("You may come across some instructions in ")
    imgui.SameLine(0, 0)
    imgui.TextColored(INSTRUCTION_COLOR, "Red")
    imgui.SameLine(0, 0)
    imgui.Text(" or ")
    imgui.SameLine(0, 0)
    imgui.TextColored(GUIDELINE_COLOR, "Blue")
    imgui.SameLine(0, 0)
    imgui.Text(".")
    imgui.PushStyleColor(imgui_col.Text, INSTRUCTION_COLOR)
    imgui.BulletText("Red text indicates an instruction that MUST\nbe completed for the tutorial to continue.")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText(
        "Blue text indicates an instruction that could be skipped \nand won't progress the tutorial, but helps for learning.")
    imgui.PopStyleColor(2)
    imgui.SeparatorText("Selections")
    imgui.TextWrapped(
        'Often times we will say the phrase "within the selection", which just means within a specific time (e.g. between 5 seconds and 6 seconds into the song). If you select two notes, the SVs within the selection are all SVs with a start time between the first note and the last note. This definition applies to all objects with a StartTime property, that being SVs, SSFs, and timing lines.')
    imgui.SeparatorText("SVs vs SSFs")
    imgui.TextWrapped(
        "If you come from osu!, you may not be familiar with SSFs, or scroll speed factors; objects that change the player's scroll speed to some multiplier. The critical difference between SSFs and SVs is that while SVs do not instantly change the position of notes, SSFs do.")
    imgui.SeparatorText("Now, let's start making some effects!")
    imgui.Text('Click "Placing Basic SVs" at the left, and start from "Your First Effect".')
end
