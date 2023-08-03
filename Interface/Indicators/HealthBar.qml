import QtQuick 2.15
import "../../Controls"

Rectangle {
    id: hb
    property color hpColor: "#008800"//"green"
    property bool leftAlign: true
    width: 180 * recalculatedWidth / 1280
    height: 21 * recalculatedHeight / 720
    color: style.blackGlass
    border.width: 2
    Rectangle {
        id: healthBar
        color: hpColor
        x: leftAlign ? parent.border.width : parent.width - width - parent.border.width
        y: (parent.height - height) / 2
        height: parent.height - parent.border.width * 2
        width: modelData[0] / modelData[1] * parent.width - parent.border.width * 2 > hb.width ? hb.width * 1.05 : modelData[0] / modelData[1] * parent.width - parent.border.width * 2
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
        width: leftAlign ? healthBar.width - hb.width + healthBar.border.width * 2 + healthBar.x : healthBar.width - hb.width + healthBar.border.width * 4
        x: leftAlign ? hb.width - healthBar.border.width * 2 : -width + healthBar.border.width * 2
        color: "yellow"
        border.width: 2
    }

    Styles {
        id: style
    }
}
