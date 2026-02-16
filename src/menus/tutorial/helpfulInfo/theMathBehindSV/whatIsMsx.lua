function showWhatIsMsxTutorial()
    imgui.SeparatorText('Units of Distance and Velocity')
    imgui.TextColored(GUIDELINE_COLOR, 'TLDR: 1 msx is the distance a note travels in 1 ms at 1x SV.')
    imgui.TextWrapped(
        'First and foremost, msx is a unit of distance. Similarly to how the meter is defined in real life, we define msx using speed instead of any objective distance. In real life, a meter is defined by the distance light travels in 1/299792458th of a second. Of course, in Quaver, we have much more control over how things move, so we can simply write that 1 msx is the distance a note travels in 1 millisecond at 1x scroll velocity. We can generalize this with the equation:')
    imgui.SetCursorPosX(175)
    imgui.TextColored(INSTRUCTION_COLOR, 'd = vt')
    imgui.TextWrapped(
        'Those who have taken physics will be familiar with this equation; assuming constant velocity, the distance travelled by an object (in our case, a Quvaer note) is equal to the velocity (scroll velocity) multiplied by time (in milliseconds). We use this fact to compute msx in any constant velocity scenario:')
    imgui.SetCursorPosX(110)
    imgui.TextColored(INSTRUCTION_COLOR, '(0.5x SV) * (500 ms) = 250 msx')
    imgui.TextWrapped(
        'Since SV points are discrete (that is, there is no changing velocity between two SVs), ALL distance can be computed by breaking up effects into chunks of two SVs and computing their distances individually, then summing them. For those who have taken calculus, it is effectively a discrete sum, that when generalized turns into an integral (similar to how distance is the integral of velocity when velocity is a continuous function of time).')
    imgui.TextWrapped(
        'Like any other equation, we can rewrite the above to solve for what we need. Maybe we want an effect to travel 300 msx in the timespan of 500 milliseconds. The resulting average SV should then be:')
    imgui.SetCursorPosX(115)
    imgui.TextColored(INSTRUCTION_COLOR, '(300 msx) / (500 ms) = 0.6x')
    imgui.TextWrapped(
        'Hopefully the nomenclature for msx makes sense; it is quite literally ms * x. If you know a little bit of dimensional analysis, you can use this fact to easily compute average SVs and displacements.')
end
