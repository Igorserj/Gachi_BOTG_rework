import QtQuick 2.15
import "../../PhysicalObjects"

Item {
    property var objects: []
//    property bool ready: repeater.numberOfCreatedObjects / objects.length === 1
    Repeater {
        id: repeater
        model: objects
        property int numberOfCreatedObjects: 0
        Collider {
            x: modelData[0]
            y: modelData[1]
            width: modelData[2]
            height: modelData[3]
        }
        onItemAdded: repeater.numberOfCreatedObjects++
    }
}
