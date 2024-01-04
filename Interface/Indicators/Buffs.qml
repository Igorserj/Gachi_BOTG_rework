import QtQuick 2.15

Column {
    id: buffCol
    Rectangle {
        width: height
        height: 21 * scaleCoeff
        radius: width / 8
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                toolTip.mainText = modelData[1]
                toolTip.addText = modelData[2]
                toolTip.show(buffCol.x + buffCol.width + heroesRepeater.x, heroesRepeater.y + buffCol.y)
            }
            onExited: toolTip.hide()
        }
    }
    Rectangle {
        id: textPlaceholder
        color: "#DD363436"
        width: height
        height: 21 * scaleCoeff
        Text {
            text: modelData[0] > 99 ? "##" : modelData[0]
            height: parent.height
            width: parent.width
            fontSizeMode: Text.VerticalFit
            font.pointSize: 72
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: comfortaaName
            color: "white"
        }
    }
}
