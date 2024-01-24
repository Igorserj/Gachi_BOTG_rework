import QtQuick 2.15

WCView {
    readonly property var enemySpawn: [[floor.x + floor.width / 2, floor.y + floor.height / 2], [floor.x + floor.width / 2, floor.y + floor.height / 2 - 60 * scaleCoeff]]
    readonly property var passes: [
        {type: "backward"}
    ]
    readonly property var passPos: [
        ["door", floor.x + (25 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height]
    ]

    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y], [wall.x, wall.y, wall.width, wall.height]
    ]
    entGen {
        objects: [["hero", opSave.level.hero.x, opSave.level.hero.y]].concat(opSave.level.hostile.roomEnemy[loader.item.floor][position].map((elem, idx)=> [elem[0], !!elem[1] ? elem[1] : enemySpawn[idx][0], !!elem[2] ? elem[2] : enemySpawn[idx][1]]))
        metadata: [
            { }].concat(opSave.level.hostile.roomEnemyMeta[loader.item.floor][position].map((elem)=>elem))
    }
    pobjGen {
        objects: passPos
        metadata: passes
    }
}
