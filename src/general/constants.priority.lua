DEFAULT_WIDGET_HEIGHT = 26 -- value determining the height of GUI widgets
DEFAULT_WIDGET_WIDTH = 160 -- value determining the width of GUI widgets
PADDING_WIDTH = 8 -- value determining window and frame padding
RADIO_BUTTON_SPACING = 7.5 -- value determining spacing between radio buttons
SAMELINE_SPACING = 5 -- value determining spacing between GUI items on the same row
ACTION_BUTTON_SIZE = vector.New(253, 42) -- dimensions of the button that does important things
PLOT_GRAPH_SIZE = vector.New(253, 100) -- dimensions of the plot graph for SVs and note motion
HALF_ACTION_BUTTON_SIZE = vector.New((253 - SAMELINE_SPACING) / 2, 42) -- dimensions of a button that does kinda important things
SECONDARY_BUTTON_SIZE = vector.New(48, 24) -- dimensions of a button that does less important things
TERTIARY_BUTTON_SIZE = vector.New(21.5, 24) -- dimensions of a button that does much less important things
EXPORT_BUTTON_SIZE = vector.New(40, 24) -- dimensions of the export menu settings button
BEEG_BUTTON_SIZE = vector.New(253, 24) -- beeg button

MIN_RGB_CYCLE_TIME = 0.1 -- minimum seconds for one complete RGB color cycle
MAX_RGB_CYCLE_TIME = 300 -- maximum seconds for one complete RGB color cycle
MAX_CURSOR_TRAIL_POINTS = 100 -- maximum number of points for cursor trail effects
MAX_SV_POINTS = 1024 -- maximum number of SV points allowed
MAX_ANIMATION_FRAMES = 999 -- maximum number of animation frames allowed
MAX_IMPORT_CHARACTER_LIMIT = 999999 -- maximum number of characters allowed for import text

CHINCHILLA_TYPES = {
    'Exponential',
    'Polynomial',
    'Circular',
    'Sine Power',
    'Arc Sine Power',
    'Inverse Power',
    'Peter Stock',
}

DYNAMIC_BACKGROUND_TYPES = {
    'None',
    'Reactive Stars',
    'Reactive Singularity',
    'Dynamic Connection',
    'Topographic Map',
    'SV Spectrogram',
}

COMBO_SV_TYPE = {
    'Add',
    'Cross Multiply',
    'Remove',
    'Min',
    'Max',
    'SV Type 1 Only',
    'SV Type 2 Only',
}

CURSOR_TRAILS = {
    'None',
    'Snake',
    'Dust',
    'Sparkle',
}

DISPLACE_SCALE_SPOTS = {
    'Start',
    'End',
}

EMOTICONS = {
    '( - _ - )',
    '( e . e )',
    '( * o * )',
    '( h . m )',
    '( ~ _ ~ )',
    '( - . - )',
    '( C | D )',
    '( w . w )',
    '( ^ w ^ )',
    '( > . < )',
    '( + x + )',
    '( o _ 0 )',
    '[ ^ . ^ ]',
    '( v . ^ )',
    '( ^ o v )',
    '( ^ o v )',
    '( ; A ; )',
    '[ . _ . ]',
    "[ ' = ' ]",
}

FINAL_SV_TYPES = {
    'Normal',
    'Custom',
    'Override',
    'None',
}

FLICKER_TYPES = {
    'Normal',
    'Delayed',
}

NOTE_SKIN_TYPES = {
    'Bar',
    'Circle',
}

RANDOM_TYPES = {
    'Normal',
    'Uniform',
}

SCALE_TYPES = {
    'Average Value',
    'Absolute Distance',
    'Relative Ratio',
}

STANDARD_SVS_NO_COMBO = {
    'Linear',
    'Exponential',
    'Bezier',
    'Hermite',
    'Sinusoidal',
    'Circular',
    'Random',
    'Custom',
    'Chinchilla',
}

STILL_TYPES = {
    'No',
    'Start',
    'End',
    'Auto',
    'Otua',
}

VIBRATO_DEVIATION_TYPES = {
    'None',
    'Linear',
    'Gaussian',
}

STUTTER_CONTROLS = {
    'First SV',
    'Second SV',
}

STYLE_THEMES = {
    'Rounded',
    'Boxed',
    'Rounded + Border',
    'Boxed + Border',
}

SV_BEHAVIORS = {
    'Slow down',
    'Speed up',
}

TRAIL_SHAPES = {
    'Circles',
    'Triangles',
}

STILL_BEHAVIOR_TYPES = {
    'Entire Region',
    'Per Note Group',
}

LINEAR_DISTANCE_TYPES = {
    'Start SV / End SV',
    'Start SV / Average SV',
    'Average SV / End SV',
}

EXPONENTIAL_DISTANCE_TYPES = {
    'Average SV + Shift',
    'Distance + Shift',
    'Start / End',
}

VIBRATO_TYPES = {
    'SV (msx)',
    'SSF (x)',
}

VIBRATO_QUALITIES = {
    'Low',
    'Medium',
    'High',
    'Ultra',
    'Omega',
}

VIBRATO_FRAME_RATES = { 60, 90, 150, 210, 270 }

VIBRATO_DETAILED_QUALITIES = {} -- what actually shows up in-game

for i, v in pairs(VIBRATO_QUALITIES) do
    table.insert(VIBRATO_DETAILED_QUALITIES, v .. '  (~' .. VIBRATO_FRAME_RATES[i] .. 'fps)')
end

VIBRATO_CURVATURES = {
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1,
    1.1,
    1.2,
    1.3,
    1.4,
    1.5,
    1.6,
    1.7,
    1.8,
    1.9,
    2,
    2.2,
    2.4,
    2.6,
    2.8,
    3,
    3.25,
    3.5,
    3.75,
    4,
    4.25,
    4.5,
    4.75,
    5,
}

DEFAULT_HOTKEY_LIST = { 'T', 'Shift+T', 'S', 'N', 'R', 'B', 'M', 'V', 'G', 'Ctrl+Alt+L', 'Ctrl+Alt+E', 'O' }

HOTKEY_LABELS = {
    'Execute Primary Action',
    'Execute Secondary Action',
    'Swap Primary Inputs',
    'Negate Primary Inputs',
    'Reset Secondary Input',
    'Go To Prev. Scroll Group',
    'Go To Next Scroll Group',
    'Execute Vibrato Separately',
    'Go To TG of Selected Note',
    'Toggle Note Lock Mode',
    'Toggle End Offsets Mode',
    'Move Selection To TG',
}

HOTKEY_SETTING_ORDER = { 1, 2, 3, 4, 5, 6, 7, 9, 12, 10, 11, 8 }

--- Based on hotkey setting order
HOTKEY_SEPARATORS = {
    [1] = 'Action Hotkeys',
    [3] = 'Input Adjustment Hotkeys',
    [6] = 'Scroll Group Hotkeys',
    [11] = 'Mode Adjustment Hotkeys',
    [9] = 'Window Hotkeys',
}

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

ACTION_WHEEL_TYPES = {
    "kusa's Movement",
    "kusa's Snap Colors",
}

ACTION_WHEEL_TOOLTIP_LIST = {
    'Allows you to move selected notes up/down by 1ms, and side to side without adjusting offset.',
    'Allows selected notes to be changed to the given color.',
}
