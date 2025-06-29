DEFAULT_WIDGET_HEIGHT = 26                    -- value determining the height of GUI widgets
DEFAULT_WIDGET_WIDTH = 160                    -- value determining the width of GUI widgets
PADDING_WIDTH = 8                             -- value determining window and frame padding
RADIO_BUTTON_SPACING = 7.5                    -- value determining spacing between radio buttons
SAMELINE_SPACING = 5                          -- value determining spacing between GUI items on the same row
ACTION_BUTTON_SIZE = vector.New(255, 42)      -- dimensions of the button that does important things
PLOT_GRAPH_SIZE = vector.New(255, 100)        -- dimensions of the plot graph for SVs and note motion
HALF_ACTION_BUTTON_SIZE = vector.New(125, 42) -- dimensions of a button that does kinda important things
SECONDARY_BUTTON_SIZE = vector.New(48, 24)    -- dimensions of a button that does less important things
TERTIARY_BUTTON_SIZE = vector.New(21.5, 24)   -- dimensions of a button that does much less important things
EXPORT_BUTTON_SIZE = vector.New(40, 24)       -- dimensions of the export menu settings button
BEEG_BUTTON_SIZE = vector.New(255, 24)        -- beeg button

MIN_RGB_CYCLE_TIME = 0.1                      -- minimum seconds for one complete RGB color cycle
MAX_RGB_CYCLE_TIME = 300                      -- maximum seconds for one complete RGB color cycle
MAX_CURSOR_TRAIL_POINTS = 100                 -- maximum number of points for cursor trail effects
MAX_SV_POINTS = 1000                          -- maximum number of SV points allowed
MAX_ANIMATION_FRAMES = 999                    -- maximum number of animation frames allowed
MAX_IMPORT_CHARACTER_LIMIT = 999999           -- maximum number of characters allowed for import text

CHINCHILLA_TYPES = {                          -- types of chinchilla SVs
    "Exponential",
    "Polynomial",
    "Circular",
    "Sine Power",
    "Arc Sine Power",
    "Inverse Power",
    "Peter Stock"
}
COLOR_THEMES = { -- available color themes for the plugin
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
    "BGR + otingocnI",
    "otingocnI",
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
    "100,100,255",
    "255,255,255",
    "0,0,0",
}
COMBO_SV_TYPE = { -- options for overlapping combo SVs
    "Add",
    "Cross Multiply",
    "Remove",
    "Min",
    "Max",
    "SV Type 1 Only",
    "SV Type 2 Only"
}
CURSOR_TRAILS = { -- available cursor trail types
    "None",
    "Snake",
    "Dust",
    "Sparkle"
}
DISPLACE_SCALE_SPOTS = { -- places to scale SV sections by displacing
    "Start",
    "End"
}
EMOTICONS = { -- emoticons to visually clutter the plugin and confuse users
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
    "[ m w m ]",
    "( v . ^ )",
    "( ^ o v )",
    "( ^ o v )",
    "( ; A ; )",
    "[ . _ . ]",
    "[ ' = ' ]",
}
FINAL_SV_TYPES = { -- options for the last SV placed at the tail end of all SVs
    "Normal",
    "Custom",
    "Override"
}
FLICKER_TYPES = { -- types of flickers
    "Normal",
    "Delayed"
}
NOTE_SKIN_TYPES = { -- types of note skins
    "Bar",
    "Circle"
}

RANDOM_TYPES = { -- distribution types of random values
    "Normal",
    "Uniform"
}
SCALE_TYPES = { -- ways to scale SVs
    "Average SV",
    "Absolute Distance",
    "Relative Ratio"
}


STANDARD_SVS_NO_COMBO = { -- types of standard SVs (excluding combo)
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
STILL_TYPES = { -- types of still displacements
    "No",
    "Start",
    "End",
    "Auto",
    "Otua"
}
STUTTER_CONTROLS = { -- parts of a stutter SV to control
    "First SV",
    "Second SV"
}
STYLE_THEMES = { -- available style/appearance themes for the plugin
    "Rounded",
    "Boxed",
    "Rounded + Border",
    "Boxed + Border"
}
SV_BEHAVIORS = { -- behaviors of SVs
    "Slow down",
    "Speed up"
}
TRAIL_SHAPES = { -- shapes for cursor trails
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

VIBRATO_TYPES = { -- types of vibrato
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

VIBRATO_FRAME_RATES = { 45, 90, 150, 210, 450 }

VIBRATO_DETAILED_QUALITIES = {}

for i, v in pairs(VIBRATO_QUALITIES) do
    table.insert(VIBRATO_DETAILED_QUALITIES, v .. "  (~" .. VIBRATO_FRAME_RATES[i] .. "fps)")
end

VIBRATO_CURVATURES = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.2, 2.4, 2.6, 2.8, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5 }

ALPHABET_LIST = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
    "V", "W", "X", "Y", "Z" }

CONSONANTS = { "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z" }

VOWELS = { "A", "E", "I", "O", "U", "Y" }

DEFAULT_STYLE = {
    windowBg = vector.New(0.00, 0.00, 0.00, 1.00),
    popupBg = vector.New(0.08, 0.08, 0.08, 0.94),
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
        vector.New(1.00, 0.60, 0.00, 1.00)
}

HEXADECIMAL = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" }

COLOR_MAP = {
    [1] = "Red",
    [2] = "Blue",
    [3] = "Purple",
    [4] = "Yellow",
    [5] = "White",
    [6] = "Pink",
    [8] =
    "Orange",
    [12] = "Cyan",
    [16] = "Green"
}

DEFAULT_SETTING_TYPES = {
    "General",
    "Default Properties",
    "Appearance",
    "Windows + Widgets",
    "Keybinds",
}

DEFAULT_HOTKEY_LIST = { "T", "Shift+T", "S", "N", "R", "B", "M", "V", "G" }
GLOBAL_HOTKEY_LIST = { "T", "Shift+T", "S", "N", "R", "B", "M", "V", "G" } -- Cannot make shallow copy with reference, and table.duplicate might not have been instantiated before running this.
HOTKEY_LABELS = { "Execute Primary Action", "Execute Secondary Action", "Swap Primary Inputs",
    "Negate Primary Inputs", "Reset Secondary Input", "Go To Previous Scroll Group", "Go To Next Scroll Group",
    "Execute Vibrato Separately", "Use TG of Selected Note" }
