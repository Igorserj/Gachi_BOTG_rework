import QtQuick 2.15

RoomView {
    readonly property var passes: [
        {type: "backward"}
    ]
    readonly property var passPos: [
        ["door", floor.x + floor.width / 2, floor.y + floor.height - (35 * scaleCoeff), 100 * scaleCoeff, 10 * scaleCoeff]
    ]

    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y]
    ]
    entGen {
        objects: [["hero", opSave.level.hero.x, opSave.level.hero.y]]
        metadata: [
            { }]
    }
    pobjGen {
        objects: passPos
        metadata: passes
    }
}
