import QtQuick 2.15

Rectangle {
    property color stamColor: "blue"
    width: 180
    height: 21
    color: "transparent"
    border.width: 2
    Rectangle {
        id: staminaRect
        color: stamColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - parent.border.width
        width: Math.round((modelData[2] / modelData[3] * parent.width - parent.border.width) * 10) / 10
//        Behavior on width {
//            PropertyAnimation {
//                target: staminaRect
//                property: "width"
//                duration: 125
//            }
//        }
        Text {
            anchors.fill: parent
            text: modelData[2].toFixed(1) + " / " + modelData[3]
            font.pointSize: 72
            fontSizeMode: Text.VerticalFit
            font.family: "Comfortaa"
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

        }
    }
}
