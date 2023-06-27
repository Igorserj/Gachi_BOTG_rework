import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: button
    property string text: "Text"
    property alias buttonArea: buttonArea
    property int animationDuration: 200
    property string alignment: "center"
    width: buttonText.contentWidth * 1.5
    height: buttonText.contentHeight * 1.5
    Rectangle {
        id: buttonRect
        anchors.fill: parent
        color: "transparent"
        Text {
            id: buttonText
            text: parent.parent.text
            width: contentWidth
            height: window.height * 0.05
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: alignment === "center" ? parent.horizontalCenter : undefined
            anchors.left: alignment === "left" ? parent.left : undefined
            anchors.right: alignment === "right" ? parent.right : undefined
            horizontalAlignment: alignment
                                 === "center" ? Text.AlignHCenter : alignment
                                                === "left" ? Text.AlignLeft : Text.AlignRight
            verticalAlignment: alignment
                               === "center" ? Text.AlignVCenter : alignment
                                              === "left" ? Text.AlignLeft : Text.AlignRight
            font.pointSize: 72
            fontSizeMode: Text.VerticalFit
            font.family: fontName
            font.bold: true
            color: buttonArea.containsMouse ? "#CCCCCC" : "#EEEEEE"
            //            style: Text.Outline
            //            styleColor: "black"
        }
        MouseArea {
            id: buttonArea
            anchors.fill: parent
            enabled: button.enabled
            hoverEnabled: true
        }
    }
}
