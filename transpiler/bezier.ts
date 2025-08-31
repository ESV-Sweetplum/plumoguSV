import * as fs from 'fs';
import * as path from 'path';

const files = fs.readdirSync('bezier').filter((p) => p.endsWith('bezier'));

function vectorize(str) {
    const params = str.split(', ');
    const x = parseFloat(params[0]);
    const y = parseFloat(params[1]);
    return [x, y];
}

files.forEach((p) => {
    const curveList = [];
    const contents = fs
        .readFileSync(path.join('bezier', p), 'utf-8')
        .replaceAll('\r', '')
        .split('\n')
        .filter((l) => l);

    const dim = vectorize(contents[0]);

    const name = p.replaceAll('.bezier', '');

    const startingFile = `
---Draws ${name} on screen, with dimensions = scale * ${JSON.stringify(dim)}.
---@param ctx ImDrawListPtr
---@param windowSize Vector2
---@param location number
---@param scale number
---@param col integer
---@param thickness integer
function draw${name.charAt(0).toUpperCase()}${name.slice(
        1
    )}(ctx, windowSize, location, scale, col, thickness)
location = location - vector.New(${dim[0] / 2}, ${dim[1] / 2}) * scale
`.trim();

    let currentLocation = vectorize(contents[1].split('M, ')[1]);
    for (let i = 1; i < contents.length; i++) {
        const line = contents[i];
        if (line.startsWith('M, ')) {
            currentLocation = vectorize(line.split('M, ')[1]);
        } else if (line.startsWith('C, ')) {
            const pointList = line.split('C, ')[1];
            const matches = pointList
                .match(/[0-9\.]+, [0-9\.]+/g)
                .map((match) => vectorize(match));
            curveList.push([
                currentLocation,
                matches[0],
                matches[1],
                matches[2],
            ]);
            currentLocation = matches[2];
        }
    }
    let file = startingFile;
    curveList.forEach((curve) => {
        file = `${file}\nctx.AddBezierCubic(vector.New(${curve[0][0]}, ${curve[0][1]}), vector.New(${curve[1][0]}, ${curve[1][1]}), vector.New(${curve[2][0]}, ${curve[2][1]}), vector.New(${curve[3][0]}, ${curve[3][1]}), col, thickness)`;
    });

    if (!fs.existsSync(path.join('bezier', 'out')))
        fs.mkdirSync(path.join('bezier', 'out'));

    fs.writeFileSync(
        path.join('bezier', 'out', `${name}.lua`),
        `${file}\nend`.trim()
    );
});
