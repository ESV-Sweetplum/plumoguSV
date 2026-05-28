import * as fs from 'fs';
import { getFilesRecursively } from './utils/getFilesRecursively';

const paths = getFilesRecursively('./src');
const sizeBound = 1000;

const sizeData = paths
    .map(p => {
        const data = fs.statSync(p);
        return { path: p, size: data.size };
    })
    .filter(o => o.size >= sizeBound);

console.log(sizeData.sort((a, b) => b.size - a.size));
