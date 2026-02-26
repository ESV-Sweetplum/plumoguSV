import { readFileSync } from 'fs';

export default function readAndLintLua(path: string) {
    return readFileSync(path, 'utf-8')
        .replaceAll('\r', '')
        .replaceAll(/( *)\<const\> */g, '$1')
        .replaceAll(/\-\-\[\[.*?\-\-\]\][ \r\n]*/gs, '')
        .split('\n')
        .filter(l => l && !l.includes('require('));
}
