import QtQuick 2.15
import "Generators"

Item {
    property alias objGen: objGen
    property alias entGen: entGen
    property alias itmGen: itmGen
    property alias pobjGen: pobjGen
    property alias room: room
    property alias eventHandler: eventLoader.item
    property alias eventLoader: eventLoader
    property var spawnPoints: []
    property bool ready: pobjGen.ready && entGen.ready
    function scripts(scriptName) {}
    width: loader.width
    height: loader.height
    onReadyChanged: { ready ? [lootSpawn(), heroTp()] : {} }

    function heroTp() {
        if (spawnPoints.length > 0) {
            const hX = entGen.objects[0][1]
            const hY = entGen.objects[0][2]
            let distance = loader.width + loader.height
            let index = -1
            let curDist = 0
            for (let i = 0; i < spawnPoints.length; i++) {
                curDist = Math.sqrt(Math.pow(hX - spawnPoints[i][0], 2) + Math.pow(hY - spawnPoints[i][1], 2))
                if (curDist < distance) {
                    index = i
                    distance = curDist
                }
            }
            entGen.repeater.itemAt(0).x = spawnPoints[index][0] - entGen.repeater.itemAt(0).item.width / 2
            entGen.repeater.itemAt(0).y = spawnPoints[index][1] - entGen.repeater.itemAt(0).item.height / 2
        }
    }
    function lootSpawn() {
        const pool = inRoom ? opSave.level.items.roomsLayout[loader.item.floor][position].slice() : opSave.level.items.corridorsLayout[loader.item.floor][position].slice()
        itmGen.objects = pool.map((a)=>[
                                      !!a.x ? a.x : floor.x + floor.width / 2,
                                      !!a.width ? a.y : floor.y + floor.height / 2,
                                      !!a.width ? a.width : 10 * scaleCoeff,
                                      !!a.height ? a.height : 10 * scaleCoeff])
        itmGen.metadata = pool
        // itmGen.objects = [[350 * scaleCoeff, 600 * scaleCoeff, 10 * scaleCoeff, 10 * scaleCoeff]]
        // itmGen.metadata = [
        //             {name: "Mask", additionalInfo: "Maska tupa", buffName: "HealthUp", points: 10, type: "Head", isEquipment: true}
    }

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

    Loader {
        id: eventLoader
        sourceComponent: eventComponent
    }
    Component {
        id: eventComponent
        EventHandler {
        }
    }
}
