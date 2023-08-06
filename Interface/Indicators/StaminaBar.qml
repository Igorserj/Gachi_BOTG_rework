import QtQuick 2.15
import "../../Controls"

Rectangle {
    id: sb
    property color stamColor: "#3333AA"//"blue"
    width: 180 * recalculatedWidth / 1280
    height: 21 * recalculatedHeight / 720
    color: style.blackGlass
    border.width: 2
    Rectangle {
        id: staminaRect
        color: stamColor
        x: parent.border.width
        y: (parent.height - height) / 2
        height: parent.height -  parent.border.width * 2
        width: modelData[2] / modelData[3] * parent.width - parent.border.width * 2 > sb.width ? sb.width * 1.05 : modelData[2] / modelData[3] * parent.width - parent.border.width * 2
//        z: sb.z - 1
    }
    Text {
        anchors.fill: parent
        text: Math.round(modelData[2]) + " / " + modelData[3]
        font.pointSize: 72
        fontSizeMode: Text.VerticalFit
        font.family: comfortaaName
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Rectangle {
        height: sb.height
        width: staminaRect.width - sb.width + staminaRect.border.width * 2 + staminaRect.x
        x: sb.width - staminaRect.border.width * 2
        color: "yellow"
        border.width: 2
    }

    Styles {
        id: style
    }
}
