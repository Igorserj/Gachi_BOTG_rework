import QtQuick 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: button
    property var objects: []
    property int index: 0
    property var activeCells: []
    property int animationDuration: 200
    height: window.recalculatedHeight * 0.05 + window.recalculatedHeight / 720 * 15
    width: childrenRect.width
    state: "collapsed"
    color: "transparent"
    function actionSet(index) {}

    states: [
        State {
            name: "collapsed"
        },
        State {
            name: "expanded"
        }
    ]
    Rectangle {
        id: dropDown
        y: -button.height * button.index
        height: childrenRect.height
        width: childrenRect.width
        color: "transparent"

        Behavior on y {
            SequentialAnimation {
                PropertyAnimation {
                    target: dropDown
                    property: "y"
                    duration: 250
                    easing.type: Easing.OutCubic
                }
                ScriptAction {script: button.state = "collapsed"}
            }
        }

        Column {
            id: col
            Repeater {
                id: repeater
                property double maxWidth: 0
                model: objects
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    id: rectangle
                    opacity: button.state === "expanded" ? 1 : button.index === index ? 1 : 0
                    enabled: typeof(activeCells[index]) !== "undefined" ? activeCells[index] : true
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: button.height
                    width: repeater.maxWidth + window.recalculatedWidth / 1280 * 30
                    color: enabled ? rectangleArea.containsMouse ? style.darkGlass : style.grayGlass : style.blackGlass

                    radius: enabled ? rectangleArea.containsMouse ? rectangle.height / 2.5 : rectangle.height
                                                                        / 5 : rectangle.height / 5
                    Behavior on radius {
                        PropertyAnimation {
                            target: rectangle
                            property: "radius"
                            duration: animationDuration
                        }
                    }
                    Behavior on color {
                        PropertyAnimation {
                            target: rectangle
                            property: "color"
                            duration: animationDuration
                        }
                    }
                    Behavior on opacity {
                        PropertyAnimation {
                            target: rectangle
                            property: "opacity"
                            duration: animationDuration
                        }
                    }
                    Component.onCompleted: label.contentWidth > repeater.maxWidth ? repeater.maxWidth = label.contentWidth : {}
                    Text {
                        id: label
                        x: (parent.width - contentWidth) / 2
                        y: (parent.height - height) / 2
                        text: modelData
                        verticalAlignment: Text.AlignVCenter
                        height: window.recalculatedHeight * 0.05
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 72
                        font.family: "Comfortaa"
                        color: rectangle.enabled ? "white" : "#FFCCCCCC"
                    }
                    MouseArea {
                        id: rectangleArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (button.index === index && button.state === "expanded") {
                                button.state = "collapsed"
                            }
                            else {
                                button.state = "expanded"
                                button.index = index
                                actionSet(index)
                            }
                        }
                        onCanceled: {
                            button.state = "collapsed"
                        }
                    }
                }
            }
        }
    }
    DropShadow {
        id: shadow
        anchors.fill: dropDown
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        z: button.z - 1
        color: "#80000000"
        source: dropDown
    }

    function reload() {
        repeater.model = []
        repeater.maxWidth = 0
        repeater.model = Qt.binding(function() {return objects})
    }

    Styles {
        id: style
    }

    Connections {
        target: window
        function onWidthChanged() {
            reload()
        }
        function onHeightChanged() {
            reload()
        }
    }
}
