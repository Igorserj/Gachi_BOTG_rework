import QtQuick 2.15
import "../../PhysicalObjects"

Item {
    property var objects: []
    property var metadata: []
    property var objCache: []
    property var metaCache: []
    property var spawnCache: []
    property alias repeater: repeater
    property bool ready: objects.length > 0 ? repeater.numberOfCreatedObjects / objects.length === 1 : true
    onReadyChanged: if (ready) {
                        spawnPoints = spawnPoints.concat(spawnCache)
                        entGen.metadata = entGen.metadata.concat(metaCache)
                        entGen.objects = entGen.objects.concat(objCache)
                        console.log("spawn", spawnPoints)
                    } else entGenClear()

    Repeater {
        id: repeater
        model: objects
        property int numberOfCreatedObjects: 0
        Loader {
            property string type: metadata[index].type !== undefined ? metadata[index].type : ""
            property int curIndex: index
            x: !!modelData[1] ? modelData[1] : 0
            y: !!modelData[2] ? modelData[2] : 0
            width: !!modelData[3] ? modelData[3] : implicitWidth
            height: !!modelData[4] ? modelData[4] : implicitHeight
            sourceComponent: {
                if (modelData[0] === "stair") { return stair }
            }
            onLoaded: {
                if (metadata[index].model !== undefined) item.objects = metadata[index].model
                if (index === 0) {
                    repeater.numberOfCreatedObjects = 1
                }
                else { repeater.numberOfCreatedObjects++ }
                if (index === objects.length - 1) {
                    entGen.repeater.model = entGen.objects
                }
            }
        }
    }

    function entGenClear() {
        metaCache = []
        objCache = []
        spawnCache = []
    }

    Component {
        id: stair
        Stairs {}
    }
}
