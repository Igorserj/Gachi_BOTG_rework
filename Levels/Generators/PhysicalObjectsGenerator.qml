import QtQuick 2.15
import "../../PhysicalObjects"

Item {
    property var objects: []
    property var metadata: []
    property alias repeater: repeater
    property bool ready: repeater.numberOfCreatedObjects / objects.length === 1
    Repeater {
        id: repeater
        model: objects
        property int numberOfCreatedObjects: 0
        Loader {
            property string type: metadata[index].type !== undefined ? metadata[index].type : ""
            x: !!modelData[1] ? modelData[1] : 0
            y: !!modelData[2] ? modelData[2] : 0
            width: !!modelData[3] ? modelData[3] : implicitWidth
            height: !!modelData[4] ? modelData[4] : implicitHeight
            sourceComponent: {
                if (modelData[0] === "stair") { return stair }
            }
            onLoaded: {
                if (metadata[index].model !== undefined) item.objects = metadata[index].model
//                if (metadata[index].type !== undefined) item.type = metadata[index].type
            }
        }
    }

    Component {
        id: stair
        Stairs {}
    }
}
