import QtQuick 2.15

CorridorView {
    readonly property var passes: [
        {type: "left"},
        {type: "right"}
    ]
    readonly property var passPos: [["pass", floor.x + floor.width - (35 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height],
    ["pass", floor.x + (25 * scaleCoeff), floor.y, 10 * scaleCoeff, floor.height]]

    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y]
    ]
    entGen {
        objects: [["hero", opSave.level.hero.x, opSave.level.hero.y]]
        metadata: [
            { name: "Semen" }]
    }
    pobjGen {
        objects: position === 0 ? [passPos[0]] : position === 5 ? [passPos[1]] : [passPos[1], passPos[0]]
        metadata: position === 0 ? [passes[1]] : position === 5 ? [passes[0]] : passes
    }
}
