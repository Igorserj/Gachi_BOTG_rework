import QtQuick 2.15

Rectangle {
    id: sb
    property color stamColor: "blue"
    width: 180
    height: 21
    color: "transparent"
    border.width: 2
    Rectangle {
        id: staminaRect
        color: stamColor
//        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        height: parent.height - parent.border.width
        width: Math.round((modelData[2] / modelData[3] * parent.width - parent.border.width) * 10) / 10
    }
    Text {
        anchors.fill: parent
        text: Math.round(modelData[2]) + " / " + modelData[3]
        font.pointSize: 72
        fontSizeMode: Text.VerticalFit
        font.family: "Comfortaa"
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Rectangle {
        height: sb.height
        width: staminaRect.width - sb.width
        x: sb.width
        color: "yellow"
        border.width: 2
    }
}
