import QtQuick 2.15
import ".."

Item {
    property alias objGen: objGen
    property alias entGen: entGen
    Image {
        id: room
        source: "Assets/Room.png"
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectFit
    }
    ObjectsGenerator {
        id: objGen
        objects: [[0, 0, 100, room.height], [room.width - 100, 0, 100, room.height], [0 + 100, room.height, room.width - 200, 100], [100, 0, room.width - 200, 300],
            [170, 320, 50, 50], [220, 370, 50, 50], [270, 420, 50, 50],
            [380, 320, 50, 50], [430, 370, 50, 50], [480, 420, 50, 50]
        ]
    }
    EntityGenerator {
        id: entGen
        objects: [["hero", 1000, 600]/*, ["hostile", 300, 500], ["hostile", 350, 500], ["hostile", 250, 500], ["hostile", 300, 400], ["hostile", 250, 400]*/]
    }
    ItemGenerator {
        id: itmGen
        objects: [[350, 310, 10, 10], [350, 550, 10, 10]]
        metadata: [{name: "Super Vodka", type: "Consumable", isEquipment: false, additionalInfo: "This is super Vodka!", buffName: "HealthHeal", hp: 35}, {name: "Hat"}]
    }

    EventHandler {
        id: eventHandler
    }
}
