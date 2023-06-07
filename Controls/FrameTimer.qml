import QtQuick 2.15

Item {
    property int frames: 0
    property var statesList: ["disabled", "active"]
    state: "disabled"
    states: [
        State {
            name: "disabled"
            PropertyChanges {
                target: window
                onFrameSwapped: {}
            }
            PropertyChanges {
                target: timer
                running: false
            }
            PropertyChanges {
                target: frameTimer
                visible: false
                frames: 0
            }
        },
        State {
            name: "active"
            PropertyChanges {
                target: frameTimer
                visible: true
                frames: 0
            }
            PropertyChanges {
                target: window
                onFrameSwapped: frames++
            }
            PropertyChanges {
                target: timer
                running: true
            }
        }
    ]
    Rectangle {
        width: window.recalculatedWidth * 0.05
        height: window.recalculatedHeight * 0.05
        color: "#DD363436"
        Text {
            id: fpsText
            anchors.fill: parent
            font.pointSize: 72
            fontSizeMode: Text.VerticalFit
            font.family: "Comfortaa"
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Timer {
        id: timer
        running: true
        repeat: true
        interval: 1000
        onTriggered: frameRate()

    }
    function frameRate() {
        fpsText.text = frames
        frames = 0
    }
}
