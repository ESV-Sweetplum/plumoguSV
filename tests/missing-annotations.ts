import chalk = require('chalk');
export default function checkMissingAnnotations(file: string[]) {
    const specialIndices = [];
    const indices = file.reduce((idxs, line, idx) => {
        if (line.startsWith('function ') && line.includes('(')) idxs.push(idx);
        if (line.startsWith('function ') && !line.includes(')'))
            specialIndices.push(idx + 1);

        return idxs;
    }, []);

    const testCount = indices.length * 2;
    let failedTests = 0;

    const fnDict = {};
    indices.forEach((index) => {
        const originalIndex = index;
        let fnLine = file[index--];
        const functionName = fnLine.split('(')[0].slice(9);
        const annotatedParamList = [];
        let returnAnnotated = false;
        if (index < 0) {
            console.log(
                `The function ${chalk.red(functionName)} ${chalk.magenta(
                    'does not have an annotated return value.'
                )}`
            );
            failedTests++;
            fnDict[fnLine] = [];
            return;
        }
        while (file[index].includes('---') && index > 0) {
            const line = file[index];
            if (line.includes('@return')) returnAnnotated = true;
            if (line.includes('@param'))
                annotatedParamList.push(line.split(' ')[1].replaceAll('?', ''));
            index--;
        }
        if (specialIndices.includes(originalIndex + 1)) {
            fnLine = `${fnLine} ${file[originalIndex + 1].trim()}`;
        }
        index = originalIndex;
        let returningValue = false;
        while (file[index] !== 'end') {
            if (file[index].match(/return(?!($| end))/)) returningValue = true;
            index++;
        }
        if (!returnAnnotated && returningValue) {
            console.log(
                `The function ${chalk.red(functionName)} ${chalk.magenta(
                    'does not have an annotated return value.'
                )}`
            );
            failedTests++;
        }
        fnDict[fnLine] = annotatedParamList.reverse();
    });

    Object.entries(fnDict).forEach(([fn, annoParams]: [string, string[]]) => {
        const functionName = fn.split('(')[0].slice(9);
        const parameters = fn
            .split('(')[1]
            .split(')')[0]
            .replaceAll(' ', '')
            .split(',')
            .filter((s) => s !== 'settingVars' && s !== 'menuVars');
        if (
            parameters.some((param) => !annoParams.includes(param)) &&
            parameters.map((s) => s.trim()).filter((s) => s).length
        ) {
            const missingParams = parameters.filter(
                (param) => !annoParams.includes(param) && param !== '_'
            );
            console.log(
                `The function ${chalk.red(
                    chalk.bold(functionName)
                )} is missing the following parameters in its annotation: ${chalk.red(
                    missingParams.join(', ')
                )}`
            );
            failedTests++;
        }
    });

    return [failedTests, testCount];
}
