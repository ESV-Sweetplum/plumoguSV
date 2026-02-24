import { readFileSync, writeFileSync, rmSync, existsSync, renameSync, copyFileSync } from 'fs';
import { getFilesRecursively } from './lib/getFilesRecursively.js';
import getFunctionList from './lib/getFunctionList.js';
import { join, sep } from 'path';
import readAndLintLua from './lib/readAndLintLua.js';
import * as acBuilder from 'ahocorasick';

let counter = 0;

const lineSeparator = '\n';
const separatorLength = lineSeparator.length;

export function getCounterAndIncrement() {
    counter++;
    return counter;
}

export default async function transpiler(
    devMode = false,
    lint = true,
    environment: 'production' | 'development' = 'production',
) {
    counter = 0;
    let fileCount = 0;
    let output = `ENVIRONMENT = "${environment}"`;

    const entryPoints = ['_draw.lua', '_awake.lua'];
    const ignoredFiles = ['intellisense.lua', join('packages', 'tests')];
    if (devMode) output = `${output}${lineSeparator}devMode = true`;

    const files = getFilesRecursively('packages').sort((a, b) => +b.includes('.priority.') - +a.includes('.priority.'));

    files.push(...getFilesRecursively('src').sort((a, b) => +b.includes('.priority.') - +a.includes('.priority.'))); // Force priority functions towards the top to avoid hot-reload error.

    let splicedFileCount = 0;

    const entryFiles: string[] = [...files].reduce((arr, cur, idx) => {
        if (entryPoints.some(e => cur.includes(e))) {
            files.splice(idx - splicedFileCount, 1);
            arr.push(cur);
            splicedFileCount++;
        }
        return arr;
    }, []);

    const entryFileData = entryFiles.reduce((obj, f) => {
        obj[f.split(sep).slice(-1)[0].slice(1)] = readAndLintLua(f);
        return obj;
    }, {});

    files.forEach((file: string) => {
        if ([...ignoredFiles, ...entryPoints].some(f => file.includes(f)) || !file.endsWith('.lua')) return;
        let fileData = readAndLintLua(file).map(l => {
            l = l.replaceAll(/^([^\-\r\n]*)[\-]{2}([\-]{2,})?[^\-\r\n].+[ \r\n]*/g, '$1'); // Removes <const> tag, removes --[[ --]] comments, removes double dash comments (not triple dash) from lines with code
            l = l.replaceAll(/table\.insert\(([a-zA-Z0-9\[\]_]+), ([^,\r\n]+)\)( end)?$/g, '$1[#$1 + 1] = $2$3'); // Replace table insert for performance (only on tables of 1ply)
            return l;
        });

        let fileIsInsert = false;

        // Insert whitespace for nested functions

        Object.entries(entryFileData).forEach(([path, data]: [string, string[]]) => {
            if (!file.includes(`.${path}`)) return;
            const whitespace = entryFileData[path][data.length - 2].match(/^([ ]*)/)[0];
            entryFileData[path].splice(data.length - 1, 0, ...fileData.map(d => `${whitespace}${d}`));
            fileIsInsert = true;
        });

        if (fileIsInsert) return;

        output = `${output}${lineSeparator}${fileData
            .map(str => str.replace(/\s+$/, ''))
            .filter(str => str)
            .join(lineSeparator)}`;
        fileCount++;
    });

    Object.values(entryFileData).forEach((data: string[]) => {
        output = `${output}${lineSeparator}${data.join(lineSeparator)}`;
    });

    output = output.replaceAll(/---@meta [a-zA-Z0-9\-]+\n/g, ''); // Remove meta tags from packages

    output = output.replaceAll(/'([^']+?)' \.\. (.+) \.\. '([^']+?)'/g, "table.concat({'$1', $2, '$3'})"); // Remove double string concats with table

    output = output.replaceAll(
        /(p|P)rint\(('[a-z]{1,7}!'), '([^']+?)' \.\. (.+) \.\. (.+)\)/g,
        "$1rint($2, table.concat({'$3', $4, $5}))",
    ); // Same as above, but with notification type parameter for print statements

    const ipairMatches = [...output.matchAll(/for _, ([a-zA-Z0-9_]+) in ipairs\(([a-zA-Z0-9_, ]+)\) do\n( *)/g)];
    ipairMatches.forEach(match => {
        const idx = getCounterAndIncrement();
        output = output.replace(
            match[0],
            `for k${idx} = 1, #${match[2]} do${lineSeparator}${match[3]}local ${match[1]} = ${match[2]}[k${idx}]${lineSeparator}${match[3]}`,
        );
    }); // Reduce function overhead by removing ipairs (only for static tables)

    for (let i = 2; i <= 5; i++) {
        const regex = new RegExp(` ([^\\)]) \\^ ${i}`, 'g');
        output = output.replaceAll(
            regex,
            ` $1${Array(i - 1)
                .fill(' * $1')
                .join('')}`,
        );
    } // Remove integer exponentiation and replace with repeated multiplication

    output = output.replaceAll(/\ncache.+ = \{\}\n/g, lineSeparator); // Remove cache dictionary instantiation

    for (let i = 9; i >= 1; i--) {
        const obtainmentRegex = new RegExp(
            `(?<!; )cache\\.(?!saveTable|loadTable|[a-zA-Z0-9_\\.]+\\[)([a-zA-Z0-9_]+)${'\\.([a-zA-Z0-9_]+)'.repeat(
                i - 1,
            )}`,
            'g',
        );
        const assignmentRegex = new RegExp(
            `(?<!; )cache${'\\.([a-zA-Z0-9_]+)'.repeat(i)} = ([a-z ]{0,4}(?:[^ \n,]|, | [\\+\\-\\*\\/\\%\\^] )+)`,
            'g',
        );
        output = output.replaceAll(
            assignmentRegex,
            `state.SetValue("${Array(i)
                .fill(0)
                .map((_, idx) => `$${idx + 1}`)
                .join('.')}", $${i + 1})`,
        );
        output = output.replaceAll(
            obtainmentRegex,
            `state.GetValue("${Array(i)
                .fill(0)
                .map((_, idx) => `$${idx + 1}`)
                .join('.')}")`,
        );
    } // Change all cache assignments and cache calls to use state instead

    output = output.replaceAll(/(\r\n|\n{2,})/g, lineSeparator).trimStart();
    if (lint) {
        let linted = false;
        const splitOutput = output.split(lineSeparator);

        while (!linted) {
            linted = true;

            let functions = getFunctionList(splitOutput).filter(
                name => !name.startsWith('string') && !name.startsWith('table') && !['awake', 'draw'].includes(name),
            );

            const ac = new acBuilder(functions.map(fn => [`${fn}(`, `${fn},`, `${fn})`]).flat());
            const acResult = ac.search(output).reduce((obj, arr) => {
                const target = arr[1][0].replaceAll(/[\(,\)]/g, '');
                if (obj[target]) {
                    obj[target].push(arr[0]);
                } else {
                    obj[target] = [arr[0]];
                }
                return obj;
            }, {});

            Object.entries(acResult).forEach(([k, v]: [string, number[]]) => {
                if (v.length > 1) {
                    delete acResult[k];
                } else {
                    acResult[k] = v[0];
                }
            });

            const finalEntries = Object.entries(acResult);

            if (finalEntries.length) {
                linted = false;
            }

            const outputLength = output.length;

            finalEntries.reverse().forEach(([k, v]: [string, number]) => {
                let startIdx = output.lastIndexOf(lineSeparator, v - k.length - 11); // 1 from \n, 9 from `function `, 1 extra to compensate
                let prevStartIdx = startIdx + 4;
                let endIdx = v;
                let endFound = false;

                while (startIdx >= 0) {
                    if (output.slice(startIdx + separatorLength, startIdx + separatorLength + 3) !== '---') break;
                    prevStartIdx = startIdx;
                    startIdx = output.lastIndexOf(lineSeparator, startIdx - 1);
                }

                while (endIdx < outputLength && !endFound) {
                    if (output.slice(endIdx + separatorLength, endIdx + separatorLength + 3) === 'end') endFound = true;
                    endIdx = output.indexOf(lineSeparator, endIdx + 1);
                }

                output = output.replace(output.slice(prevStartIdx, endIdx), '');
            });
        }
    }

    if (existsSync('plugin.lua')) rmSync('plugin.lua');
    writeFileSync('temp.lua', output);
    renameSync('temp.lua', 'plugin.lua');
    if (existsSync('quinsight/intellisense.lua')) copyFileSync('quinsight/intellisense.lua', 'intellisense.lua');

    return fileCount;
}
