import QtQuick 2.15

CorridorView {
    readonly property var passes: [
        {type: "left"},
        {type: "right"}
    ]
    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y]
    ]
    entGen {
        objects: [["hero", loader.width / 2, floor.y + floor.height / 2]]
        metadata: [
            { name: "Semen" }]
    }
    pobjGen {
        objects: position === 0 ? [["pass", floor.x + floor.width - 10, floor.y, 10, floor.height]] : position === 5 ? [["pass", floor.x, floor.y, 10, floor.height]] : [["pass", floor.x, floor.y, 10, floor.height], ["pass", floor.x + floor.width - 10, floor.y, 10, floor.height]]
        metadata: position === 0 ? [passes[1]] : position === 5 ? [passes[0]] : passes
    }
}
