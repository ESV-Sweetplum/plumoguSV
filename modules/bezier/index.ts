import * as fs from 'fs';
import * as path from 'path';

class Point {
    constructor(
        public x: number = 0,
        public y: number = 0,
        public tolerance: number = 1e-8,
    ) {}

    equals(pt: Point) {
        return (
            Math.abs(this.x - pt.x) < this.tolerance &&
            Math.abs(this.y - pt.y) < this.tolerance
        );
    }

    stringify() {
        return `${this.x.toFixed(2)}, ${this.y.toFixed(2)}`;
    }
}

class CubicBezier {
    constructor(
        public p1: Point = new Point(0, 0),
        public p2: Point = new Point(0, 0),
        public p3: Point = new Point(0, 0),
        public p4: Point = new Point(0, 0),
    ) {}

    isZero() {
        if (this.p1.x !== this.p2.x) return false;
        if (this.p1.x !== this.p3.x) return false;
        if (this.p1.x !== this.p4.x) return false;
        if (this.p1.y !== this.p2.y) return false;
        if (this.p1.y !== this.p3.y) return false;
        if (this.p1.y !== this.p4.y) return false;

        return true;
    }

    stringify() {
        return [
            this.p1.stringify(),
            this.p2.stringify(),
            this.p3.stringify(),
            this.p4.stringify(),
        ];
    }
}

const files = fs
    .readdirSync(path.join('modules', 'bezier', 'data'))
    .filter((p: string) => p.endsWith('.bezier'));

function vectorize(str: string): Point {
    const params = str.split(/, ?/);
    const roundingFactor = 0.01;
    const x =
        Math.round(parseFloat(params[0]) / roundingFactor) * roundingFactor;
    const y =
        Math.round(parseFloat(params[1]) / roundingFactor) * roundingFactor;
    return new Point(x, y);
}

files.forEach((p: string) => {
    const curveList: CubicBezier[] = [];
    const contents = fs
        .readFileSync(path.join('modules', 'bezier', 'data', p), 'utf-8')
        .replaceAll('\r', '')
        .split('\n')
        .filter((l: string) => l);

    const dim = vectorize(contents[0]);
    const name = p.replaceAll('.bezier', '');

    const startingFile = `
---Draws ${name} on screen, with dimensions = scale * ${JSON.stringify(dim)}.
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function draw${name.charAt(0).toUpperCase()}${name.slice(1).replaceAll('.', '')}(ctx, location, scale, col, thickness)
location = location - vector.New(${dim.x / 2}, ${dim.y / 2}) * scale
`.trim();

    let currentLocation = vectorize(contents[1].split('M, ')[1]);
    for (let i = 1; i < contents.length; i++) {
        const line = contents[i];
        if (line.startsWith('M, ')) {
            currentLocation = vectorize(line.split('M, ')[1]);
        } else if (line.startsWith('C, ')) {
            const pointList = line.split('C, ')[1];
            const matches = (pointList.match(/[0-9\.]+, [0-9\.]+/g) ?? []).map(
                (match: string) => vectorize(match),
            );
            curveList.push(
                new CubicBezier(
                    currentLocation,
                    matches[0],
                    matches[1],
                    matches[2],
                ),
            );
            currentLocation = matches[2];
        }
    }
    let file = startingFile;
    curveList.forEach(curve => {
        if (curve.isZero()) return;
        const pts = curve.stringify();

        file = `${file}\nctx.AddBezierCubic(location + scale * vector.New(${pts[0]}), location + scale * vector.New(${pts[1]}), location + scale * vector.New(${pts[2]}), location + scale * vector.New(${pts[3]}), col, thickness)`;
    });

    const outDir = path.join('modules', 'bezier', 'out');

    if (!fs.existsSync(outDir)) fs.mkdirSync(outDir);

    fs.writeFileSync(path.join(outDir, `${name}.lua`), `${file}\nend`.trim());
});
