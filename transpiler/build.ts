import AdmZip = require('adm-zip');
import transpiler from '.';
import * as chalk from 'chalk';
import * as fs from 'fs';

const startTime = Date.now();

console.log(
    chalk.blueBright(
        chalk.bold(`Transpiling ${chalk.redBright('plugin.lua')}...`)
    )
);
transpiler(false, true);

const versionNumber = `v${fs.readFileSync('.version', 'utf-8')}`;

console.log(
    chalk.blueBright(
        chalk.bold(
            `Modfifying version number of ${chalk.redBright('plugin.lua')}...`
        )
    )
);

const pluginLines = fs.readFileSync('plugin.lua', 'utf-8').split('\n');

pluginLines.forEach((line, idx) => {
    if (line.includes('PLUGIN_NAME = ')) {
        pluginLines[idx] = pluginLines[idx].replaceAll(
            /"[a-zA-Z\-]+"/g,
            `"plumoguSV ${versionNumber}"`
        );
    }
});

fs.writeFileSync('plugin.lua', pluginLines.join('\n'));

console.log(
    chalk.blueBright(chalk.bold(`Updating ${chalk.redBright('README.md')}...`))
);

const readme = fs.readFileSync('README.md', 'utf-8');

if (
    readme.split('\n')[0].replaceAll('\r', '').split('plumoguSV ')[1] !==
    versionNumber
) {
    const readmeLines = readme.split('\n');
    readmeLines[0] = `# plumoguSV ${versionNumber}`;
    fs.writeFileSync('README.md', readmeLines.join('\n'));
}

console.log(
    chalk.blueBright(
        chalk.bold(`Updating ${chalk.redBright('package.json')}...`)
    )
);

const packageJSON = fs.readFileSync('package.json', 'utf-8');
const idx = packageJSON
    .replaceAll('\r', '')
    .split('\n')
    .findIndex((l) => l.includes(`"version": `));
const packageVer = packageJSON
    .replaceAll('\r', '')
    .split('\n')
    [idx].split(': "')[1]
    .replaceAll(/\"\,/g, '');

if (packageVer !== versionNumber.slice(1)) {
    const packageLines = packageJSON.split('\n');
    packageLines[idx] = packageLines[idx].replace(
        packageVer,
        versionNumber.slice(1)
    );
    fs.writeFileSync('package.json', packageLines.join('\n'));
}

console.log(
    chalk.blueBright(
        chalk.bold(`Updating ${chalk.redBright('settings.ini')}...`)
    )
);

const packageName = `plumoguSV-${versionNumber}`;

console.log(
    chalk.blueBright(
        chalk.bold(
            `Zipping into ${chalk.redBright(`builds/${packageName}`)}...`
        )
    )
);

const zip = new AdmZip();

if (!fs.existsSync('builds')) fs.mkdirSync('builds');
if (!fs.existsSync(`build-temp`)) fs.mkdirSync(`build-temp`);
fs.mkdirSync(`build-temp/${packageName}`);

fs.copyFileSync('plugin.lua', `build-temp/${packageName}/plugin.lua`);

const settingsIni = fs.readFileSync('settings.ini', 'utf-8');
const oldVersionNumber = settingsIni
    .split('\n')[0]
    .replaceAll('\r', '')
    .split('plumoguSV')[1];

if (!oldVersionNumber || oldVersionNumber !== versionNumber) {
    const settingsIniLines = settingsIni.split('\n');
    settingsIniLines[1] = `Name = plumoguSV ${versionNumber}`;
    fs.writeFileSync(
        `build-temp/${packageName}/settings.ini`,
        settingsIniLines.join('\n')
    );
}

zip.addLocalFolder('build-temp');

zip.writeZip(`builds/${packageName}.zip`);

console.log(
    chalk.greenBright(
        chalk.bold(
            `Process completed in ${
                Date.now() - startTime
            }ms. Find the build at ${chalk.redBright(`builds/${packageName}`)}.`
        )
    )
);

fs.rmSync('build-temp', { recursive: true, force: true });
