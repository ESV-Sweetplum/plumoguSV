imgui_disable_vector_packing = true                                    -- Use vectors instead of tables for imgui output

DEFAULT_WIDGET_HEIGHT = 26                                             -- value determining the height of GUI widgets
DEFAULT_WIDGET_WIDTH = 160                                             -- value determining the width of GUI widgets
PADDING_WIDTH = 8                                                      -- value determining window and frame padding
RADIO_BUTTON_SPACING = 7.5                                             -- value determining spacing between radio buttons
SAMELINE_SPACING = 5                                                   -- value determining spacing between GUI items on the same row
ACTION_BUTTON_SIZE = vector.New(253, 42)                               -- dimensions of the button that does important things
PLOT_GRAPH_SIZE = vector.New(253, 100)                                 -- dimensions of the plot graph for SVs and note motion
HALF_ACTION_BUTTON_SIZE = vector.New((253 - SAMELINE_SPACING) / 2, 42) -- dimensions of a button that does kinda important things
SECONDARY_BUTTON_SIZE = vector.New(48, 24)                             -- dimensions of a button that does less important things
TERTIARY_BUTTON_SIZE = vector.New(21.5, 24)                            -- dimensions of a button that does much less important things
EXPORT_BUTTON_SIZE = vector.New(40, 24)                                -- dimensions of the export menu settings button
BEEG_BUTTON_SIZE = vector.New(253, 24)                                 -- beeg button

MIN_RGB_CYCLE_TIME = 0.1                                               -- minimum seconds for one complete RGB color cycle
MAX_RGB_CYCLE_TIME = 300                                               -- maximum seconds for one complete RGB color cycle
MAX_CURSOR_TRAIL_POINTS = 100                                          -- maximum number of points for cursor trail effects
MAX_SV_POINTS = 1000                                                   -- maximum number of SV points allowed
MAX_ANIMATION_FRAMES = 999                                             -- maximum number of animation frames allowed
MAX_IMPORT_CHARACTER_LIMIT = 999999                                    -- maximum number of characters allowed for import text

CHINCHILLA_TYPES = {
    "Exponential",
    "Polynomial",
    "Circular",
    "Sine Power",
    "Arc Sine Power",
    "Inverse Power",
    "Peter Stock"
}

COLOR_THEMES = {
    "Classic",
    "Strawberry",
    "Amethyst",
    "Tree",
    "Barbie",
    "Incognito",
    "Incognito + RGB",
    "Tobi's Glass",
    "Tobi's RGB Glass",
    "Glass",
    "Glass + RGB",
    "RGB Gamer Mode",
    "edom remag BGR",
    "otingocnI",
    "BGR + otingocnI",
    "CUSTOM"
}

COLOR_THEME_COLORS = {
    "255,255,255",
    "251,41,67",
    "153,102,204",
    "150,111,51",
    "227,5,173",
    "150,150,150",
    "255,0,0",
    "200,200,200",
    "0,255,0",
    "220,220,220",
    "0,0,255",
    "255,100,100",
    "100,255,100",
    "255,255,255",
    "100,100,255",
    "0,0,0",
}

DYNAMIC_BACKGROUND_TYPES = {
    "None",
    "Reactive Stars",
    "Reactive Singularity",
}

COMBO_SV_TYPE = {
    "Add",
    "Cross Multiply",
    "Remove",
    "Min",
    "Max",
    "SV Type 1 Only",
    "SV Type 2 Only"
}

CURSOR_TRAILS = {
    "None",
    "Snake",
    "Dust",
    "Sparkle"
}

DISPLACE_SCALE_SPOTS = {
    "Start",
    "End"
}

SPLIT_MODES = {
    "Column",
    "Time",
    "Individual"
}

EMOTICONS = {
    "( - _ - )",
    "( e . e )",
    "( * o * )",
    "( h . m )",
    "( ~ _ ~ )",
    "( - . - )",
    "( C | D )",
    "( w . w )",
    "( ^ w ^ )",
    "( > . < )",
    "( + x + )",
    "( o _ 0 )",
    "[ ^ . ^ ]",
    "( v . ^ )",
    "( ^ o v )",
    "( ^ o v )",
    "( ; A ; )",
    "[ . _ . ]",
    "[ ' = ' ]",
}

FINAL_SV_TYPES = {
    "Normal",
    "Custom",
    "Override"
}

FLICKER_TYPES = {
    "Normal",
    "Delayed"
}

NOTE_SKIN_TYPES = {
    "Bar",
    "Circle"
}

RANDOM_TYPES = {
    "Normal",
    "Uniform"
}

SCALE_TYPES = {
    "Average SV",
    "Absolute Distance",
    "Relative Ratio"
}

STANDARD_SVS_NO_COMBO = {
    "Linear",
    "Exponential",
    "Bezier",
    "Hermite",
    "Sinusoidal",
    "Circular",
    "Random",
    "Custom",
    "Chinchilla"
}

STILL_TYPES = {
    "No",
    "Start",
    "End",
    "Auto",
    "Otua"
}

STUTTER_CONTROLS = {
    "First SV",
    "Second SV"
}

STYLE_THEMES = {
    "Rounded",
    "Boxed",
    "Rounded + Border",
    "Boxed + Border"
}

SV_BEHAVIORS = {
    "Slow down",
    "Speed up"
}

TRAIL_SHAPES = {
    "Circles",
    "Triangles"
}

STILL_BEHAVIOR_TYPES = {
    "Entire Region",
    "Per Note Group",
}

DISTANCE_TYPES = {
    "Average SV + Shift",
    "Distance + Shift",
    "Start / End"
}

VIBRATO_TYPES = {
    "SV (msx)",
    "SSF (x)",
}

VIBRATO_QUALITIES = {
    "Low",
    "Medium",
    "High",
    "Ultra",
    "Omega"
}

VIBRATO_FRAME_RATES = { 60, 90, 150, 210, 270 }

VIBRATO_DETAILED_QUALITIES = {} -- what actually shows up in-game

for i, v in pairs(VIBRATO_QUALITIES) do
    table.insert(VIBRATO_DETAILED_QUALITIES, v .. "  (~" .. VIBRATO_FRAME_RATES[i] .. "fps)")
end

VIBRATO_CURVATURES = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.2, 2.4, 2.6, 2.8, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5 }

DEFAULT_STYLE = {
    windowBg = vector.New(0.00, 0.00, 0.00, 1.00),
    popupBg = vector.New(0.08, 0.08, 0.08, 0.94),
    border = vector.New(0.00, 0.00, 0.00, 0.00),
    frameBg = vector.New(0.14, 0.24, 0.28, 1.00),
    frameBgHovered =
        vector.New(0.24, 0.34, 0.38, 1.00),
    frameBgActive =
        vector.New(0.29, 0.39, 0.43, 1.00),
    titleBg = vector.New(0.14, 0.24, 0.28, 1.00),
    titleBgActive =
        vector.New(0.51, 0.58, 0.75, 1.00),
    titleBgCollapsed =
        vector.New(0.51, 0.58, 0.75, 0.50),
    checkMark = vector.New(0.81, 0.88, 1.00, 1.00),
    sliderGrab =
        vector.New(0.56, 0.63, 0.75, 1.00),
    sliderGrabActive =
        vector.New(0.61, 0.68, 0.80, 1.00),
    button = vector.New(0.31, 0.38, 0.50, 1.00),
    buttonHovered =
        vector.New(0.41, 0.48, 0.60, 1.00),
    buttonActive =
        vector.New(0.51, 0.58, 0.70, 1.00),
    tab = vector.New(0.31, 0.38, 0.50, 1.00),
    tabHovered =
        vector.New(0.51, 0.58, 0.75, 1.00),
    tabActive =
        vector.New(0.51, 0.58, 0.75, 1.00),
    header = vector.New(0.81, 0.88, 1.00, 0.40),
    headerHovered =
        vector.New(0.81, 0.88, 1.00, 0.50),
    headerActive =
        vector.New(0.81, 0.88, 1.00, 0.54),
    separator = vector.New(0.81, 0.88, 1.00, 0.30),
    text = vector.New(1.00, 1.00, 1.00, 1.00),
    textSelectedBg =
        vector.New(0.81, 0.88, 1.00, 0.40),
    scrollbarGrab =
        vector.New(0.31, 0.38, 0.50, 1.00),
    scrollbarGrabHovered =
        vector.New(0.41, 0.48, 0.60, 1.00),
    scrollbarGrabActive =
        vector.New(0.51, 0.58, 0.70, 1.00),
    plotLines =
        vector.New(0.61, 0.61, 0.61, 1.00),
    plotLinesHovered =
        vector.New(1.00, 0.43, 0.35, 1.00),
    plotHistogram =
        vector.New(0.90, 0.70, 0.00, 1.00),
    plotHistogramHovered =
        vector.New(1.00, 0.60, 0.00, 1.00),
    loadupOpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00),
    loadupPulseTextColorLeft = vector.New(0.00, 0.50, 1.00, 1.00),
    loadupPulseTextColorRight = vector.New(0.00, 0.00, 1.00, 1.00),
    loadupBgTl = vector.New(0.00, 0.00, 0.00, 0.39),
    loadupBgTr = vector.New(0.31, 0.38, 0.50, 0.67), -- RAHHHH 6 7 6 7 6 7 6 7 6 7
    loadupBgBl = vector.New(0.31, 0.38, 0.50, 0.67),
    loadupBgBr = vector.New(0.62, 0.76, 1, 1.00),
}

DEFAULT_HOTKEY_LIST = { "T", "Shift+T", "S", "N", "R", "B", "M", "V", "G", "Ctrl+Alt+L", "Ctrl+Alt+E", "O" }

HOTKEY_LABELS = { "Execute Primary Action", "Execute Secondary Action", "Swap Primary Inputs",
    "Negate Primary Inputs", "Reset Secondary Input", "Go To Prev. Scroll Group", "Go To Next Scroll Group",
    "Execute Vibrato Separately", "Go To TG of Selected Note", "Toggle Note Lock Mode", "Toggle Use End Offsets",
    "Move Selection To TG" }

---@enum hotkeys
hotkeys_enum = {
    exec_primary = 1,
    exec_secondary = 2,
    swap_primary = 3,
    negate_primary = 4,
    reset_secondary = 5,
    go_to_prev_tg = 6,
    go_to_next_tg = 7,
    exec_vibrato = 8,
    go_to_note_tg = 9,
    toggle_note_lock = 10,
    toggle_end_offset = 11,
    move_selection_to_tg = 12,
}
