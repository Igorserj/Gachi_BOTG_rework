import QtQuick 2.15

LibraryView {
    readonly property var passes: [
        {type: "backward"}
    ]
    readonly property var passPos: [
        ["door", floor.x + (25 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height]
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
