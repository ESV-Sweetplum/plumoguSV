## Building and Developing

As plumoguSV uses a multifile structure, there will be a few extra steps to start making your own changes to the plugin:

1. If you haven't already, install [Node.JS](https://nodejs.org/en).
2. In the root directory, type `npm i` into the terminal to install all the packages.
   2a. If TypeScript is not globally installed, run `npm i -g typescript`. This is necessary as the previous step assumes your TypeScript installation is global.
3. To start developing, type `npm run watch` into the terminal. This will start the watcher.
4. Now, any time you make a change to a file in the `src/` directory, `plugin.lua` will automatically recompile and will be hot-reloaded in game.

## Rendering Bezier Text In-Game

1. Write your text in this [Text to SVG](https://text-to-svg.com/inter-font-to-svg) converter. Make sure to use inter font at regular boldness for the most consistent result.
2. Open the svg as a text file and copy the path into [this svg to bezier](https://itchylabs.com/tools/path-to-bezier) converter. Paste the contents of the output (only the cubic curves part, not the flutter part) into a `bezier/\*.bezier` file.
3. At the top of the `.bezier` file (in a new line), type the desired size of the render in the format `width, height`.
4. Run `npm run bezier` in the terminal. The resulting lua file along with annotations will come out in the `bezier/out` folder. Call the function with its respective parameters to render the text in game.
