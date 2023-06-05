import QtQuick 2.15

Rectangle {
    id: button
    property var objects: []
    property int index: 0
    height: window.height * 0.05
    width: childrenRect.width
    state: "collapsed"
    color: "black"
    Component.onCompleted: dropDown.y -= window.height * 0.05 * index
    function actionSet(index) {}

    states: [
        State {
            name: "collapsed"
            PropertyChanges {
                target: dropDownArea
                enabled: true
            }
            PropertyChanges {
                target: button
                clip: true
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                target: dropDownArea
                enabled: false
            }
            PropertyChanges {
                target: button
                clip: false
            }
        }
    ]
    MouseArea {
        id: dropDownArea
        anchors.fill: parent
        onClicked: {
            button.state = "expanded"
        }
    }
    Rectangle {
        id: dropDown
        height: childrenRect.height
        width: childrenRect.width
        color: "#BB787878"

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
                model: objects
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    id: rectangle
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    height: window.height * 0.05
                    width: label.contentWidth + window.width / 1280 * 30
                    Text {
                        id: label
                        x: (parent.width - contentWidth) / 2
                        text: modelData
                        height: parent.height
                        fontSizeMode: Text.VerticalFit
                        font.pointSize: 72
                        font.family: "Comfortaa"
                        color: "white"
                    }
                    MouseArea {
                        anchors.fill: parent
                        enabled: !dropDownArea.enabled
                        onClicked: {
                            dropDown.y -= window.height * 0.05 * (index - button.index)
                            button.index = index
                            actionSet(index)
                        }
                        onCanceled: {
                            button.state = "collapsed"
                        }
                    }
                }
            }
        }
    }
}
