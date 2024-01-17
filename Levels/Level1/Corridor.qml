import QtQuick 2.15

CorridorView {
    readonly property var enemySpawn: [[floor.x + floor.width / 2, floor.y + floor.height / 2], [floor.x + floor.width / 2, floor.y + floor.height / 2 - 60 * scaleCoeff]]
    readonly property var passes: [
        {type: "left"},
        {type: "right"},
        {type: "forward"}
    ]
    readonly property var passPos: [
        ["pass", floor.x + (25 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height],
        ["pass", floor.x + floor.width - (35 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height],
        ["door", floor.x + floor.width / 2, floor.y + (25 * scaleCoeff), 100 * scaleCoeff, 10 * scaleCoeff]
    ]

    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y]
    ]
    entGen {
        objects: [["hero", opSave.level.hero.x, opSave.level.hero.y]].concat(corridorEnemy[loader.item.floor][position].map((elem, idx)=>[elem, enemySpawn[idx][0], enemySpawn[idx][1]]))
        metadata: [
            { }].concat(corridorEnemyMeta[loader.item.floor][position].map((elem)=>elem))
    }
    pobjGen {
        objects: (position === 0 ? [passPos[1]] : position === 5 ? [passPos[0]] : [passPos[0], passPos[1]]).concat(allocation[opSave.level.builder.floor][position] ? [passPos[2]] : [])
        metadata: (position === 0 ? [passes[1]] : position === 5 ? [passes[0]] : [passes[0] , passes[1]]).concat(allocation[opSave.level.builder.floor][position] ? passes[2] : [])
    }
}
