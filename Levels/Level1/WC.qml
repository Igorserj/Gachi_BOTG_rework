import QtQuick 2.15

WCView {
    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y], [wall.x, wall.y, wall.width, wall.height]
    ]
    entGen {
        objects: [["hero", loader.width / 2, floor.y + floor.height / 2]]
        metadata: [
            { name: "Semen" }]
    }
}
