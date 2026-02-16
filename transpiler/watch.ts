import transpiler from ".";
import * as chokidar from "chokidar";
import * as chalk from "chalk";
import { performance } from "perf_hooks";

console.log(
    chalk.blueBright(chalk.bold("Watcher initialized and plugin transpiled. Make a change to a file to re-transpile.")),
);

const debounce = (fn: Function, ms = 300) => {
    let timeoutId: ReturnType<typeof setTimeout>;
    return function (this: any, ...args: any[]) {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => fn.apply(this, args), ms);
    };
};

chokidar.watch(["src", "packages"], { ignoreInitial: true }).on(
    "all",
    debounce((event: keyof chokidar.FSWatcherEventMap, path: string) => main(event, path), 100),
);

async function main(event: keyof chokidar.FSWatcherEventMap, path: string) {
    const startTime = performance.now();
    console.log(`\nEvent ${chalk.red(event)} detected on file ${chalk.red(path)}. Now retranspiling...`);

    const fileCount = await transpiler(true, true, "development");
    const endTime = performance.now();
    console.log(
        `Successfully transpiled ${chalk.green(fileCount)} files in ${chalk.green(
            `${Math.round((endTime - startTime) * 100) / 100}ms`,
        )}.\n`,
    );
}

transpiler(true, true, "development");
