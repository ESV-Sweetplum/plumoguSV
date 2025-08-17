import * as fs from 'fs';
import checkUnusedFunctions from './unused-functions';
import checkDoubleNestedFiles from './double-nested-files';
import checkDuplicatedLines from './duplicated-lines';
import checkMissingAnnotations from './missing-annotations';
import chalk = require('chalk');
import transpiler from '../transpiler';

async function main() {
    await transpiler(true, false);

    const plugin = fs
        .readFileSync('plugin.lua', 'utf-8')
        .replaceAll('\r', '')
        .split('\n');

    const [failed1, count1] = checkDoubleNestedFiles();
    const [failed2, count2] = checkUnusedFunctions(plugin);
    const [failed3, count3] = checkMissingAnnotations(plugin);
    // const [failed4, count4] = checkDuplicatedLines(plugin, 10);

    const totalFailed = failed1 + failed2 + failed3;
    const totalCount = count1 + count2 + count3;

    console.log(
        chalk.green(`${totalCount - totalFailed} / ${totalCount} tests passed.`)
    );
}

main();
