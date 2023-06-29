import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: button
    property string text: "Text"
    property alias buttonArea: buttonArea
    property int animationDuration: 200
    property string alignment: "center"
    property bool active: (buttonArea.containsMouse && buttonArea.enabled) || currentIndex === controlModule.currentIndex
    property int currentIndex: -1
    width: buttonText.contentWidth + window.recalculatedWidth / 1280 * 30
    height: buttonText.contentHeight + window.recalculatedHeight / 720 * 15
    Component.onCompleted: { currentIndex = controlModule.createdComponents; controlModule.createdComponents++ }
    Rectangle {
        id: buttonRect
        color: button.enabled ? active ? style.darkGlass : style.grayGlass : style.blackGlass
        radius: button.enabled ? active ? button.height / 2.5 : button.height
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
            font.family: comfortaaName
            color: enabled ? "white" : "#FFCCCCCC"
        }
        MouseArea {
            id: buttonArea
            anchors.fill: parent
            enabled: button.enabled
            hoverEnabled: enabled
            onClicked: clickFunction()
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
    Connections {
        target: controlModule
        enabled: true
        function onActivateChanged() {
            if (controlModule.activate && active) {
                clickFunction()
            }
        }
        function onCurrentIndexChanged() {
            if (controlModule.currentIndex === -1) currentIndex = -1
        }
    }

    function clickFunction() {}

    Styles {
        id: style
    }
}
