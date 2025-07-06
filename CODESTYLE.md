- The indent width in this codebase is 4.
- Use `camelCase` whenever possible. While many other projects use `snake_case` for Lua, since the exposed globals from Quaver use `camelCase`, it makes sense to follow this paradigm.
- Avoid using `k` or `v` as parameters in `pairs(tbl)`, unless iterating over a generic table.
- Acronyms that are not game objects, like SVs, SSFs, or TGs, should only have their first letter capitalized (like `scrollGroupId`)
- Any variable with `UPPER_SNAKE_CASE` is a constant. Treat it as such.
- Avoid anonymous functions unless passing them as the parameter to another function.
- Any variable prefixed with `_` is not meant to be used.
- Avoid writing comments explaining code unless the logic within the code is unclear.
- Use double quotes for strings, unless they contain a double quote themselves; in that case, use single quotes.
- Avoid using bracket notation for tables unless the key is not known beforehand (e.g. during runtime)
- Try to either have all variables necessary assigned at the top of a function, or have their first assignment be - as close to their next call as possible.
- Use the existing conventions within the repository if they're not listed here.
- When printing a particular type of message, the format that should be used is `i!`, `w!`, `s!`, or `e!`.

## Creating a new window/feature steps
1. In the corresponding `menu` folder, add a file with a new function that will dictate the menu.
2. Add the feature name in the category's index file, and add another if statement to link to the function created in (1).
3. Define the default menu variables in `src/vars/menu.lua`.
3a. Define optional default setting variables (if the function will be used in more than one category) in `src/vars/settings.lua`.
4. Create an identical path through `actions` where your menu will interact with the map upon execution of a `simpleAction`.

## Creating a new global variable
1. Update `loadGlobalVars` to include your new value and the default value.
2. Update `syncGlobalVarsState` to whitelist your global variable into the database.

## Creating a new category
1. In the corresponding tab folder, create a folder for your category.
2. Add the category to the tab's `index.lua` file and include it in the list of if-statements.

## Notes on general codebase specifics
- Most constants defined in the root of the file should be located in the file it's needed, unless one of the following are met:
    - The constant is used in a `chooseFunction`.
    - The constant is used in multiple files.
    - The constant is linked to other constants that follow one of the above rules.
    - The constant is a table with functions linking from it, without the table itself being defined.
