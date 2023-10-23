import QtQuick 2.15
import "Generators"

Item {
    property alias objGen: objGen
    property alias entGen: entGen
    property alias itmGen: itmGen
    property alias pobjGen: pobjGen
    property alias room: room
    property var spawnPoints: []
    function scripts(scriptName) {}
    width: room.width
    height: room.height

    Image {
        id: room
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectFit
    }
    PhysicalObjectsGenerator {
        id: pobjGen
        z: room.z + 1
    }
    ObjectsGenerator {
        id: objGen
        z: room.z + 1
    }
    EntityGenerator {
        id: entGen
        z: room.z + 1
    }
    ItemGenerator {
        id: itmGen
        z: room.z + 1
    }

    EventHandler {
        id: eventHandler
    }
}
