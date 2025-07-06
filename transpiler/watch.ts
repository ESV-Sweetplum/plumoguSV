import transpiler from ".";
import * as chokidar from "chokidar";
import * as chalk from "chalk";

console.log(
    chalk.blueBright(
        chalk.bold("Watcher initialized. Make a change to a file to transpile.")
    )
);

let devMode = false;

const debounce = (fn: Function, ms = 300) => {
    let timeoutId: ReturnType<typeof setTimeout>;
    return function (this: any, ...args: any[]) {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => fn.apply(this, args), ms);
    };
};

chokidar.watch(["src", "packages"], { ignoreInitial: true }).on(
    "all",
    debounce((event: keyof chokidar.FSWatcherEventMap, path: string) => main(event, path), 100)
);

async function main(event, path) {
    const startTime = Date.now();
    console.log(
        `\nEvent ${chalk.red(event)} detected on file ${chalk.red(
            path
        )}. Now retranspiling...`
    );

    const devMode = path.includes("src\\dev\\unlock");
    const fileCount = await transpiler(devMode);
    const endTime = Date.now();
    console.log(
        `Successfully transpiled ${chalk.green(
            fileCount
        )} files in ${chalk.green(`${endTime - startTime}ms`)}.\n`
    );
}
