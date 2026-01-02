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
transpiler(false, true, 'production');

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
const packageIdx = packageJSON
    .replaceAll('\r', '')
    .split('\n')
    .findIndex((l) => l.includes(`"version": `));
const packageVer = packageJSON
    .replaceAll('\r', '')
    .split('\n')
    [packageIdx].split(': "')[1]
    .replaceAll(/\"\,/g, '');

if (packageVer !== versionNumber.slice(1)) {
    const packageLines = packageJSON.split('\n');
    packageLines[packageIdx] = packageLines[packageIdx].replace(
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
try {
    if (!fs.existsSync('builds')) fs.mkdirSync('builds');
    if (!fs.existsSync(`temp-build-github`)) fs.mkdirSync(`temp-build-github`);
    if (!fs.existsSync(`temp-build-steam`)) fs.mkdirSync(`temp-build-steam`);
    fs.mkdirSync(`temp-build-github/${packageName}`);
    fs.mkdirSync(`temp-build-steam/${packageName}`);

    fs.copyFileSync(
        'plugin.lua',
        `temp-build-github/${packageName}/plugin.lua`
    );
    fs.copyFileSync('plugin.lua', `temp-build-steam/${packageName}/plugin.lua`);
    fs.copyFileSync(
        'assets/steam_workshop_preview.png',
        `temp-build-steam/${packageName}/steam_workshop_preview.png`
    );
    fs.copyFileSync(
        'assets/steam_workshop_id.txt',
        `temp-build-steam/${packageName}/steam_workshop_id.txt`
    );

    const settingsIni = fs.readFileSync('settings.ini', 'utf-8');
    const oldVersionNumber = settingsIni
        .split('\n')[0]
        .replaceAll('\r', '')
        .split('plumoguSV')[1];

    if (!oldVersionNumber || oldVersionNumber !== versionNumber) {
        const settingsIniLines = settingsIni.split('\n');
        settingsIniLines[1] = `Name = plumoguSV ${versionNumber}`;
        fs.writeFileSync(
            `temp-build-github/${packageName}/settings.ini`,
            settingsIniLines.join('\n')
        );
        fs.writeFileSync(
            `temp-build-steam/${packageName}/settings.ini`,
            settingsIniLines.join('\n')
        );
    }

    zip.addLocalFolder('temp-build-github');
    zip.writeZip(`builds/${packageName}.zip`);

    fs.cpSync(
        `temp-build-steam/${packageName}`,
        `builds/${packageName}-steam`,
        {
            recursive: true,
            force: true,
        }
    );

    console.log(
        chalk.greenBright(
            chalk.bold(
                `Process completed in ${
                    Date.now() - startTime
                }ms. Find the build at ${chalk.redBright(
                    `builds/${packageName}`
                )}.`
            )
        )
    );

    fs.rmSync('temp-build-github', { recursive: true, force: true });
    fs.rmSync('temp-build-steam', { recursive: true, force: true });
} catch (e) {
    console.log(
        chalk.bgRedBright(`An error occurred during the build process: ${e}`)
    );

    fs.rmSync('temp-build-github', { recursive: true, force: true });
    fs.rmSync('temp-build-steam', { recursive: true, force: true });
}
