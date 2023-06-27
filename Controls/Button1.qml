import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: button
    property string text: "Text"
    property alias buttonArea: buttonArea
    property int animationDuration: 200
    property string alignment: "center"
    width: buttonText.contentWidth + window.recalculatedWidth / 1280 * 30
    height: buttonText.contentHeight + window.recalculatedHeight / 720 * 15
    Rectangle {
        id: buttonRect
        color: button.enabled ? buttonArea.containsMouse && buttonArea.enabled ? style.darkGlass : style.grayGlass : style.blackGlass
        radius: button.enabled ? buttonArea.containsMouse && buttonArea.enabled ? button.height / 2.5 : button.height
                                                            / 5 : button.height / 5
        anchors.fill: parent

        Behavior on color {
            PropertyAnimation {
                target: buttonRect
                property: "color"
                duration: animationDuration
            }
        }
        Behavior on radius {
            PropertyAnimation {
                target: buttonRect
                property: "radius"
                duration: animationDuration
            }
        }
        Text {
            id: buttonText
            text: parent.parent.text
            width: contentWidth
            height: window.recalculatedHeight * 0.05
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
            font.family: fontName//"Comfortaa"
            color: enabled ? "white" : "#FFCCCCCC"
        }
        MouseArea {
            id: buttonArea
            anchors.fill: parent
            enabled: button.enabled
            hoverEnabled: true
        }
    }
    DropShadow {
        anchors.fill: buttonRect
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: buttonRect
    }

    Styles {
        id: style
    }
}
