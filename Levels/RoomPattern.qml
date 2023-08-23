import QtQuick 2.15
import "Generators"

Item {
    property alias objGen: objGen
    property alias entGen: entGen
    property alias itmGen: itmGen
    property alias pobjGen: pobjGen
    property alias room: room
    property var spawnPoints: []
//    onSpawnPointsChanged: console.log(spawnPoints)
    function scripts(scriptName) {}
    Image {
        id: room
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectFit
        PhysicalObjectsGenerator {
            id: pobjGen
        }
        ObjectsGenerator {
            id: objGen
        }
        EntityGenerator {
            id: entGen
        }
        ItemGenerator {
            id: itmGen
        }
    }

    EventHandler {
        id: eventHandler
    }
}
