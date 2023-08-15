import QtQuick 2.15
import "../.."

RoomPattern {
    room.source: "../Assets/Room.png"
    objGen.objects: [[0, 0, 100, room.height], [room.width - 100, 0, 100, room.height], [0 + 100, room.height, room.width - 200, 100], [100, 0, room.width - 200, 300],
        [170, 320, 50, 50], [220, 370, 50, 50], [270, 420, 50, 50],
        [380, 320, 50, 50], [430, 370, 50, 50], [480, 420, 50, 50]
    ]
    entGen {
        objects: [["hero", 1000, 600], ["npc", 490, 470]]
        metadata: [{name: "Semen"},{name: "Dude", hp: 10, money: 3}]
    }
//    itmGen {
//        objects: []
//        metadata: []
//    }
}
