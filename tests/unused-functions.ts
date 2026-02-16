import chalk = require("chalk");
import getFunctionList from "../transpiler/lib/getFunctionList";

export default function checkUnusedFunctions(file: string[]) {
    const functions = getFunctionList(file)[0];

    const globals = ["awake", "draw"];

    const testCount = functions.length;
    let failedTests = 0;

    functions.forEach(fn => {
        if (file.join("\n").match(new RegExp(String.raw`${fn}[\(,\)]`, "gd"))?.length == 1 && !globals.includes(fn)) {
            console.log(`${chalk.red(fn)} is an unused function.`);
            failedTests++;
        }
    });

    return [failedTests, testCount];
}
