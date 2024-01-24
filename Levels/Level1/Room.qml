import QtQuick 2.15

RoomView {
    readonly property var enemySpawn: [[floor.x + (25 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height], [floor.x + (25 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height], [floor.x + (25 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height]]
    readonly property var passes: [
        {type: "backward"}
    ]
    readonly property var passPos: [
        ["door", floor.x + floor.width / 2, floor.y + floor.height - (35 * scaleCoeff), 100 * scaleCoeff, 10 * scaleCoeff]
    ]

    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y]
    ]
    entGen {
        objects: [["hero", opSave.level.hero.x, opSave.level.hero.y]].concat(roomEnemy[loader.item.floor][position].map((elem, idx)=> [elem[0], !!elem[1] ? elem[1] : enemySpawn[idx][0], !!elem[2] ? elem[2] : enemySpawn[idx][1]]))
        metadata: [
            { }].concat(opSave.level.hostile.roomEnemyMeta[loader.item.floor][position].map((elem)=>elem))
    }
    pobjGen {
        objects: passPos
        metadata: passes
    }
}
