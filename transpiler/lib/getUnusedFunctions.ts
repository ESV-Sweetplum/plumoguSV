export default function getUnusedFunctions(file: string[], functionNames: string[], functionIndices: number[]) {
    const globals = ["awake", "draw"];

    const totalFile = file.join("\n");

    const unusedFunctions = [];
    const unusedIndexes = [];
    functionNames.forEach((fn, idx) => {
        if (totalFile.match(new RegExp(String.raw`${fn}[\(,\)]`, "gd"))?.length == 1 && !globals.includes(fn)) {
            unusedFunctions.push(functionNames[idx]);
            unusedIndexes.push(functionIndices[idx]);
        }
    });
    return [unusedFunctions, unusedIndexes];
}
