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
        objects: [[0, 0, 100, room.height], [room.width - 100, 0, 100, room.height], [0 + 100, room.height, room.width - 200, 100], [100, 0, room.width - 200, 300]]
    }
    EntityGenerator {
        id: entGen
        objects: [["hero", 1000, 400], ["hero", 1000, 600]/*, ["hostile", 300, 500], ["hostile", 350, 500], ["hostile", 250, 500], ["hostile", 300, 400], ["hostile", 250, 400], ["hero", 1000, 600]*/]
    }

    EventHandler {
        id: eventHandler
    }
}
