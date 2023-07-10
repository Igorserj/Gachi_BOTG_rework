import QtQuick 2.15
import "../../Controls"

Rectangle {
    property string name: ""
    width: 180 * recalculatedWidth / 1280
    height: 21 * recalculatedHeight / 720
    color: style.blackGlass
    Text {
        anchors.fill: parent
        text: name
        font.pointSize: 72
        fontSizeMode: Text.VerticalFit
        font.family: comfortaaName
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Styles {
        id: style
    }
}
