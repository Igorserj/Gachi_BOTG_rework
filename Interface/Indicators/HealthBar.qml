import QtQuick 2.15

Rectangle {
    property color hpColor: "green"
    width: 180
    height: 21
    color: "transparent"
    border.width: 2
    Rectangle {
        id: healthBar
        color: hpColor
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        height: parent.height - parent.border.width
        width: modelData[0] / modelData[1] * parent.width - parent.border.width
        Text {
            anchors.fill: parent
            text: modelData[0] + " / " + modelData[1]
            font.pointSize: 72
            fontSizeMode: Text.VerticalFit
            font.family: "Comfortaa"
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
