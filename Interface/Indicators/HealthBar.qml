import QtQuick 2.15
import "../../Controls"

Rectangle {
    id: hb
    property color hpColor: "#008800"//"green"
    width: 180 * recalculatedWidth / 1280
    height: 21 * recalculatedHeight / 720
    color: style.blackGlass
    border.width: 2
    Rectangle {
        id: healthBar
        color: hpColor
        x: parent.border.width
        y: (parent.height - height) / 2
        height: parent.height - parent.border.width * 2
        width: modelData[0] / modelData[1] * parent.width - parent.border.width * 2 > hb.width ? hb.width * 1.05 : modelData[0] / modelData[1] * parent.width - parent.border.width * 2
//        z: hb.z - 1
    }
    Text {
        anchors.fill: parent
        text: modelData[0] + " / " + modelData[1]
        font.pointSize: 72
        fontSizeMode: Text.VerticalFit
        font.family: comfortaaName
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Rectangle {
        height: hb.height
        width: healthBar.width - hb.width
        x: healthBar.width - width + healthBar.x
        color: "yellow"
        border.width: 2
    }

    Styles {
        id: style
    }
}
