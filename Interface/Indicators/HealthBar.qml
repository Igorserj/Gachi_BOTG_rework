import QtQuick 2.15

Rectangle {
    id: hb
    property color hpColor: "green"
    width: 180
    height: 21
    color: "transparent"
    border.width: 2
    Rectangle {
        id: healthBar
        color: hpColor
        x: parent.border.width
        y: (parent.height - height) / 2
        height: parent.height - parent.border.width * 2
        width: modelData[0] / modelData[1] * parent.width - parent.border.width * 2
        Behavior on width {
            PropertyAnimation {
                target: healthBar
                property: "width"
                duration: 100
            }
        }
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
        x: hb.width
        color: "yellow"
        border.width: 2
    }
}
