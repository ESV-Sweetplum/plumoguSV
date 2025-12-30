## Building and Developing

As plumoguSV uses a multifile structure, there will be a few extra steps to start making your own changes to the plugin:

1. If you haven't already, install [Node.JS](https://nodejs.org/en).
2. In the root directory, type `npm i` into the terminal to install all the packages.

    2a. If TypeScript is not globally installed, run `npm i -g typescript`. This is necessary as the previous step assumes your TypeScript installation is global.

3. To start developing, type `npm run watch` into the terminal. This will start the watcher.
4. Now, any time you make a change to a file in the `src/` directory, `plugin.lua` will automatically recompile and will be hot-reloaded in game.

Please refer to `CODESTYLE.md` for repository-based specifics.
