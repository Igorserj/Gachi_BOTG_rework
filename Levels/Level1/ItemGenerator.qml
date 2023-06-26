import QtQuick 2.15

Item {
    property var objects: []
    property var metadata: []
    property alias repeater: repeater
    Repeater {
        id: repeater
        model: objects
        Rectangle {
            x: modelData[0]
            y: modelData[1]
            width: modelData[2]
            height: modelData[3]
            Text {
                text: metadata[index].name
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
