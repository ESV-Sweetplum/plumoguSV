## Lua-specific code styling

-   The indent width in this codebase is 4.
-   Use `camelCase` whenever possible. While many other projects use `snake_case` for Lua, since the exposed globals from Quaver use `camelCase`, it makes sense to follow this paradigm.
-   The exception to the above rule is when your function is strictly for display purposes only (such as an imgui component). In this case, use `UpperCamelCase` for clarity.
-   Avoid using `k` or `v` as parameters in `pairs(tbl)`, unless iterating over a generic table.
-   Acronyms that are not game objects, like SVs, SSFs, or TGs, should only have their first letter capitalized (like `scrollGroupId`)
-   Any variable with `UPPER_SNAKE_CASE` is a constant. Treat it as such.
-   Avoid anonymous functions unless passing them as the parameter to another function.
-   Any variable prefixed with `_` is not meant to be used.
-   Avoid writing comments explaining code unless the logic within the code is unclear.
-   Use double quotes for strings, unless they contain a double quote themselves; in that case, use single quotes.
-   Avoid using bracket notation for tables unless the key is not known beforehand (e.g. during runtime) or if the key must be surrounded by quotations.
-   Try to either have all variables necessary assigned at the top of a function, or have their first assignment be as close to their next call as possible.
-   Use the existing conventions within the repository if they're not listed here.
-   When printing a particular type of message, the format that should be used is `i!`, `w!`, `s!`, or `e!`.

## Creating a new window/feature steps

1. In the corresponding `menu` folder, add a file with a new function that will dictate the menu.
2. Add the feature name in the category's index file, and add another if statement to link to the function created in (1).
3. Define the default menu variables in `src/vars/menu.lua`, and the preset values should be editable in `defaultProperties.lua`.
   3a. Define optional default setting variables (if the function will be used in more than one category) in `src/vars/settings.lua`.
   3b. If the other features in the category have a tooltip, add it.
4. Create an identical path through `actions` where your menu will interact with the map upon execution of a `simpleAction`.

## Creating a new global variable

1. Update `vars/global.lua` to include your new value and the default value.
2. Update `syncGlobalVarsState` to whitelist your global variable into the database.

## Creating a new category

1. In the corresponding tab folder, create a folder for your category.
2. Add the category to the tab's `index.lua` file and include it in the list of if-statements.

## Creating a new hotkey

1. Add your default hotkey to the `DEFAULT_HOTKEY_LIST` root array.
2. Add the description of your hotkey in the `HOTKEY_LABELS` global.
3. If your hotkey is to be run at all times, create your action in `actions/hotkeys` and reference its function in `actions/hotkeys/index.lua`.

## Notes on general codebase specifics

-   Most constants defined in the root of the file should be located in the file it's needed, unless one of the following are met:
    -   The constant is used in a `chooseFunction`.
    -   The constant is used in multiple files.
    -   The constant is linked to other constants that follow one of the above rules.
    -   The constant is a table with functions linking from it, without the table itself being defined.
-   All files that must have higher priority (like defined constants or widespread functions that do not rely on anything within the plugin itself) should be marked using the `*.priority.lua` suffix. As packages are loaded before priority functions, priority functions should not depend on each other, and only rely on the packages. A rare exception of this is state handling for variables.
-   Notifications should always include the `!` flag (not including the plugin name) if it comes from clicking a button (such as Place SVs) or is triggered by a keybind that could be triggered via a non-settings button. Notifications should never include the `!` flag when it is from a action hotkey.

## Rendering Bezier Text In-Game

1. Write your text in this [Text to SVG](https://text-to-svg.com/inter-font-to-svg) converter. Make sure to use inter font at regular boldness for the most consistent result.
2. Open the svg as a text file and copy the path into [this svg to bezier](https://itchylabs.com/tools/path-to-bezier) converter. Paste the contents of the output (only the cubic curves part, not the flutter part) into a `bezier/\*.bezier` file.
3. At the top of the `.bezier` file (in a new line), type the desired size of the render in the format `width, height`.
4. Run `npm run bezier` in the terminal. The resulting lua file along with annotations will come out in the `bezier/out` folder. Call the function with its respective parameters to render the text in game.
