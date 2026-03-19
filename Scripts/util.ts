/**
 * @File   : util.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 2022/9/26 18:55:36
 */


import { parse } from "@std/csv/parse";
import { format } from "@miyauci/format";
import { Semaphore } from "@core/asyncutil/semaphore";
import { Html5Entities } from 'https://deno.land/x/html_entities@v1.0/mod.js';
import * as path from '@std/path';


export enum ProjectId {
    Vanilla,
    BCC,
    Wrath,
    Cata,
    Mists,
}

interface ProjectData {
    version: string;
    product: string;
    // version_pattern?: RegExp;
}

const WOW_TOOLS = 'https://wow.tools/dbc/api/export/';
const WOW_TOOLS2 = 'https://wago.tools/db2/{name}/csv';
const PROJECTS = new Map([
    [ProjectId.Vanilla, { product: 'wow_classic_era' }],
    [ProjectId.BCC, { product: 'wow_anniversary' }],
    [ProjectId.Wrath, { product: 'wow_classic_titan' }],
    [ProjectId.Mists, { product: 'wow_classic' }],
]);

export function mapLimit<T, U>(array: T[], limit: number, fn: (value: T, index: number, array: T[]) => U) {
    const sem = new Semaphore(limit);
    return array.map((...args) => sem.lock(() => fn(...args)));
}

type Fields = { [key: string]: number | number[] };

export class WowToolsClient {
    pro: ProjectData;

    constructor(projectId: ProjectId) {
        const data = PROJECTS.get(projectId);
        if (!data) {
            throw Error('');
        }

        this.pro = data as ProjectData;
    }

    private async fetchVersions() {
        const resp = await fetch('https://wago.tools/db2');
        const body = await resp.text();
        const match = [...body.matchAll(/data-page="([^"]+)"/g)];
        if (!match || match.length < 1) {
            throw Error('');
        }

        const data = JSON.parse(Html5Entities.decode(match[0][1]));
        const versions = data?.props?.versions;
        return new Set(versions)
    }

    private async fetchVersion() {
        // const exists = await this.fetchVersions();
        const resp = await fetch('https://wago.tools/api/builds');
        const data = await resp.json();

        const versions = data[this.pro.product];
        if (!versions) {
            throw Error();
        }

        // if (this.pro.version_pattern) {
        //     for (const v of versions) {
        //         if (exists.has(v.version) && this.pro.version_pattern.test(v.version)) {
        //             return v.version as string;
        //         }
        //     }
        // } else {
        for (const v of versions) {
            // if (exists.has(v.version)) {
            return v.version as string;
            // }
        }
        // }
        return '';
    }

    decodeFields(row: string[]) {
        const fields = row.map((x, i) => ({ name: x, index: i }));
        const info: Fields = {};

        for (const field of fields) {
            const m = /^(.+)_(\d+)$/g.exec(field.name);

            if (!m) {
                info[field.name] = field.index;
            } else {
                const arrayName = m[1];
                const arrayIndex = Number.parseInt(m[2]);

                info[arrayName] = info[arrayName] || [];
                info[arrayName][arrayIndex] = field.index;
            }
        }
        return info;
    }

    decodeRow(fields: Fields, row: string[]) {
        const obj: { [key: string]: string | string[] } = {};

        for (const [name, index] of Object.entries(fields)) {
            if (Array.isArray(index)) {
                obj[name] = index.map((i) => row[i]);
            } else {
                obj[name] = row[index];
            }
        }
        return obj;
    }

    decodeCSV(data: string) {
        const rows = parse(data);
        const fields = this.decodeFields(rows.splice(0, 1)[0]);
        return rows.map((x) => this.decodeRow(fields, x));
    }

    async fetchTable(name: string, locale = 'enUS', source = 2) {
        if (!this.pro.version) {
            this.pro.version = await this.fetchVersion();
            console.log('version', this.pro.version);
        }

        const url = (() => {
            let url;
            if (source == 2) {
                url = new URL(format(WOW_TOOLS2, { name }));
                url.searchParams.append('build', this.pro.version);
                url.searchParams.append('locale', locale);
            } else if (source == 1) {
                url = new URL(WOW_TOOLS);
                url.searchParams.append('name', name);
                url.searchParams.append('build', this.pro.version);
                url.searchParams.append('locale', locale);
            } else {
                throw Error();
            }
            return url;
        })();

        // const urlhash = name + '_' + encodeHex(await crypto.subtle.digest('MD5', new TextEncoder().encode(url.toString())));
        // const p = path.resolve('.cache', urlhash);
        // if (await fs.exists(p)) {
        //     const body = await Deno.readTextFile(p);
        //     return this.decodeCSV(body);
        // }

        const resp = await fetch(url);
        let body = await resp.text();

        // await Deno.mkdir(path.dirname(p), { recursive: true });
        // await Deno.writeTextFile(p, body);
        return this.decodeCSV(body);
    }
}

export class FileIo {
    private sb: string[] = [];

    constructor(public fileName: string) { }

    write(content: string) {
        this.sb.push(content)
    }

    close() {
        Deno.mkdirSync(path.dirname(this.fileName), { recursive: true });

        const file = Deno.openSync(this.fileName, { create: true, write: true, truncate: true });
        const encoder = new TextEncoder();
        file.writeSync(encoder.encode(this.sb.join('')));
        file.close();
    }
}
