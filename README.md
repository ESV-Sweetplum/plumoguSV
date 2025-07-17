# plumoguSV v1.1.2
<img src="./assets/logo.png" alt="plumoguSV Logo">

> "The ultimate community-driven and open-source competitive SV plugin. Remastered with many new features."

This is a plugin for [Quaver](https://github.com/Quaver), the ultimate community-driven and open-source competitive rhythm game. Originally made by [amogu](https://github.com/kloi34), this fork aims to continue the legacy that he left behind. The plugin has support for manipulating SVs (scroll velocities) and SSFs (scroll speed factors) in all sorts of ways, and it is the de facto plugin for SV mapmaking.

## Installation
1. Go to the releases tab on the right, and download the latest release's `.zip` file.
2. Extract the downloaded `.zip` file to get the plumoguSV-main folder.
3. Move the plumoguSV-main folder into the `/Plugins` folder (located in the `/Quaver` folder).

## Plugin Overview 
plumoguSV makes working with SVs quick and easy!

Once you open the plugin in the map editor you:
1. Choose an SV tool
2. Adjust the SV tool's settings
3. Select notes you want to use the tool at/between
4. Use the SV tool by pressing 'T' on your keyboard (or hitting the big button that appears)

plumoguSV lets you do 4 general SV actions: select, create, edit, and delete.

## Special Note
Thanks to [asterSSH](https://github.com/asterssh) for the banner and other graphic design help. Thanks to [7xbi](https://github.com/7xbi) and [imnethen](https://github.com/imnethen) for PRs which have positively moved this plugin forward.

Most of the core ideas and base functionality were taken (stolen) from [iceSV](https://github.com/IceDynamix/iceSV) by [IceDynamix](https://github.com/IceDynamix).
Other SV ideas also taken (stolen) from [Illuminati-CRAZ](https://github.com/Illuminati-CRAZ)’s SV plugins.
Without these two people’s contributions to SV plugins in general, plumoguSV would not be as good as it is today or even exist in the first place, so huge thanks to them.

Also, some cursor effects were inspired (stolen) from https://github.com/tholman/cursor-effects

## Related Links
* [Quaver Plugin Guide](https://github.com/IceDynamix/QuaverPluginGuide/blob/master/quaver_plugin_guide.md) by IceDynamix
* [iceSV](https://github.com/IceDynamix/iceSV) by IceDynamix
* [KeepStill](https://github.com/Illuminati-CRAZ/KeepStill) by Illuminati-CRAZ
* [Vibrato](https://github.com/Illuminati-CRAZ/Vibrato) by Illuminati-CRAZ
* [Displacer](https://github.com/Illuminati-CRAZ/Displacer) by Illuminati-CRAZ
* [AFFINE](https://github.com/ESV-Sweetplum/AFFINE) by ESV-Sweetplum
* [mulch](https://github.com/Emik03/mulch) by Emik03

## TO-DO
* ~~Automate TG effects~~
* ~~Separate settings tab~~
* ~~Move to vector system~~
* ~~Fix all syntax errors in intellisense~~
* ~~Migrate affine vibrato~~
* ~~Add three sided vibrato algorithm~~
* ~~Add code based ssf vibrato~~
* ~~Custom vibrato with sv and lua eval~~
* ~~Map statistics~~
* ~~Custom theme maker~~
* ~~Dynamic automation~~
* ~~Flicker duration option~~
* ~~Fix align timing lines bug~~
* ~~Finish snap editor~~
* ~~Customizable default page settings~~
* Preset menu
* ~~Refactor custom theme settings~~
* ~~Add import/export custom theme~~
* ~~Add tooltips to settings~~
* ~~Add nsv measure tool~~
* ~~Fix merge inefficiency~~
* Animation palette generator
* ~~Rework bezier backend to use vectors~~
* Allow for dynamic sv fps instead of static sv points
* ~~automate optimizations~~
* ~~Use sliderint instead of clamped dragint as much as possible~~
* ~~Fix automate TGs being hidden breaking stuff~~
* ~~Make globalVars.... actually global so i don't have to fucking pass it down everywhere~~
* ~~Remove passing globalVars to children~~
* ~~Update radio buttons to use new radio button constructor~~
* code based displace note/displace view @emik
* note lock hotkey (with horizontal and vertical movement independently restricted)