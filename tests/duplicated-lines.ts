import chalk = require("chalk");

export default function checkDuplicatedLines(plugin: string[], toleratedLength: number) {
    const hashmap = {};
    let failedTests = 0;
    let testCount = 0;

    plugin.forEach((line, idx) => {
        const trimmedLine = line.trim();
        if (trimmedLine.startsWith("--")) return;
        if (trimmedLine.startsWith("return")) return;
        if (trimmedLine.startsWith("imgui")) return;
        if (trimmedLine.startsWith("}")) return;
        if (trimmedLine.startsWith('"')) return;
        if (/^[a-zA-Z0-9_]+ = [-a-zA-Z0-9_\.\[\(\)\{\}]+,$/.test(trimmedLine)) return;
        if (!hashmap[trimmedLine]) hashmap[trimmedLine] = { indices: [], count: 0, trueLine: line };
        hashmap[trimmedLine].count++;
        hashmap[trimmedLine].indices.push(idx);
    });

    let lines = [];
    const indices = [];

    Object.keys(hashmap).forEach(k => {
        if (hashmap[k].count < 2) {
            return;
        }
        for (let i = 0; i < hashmap[k].indices.length; i++) lines.push(hashmap[k].trueLine);
        indices.push(...hashmap[k].indices);
    });

    let sorted = false;
    while (!sorted) {
        sorted = true;
        for (let i = 0; i < indices.length - 1; i++) {
            if (indices[i] > indices[i + 1]) {
                sorted = false;
                const tempIdx = indices[i];
                indices[i] = indices[i + 1];
                indices[i + 1] = tempIdx;
                const tempLine = lines[i];
                lines[i] = lines[i + 1];
                lines[i + 1] = tempLine;
            }
        }
    }

    let pluginCursor = 0;
    let dupeArr = [];
    let savedLines = [];

    indices.forEach((idx, trueIdx) => {
        if (idx === pluginCursor + 1) {
            savedLines.push(lines[trueIdx]);
        } else {
            if (savedLines.length > toleratedLength) {
                dupeArr.push(savedLines.join("\n"));
                failedTests++;
            }
            testCount++;
            savedLines = [lines[trueIdx]];
        }
        pluginCursor = idx;
    });

    dupeArr = [...new Set(dupeArr)];

    dupeArr.forEach(dupe => {
        console.log(chalk.bgCyanBright(chalk.black("\nThe following code block has been repeated in code:\n")));
        console.log(chalk.bgRedBright(dupe));
    });

    return [failedTests, testCount];
}
