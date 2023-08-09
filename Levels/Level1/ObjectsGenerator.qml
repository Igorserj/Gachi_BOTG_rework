import QtQuick 2.15

Item {
    property var objects: []
    property alias repeater: repeater
    Repeater {
        id: repeater
        model: objects
        property int numberOfCreatedObjects: 0
        Rectangle {
            x: modelData[0]
            y: modelData[1]
            width: modelData[2]
            height: modelData[3]
            border.width: 2
            color: "transparent"
        }
        onItemAdded: repeater.numberOfCreatedObjects++
    }
}
