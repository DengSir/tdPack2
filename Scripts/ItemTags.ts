/**
 * @File   : ItemTags.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 3/9/2026, 2:20:46 PM
 */

import { FileIo, ProjectId, WowToolsClient } from "./util.ts"

interface DataItem {
    key: string
    url: string
    classId: number
    subClassId?: number
}

const Data: DataItem[] = [
    {
        key: 'Cloth',
        url: 'https://www.wowhead.com/classic/items/trade-goods/cloth',
        classId: 7,
        subClassId: 5,
    },
    {
        key: 'Leather',
        url: 'https://www.wowhead.com/classic/items/trade-goods/leather',
        classId: 7,
        subClassId: 6,
    },
    {
        key: 'MetalStone',
        url: 'https://www.wowhead.com/classic/items/trade-goods/metal-and-stone',
        classId: 7,
        subClassId: 7,
    },
    {
        key: 'Meat',
        url: 'https://www.wowhead.com/classic/items/trade-goods/meat',
        classId: 7,
        subClassId: 8,
    },
    {
        key: 'Herb',
        url: 'https://www.wowhead.com/classic/items/trade-goods/herbs',
        classId: 7,
        subClassId: 9,
    },
    {
        key: 'Elemental',
        url: 'https://www.wowhead.com/classic/items/trade-goods/elemental',
        classId: 7,
        subClassId: 10,
    },
    {
        key: 'Enchanting',
        url: 'https://www.wowhead.com/classic/items/trade-goods/enchanting',
        classId: 7,
        subClassId: 12,
    },
    // {
    //     key: 'Gem',
    //     url: 'https://www.wowhead.com/classic/items/trade-goods/jewelry',
    //     classId: 4,
    // },
    {
        key: 'Parts',
        url: 'https://www.wowhead.com/classic/items/trade-goods/parts',
        classId: 7,
        subClassId: 1,
    },
    {
        key: 'Explosives',
        url: 'https://www.wowhead.com/classic/items/trade-goods/explosives',
        classId: 7,
        subClassId: 2,
    },
    {
        key: 'Mount',
        url: 'https://www.wowhead.com/classic/items/miscellaneous/mounts',
        classId: 15,
        subClassId: 5,
    },
    {
        key: 'Pet',
        url: 'https://www.wowhead.com/classic/items/miscellaneous/companions',
        classId: 15,
        subClassId: 2,
    }
]

const LOCALES: [n: number, l: string, resolve?: string][] = [
    [0, 'enUS'],
    [1, 'koKR'],
    [2, 'frFR'],
    [3, 'deDE'],
    [4, 'zhCN'],
    [5, 'zhTW'],
    [6, 'esES'],
    [7, 'ruRU'],
    [8, 'ptBR'],
    [9, 'itIT'],
]
class App {
    private cli = new WowToolsClient(ProjectId.BCC)

    async fetchTagNames(classId: number, subClassId?: number) {
        const names: { [key: string]: string } = {}
        if (subClassId) {

            const sClassId = classId.toString()
            const sSubClassId = subClassId.toString()

            for (const [_, l, resolve] of LOCALES) {
                const data = await this.cli.fetchTable('ItemSubClass', resolve ? resolve : l)

                const name = data.find(d => d.ClassID === sClassId && d.SubClassID === sSubClassId)?.DisplayName_lang as unknown as string
                if (name) {
                    names[l] = name
                }
            }
        }
        else {
            const sClassId = classId.toString()

            for (const [_, l, resolve] of LOCALES) {
                const data = await this.cli.fetchTable('ItemClass', resolve ? resolve : l)

                const name = data.find(d => d.ID === sClassId)?.ClassName_lang as unknown as string
                if (name) {
                    names[l] = name
                }
            }
        }
        return names
    }

    async fetchItems(url: string) {
        const resp = await fetch(url)
        const body = await resp.text()

        const m = body.match(/WH\.Gatherer\.addData\([\d,\s]+(\{.+\})/)

        const d = JSON.parse(m![1])

        const items = Object.keys(d).map(x => Number.parseInt(x))

        return items
    }

    async run() {
        const io = new FileIo('Data/Tags.lua')

        io.write(`---@diagnostic disable: undefined-global
-- GENERATE BY ItemTags.ts
local ns = select(2, ...)

ns.ITEM_TAGS = {
`)

        for (const { key, url, classId, subClassId } of Data) {
            const names = await this.fetchTagNames(classId, subClassId)
            const items = await this.fetchItems(url)
            console.log(items)

            io.write(`['${key}'] = {\n`)

            io.write(`    name = ns.LocaleChoice{\n`)
            for (const [k, v] of Object.entries(names)) {
                io.write(`        ['${k}'] = '${v}',\n`)
            }
            io.write('    },\n')

            io.write(`    items = {\n`)

            let count = 0
            for (const item of items) {
                if (count === 0) {
                    io.write('        ')
                    count += 8
                }

                const itemStr = `${item},`

                io.write(itemStr)

                count += itemStr.length

                if (count >= 120) {
                    io.write('\n')
                    count = 0
                }
            }

            if (count > 0) {
                io.write('\n')
            }

            io.write('    }\n')
            io.write('},\n')
        }

        io.write('}\n')

        io.close()
    }
}

new App().run()
