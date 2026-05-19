import * as fs from 'fs';
import * as path from 'path';

const texturePath = path.join('modules', 'text', 'versionTexture.txt');
const input = fs.readFileSync(texturePath, 'utf-8');

const textureList = input
    .split('--')
    .map(tex =>
        tex
            .split('\n')
            .slice(1)
            .filter(l => l)
            .map(l => l.split(', ').map(n => parseFloat(n)))
            .flat(),
    )
    .slice(1);

enum Texture {
    v,
    Zero,
    One,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Dot,
}

const offsetList = textureList.map(tex => {
    let lowestArr = [1e6, 1e6];
    tex.forEach((n, idx) => {
        const arrIdx = idx % 2;
        lowestArr[arrIdx] = Math.min(n, lowestArr[arrIdx]);
    });

    tex = tex.map((n, idx) => {
        const arrIdx = idx % 2;
        return Math.round((n - lowestArr[arrIdx]) * 100) / 100;
    });

    return tex;
});

const outputList = offsetList.map(arr => `{${arr.join(', ')}}`);

fs.writeFileSync(texturePath, outputList.join('\n'));
