import {
    readFileSync,
    writeFileSync,
    rmSync,
    existsSync,
    renameSync,
    copyFileSync,
} from 'fs';
import { getFilesRecursively } from './getFilesRecursively.js';
import fuckifyOutput from './fuckify.js';
import getFunctionList from './getFunctionList.js';
import getUnusedFunctions from './getUnusedFunctions.js';

export default async function transpiler(
    devMode = false,
    fuckify = false,
    lint = true
) {
    let fileCount = 0;

    let output = '';

    const separator = process.platform === 'win32' ? '\\' : '/';
    const entryPoints = ['draw.lua', 'awake.lua'];
    const ignoredFiles = [
        'classes.lua',
        'intellisense.lua',
        'init.lua',
        `packages${separator}tests`,
    ];
    if (!devMode) ignoredFiles.push(`src${separator}dev`);

    const files = getFilesRecursively('packages').sort(
        (a, b) => +b.includes('priority') - +a.includes('priority')
    );
    files.push(
        ...getFilesRecursively('src')
            .sort((a, b) => +b.includes('priority') - +a.includes('priority'))
            .sort(
                (a, b) =>
                    +entryPoints.some((e) => a.includes(e)) -
                    +entryPoints.some((e) => b.includes(e))
            ) // Force entry points to be towards the bottom.
    ); // Force priority functions towards the top to avoid hot-reload error.

    files.forEach((file: string) => {
        if (
            ignoredFiles.some((f) => file.includes(f)) ||
            !file.endsWith('.lua')
        )
            return;
        let fileData = readFileSync(file, 'utf-8')
            .replaceAll(/( *)\<const\> */g, '$1')
            .replaceAll(/\-\-\[\[.*?\-\-\]\][ \r\n]*/gs, '')
            .split('\n')
            .filter((l) => !l.includes('require('))
            .map((l) => {
                l = l.replace(/\s+$/, '');
                l = l.replaceAll(
                    /^([^\-\r\n]*)[\-]{2}([\-]{2,})?[^\-\r\n].+[ \r\n]*/g,
                    '$1'
                ); // Removes <const> tag, removes --[[ --]] comments, removes double dash comments (not triple dash) from lines with code
                l = l.replaceAll(
                    /table\.insert\(([a-zA-Z0-9\[\]_]+), ([^,\r\n]+)\)( end)?$/g,
                    '$1[#$1 + 1] = $2$3'
                ); // Replace table insert for performance (only on tables of 1ply)
                return l;
            });

        output = `${output}\n${fileData
            .map((str) => str.replace(/\s+$/, ''))
            .filter((str) => str)
            .join('\n')}`;
        fileCount++;
    });

    output = output.replaceAll(
        /"([^"]+?)" \.\. (.+) \.\. "([^"]+?)"/g,
        'table.concat({"$1", $2, "$3"})'
    ); // Remove double string concats with table

    output = output.replaceAll(
        /\(("[a-z]!"), "([^"]+?)" \.\. (.+) \.\. (.+)\)/g,
        '($1, table.concat({"$2", $3, $4}))'
    ); // Same as above, but with notification type parameter

    output = output.replaceAll(
        /for _, ([a-zA-Z0-9_]+) in ipairs\(([a-zA-Z0-9_, ]+)\) do\n( *)/g,
        'for k = 1, #$2 do\n$3local $1 = $2[k]\n$3'
    ); // Reduce function overhead by removing ipairs (only for static tables)

    for (let i = 2; i <= 9; i++) {
        const regex = new RegExp(` ([^\\)]) \\^ ${i}`, 'g');
        output = output.replaceAll(
            regex,
            ` $1${Array(i - 1)
                .fill(' * $1')
                .join('')}`
        );
    } // Remove integer exponentiation and replace with repeated multiplication

    if (fuckify) output = fuckifyOutput(output);

    output = output.replaceAll('\n\n', '\n').trimStart();
    if (lint) {
        const splitOutput = output.split('\n');

        let [functions, fnIndices] = getFunctionList(splitOutput);
        functions = functions.filter((fn, idx) => {
            const cond = fn.startsWith('string') || fn.startsWith('table');
            if (cond) fnIndices.splice(idx, 1);
            return !cond;
        });
        const [_, unusedIndexes] = getUnusedFunctions(
            splitOutput,
            functions,
            fnIndices
        );

        unusedIndexes.reverse().forEach((idx) => {
            let startIdx = idx;
            let endIdx = idx;
            while (/^---/.test(splitOutput[startIdx - 1]) && startIdx > 0)
                startIdx--;
            while (!/^end/.test(splitOutput[endIdx])) endIdx++;
            splitOutput.splice(startIdx, endIdx - startIdx + 1);
        });

        output = splitOutput.join('\n');
    }

    if (existsSync('plugin.lua')) rmSync('plugin.lua');
    writeFileSync('temp.lua', output);
    renameSync('temp.lua', 'plugin.lua');
    if (existsSync('quinsight/intellisense.lua'))
        copyFileSync('quinsight/intellisense.lua', 'intellisense.lua');

    return fileCount;
}

transpiler();
