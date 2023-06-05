import QtQuick 2.15

Item {
    height: window.height
    width: height / 9 * 16
    Image {
        id: background
        property int parallaxDuration: 500
        source: "Assets/bg.png"
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        scale: 1.2
        transform: [
            Rotation {
                id: rotationX
                origin.x: background.width / 2
                origin.y: background.height / 2
                axis {
                    x: 0
                    y: 1
                    z: 0
                }
                angle: 5 * (parallaxArea.mouseX - (background.width / 2)) / background.width
                Behavior on angle {
                    PropertyAnimation {
                        target: rotationX
                        properties: "angle"
                        duration: background.parallaxDuration
                    }
                }
            },
            Rotation {
                id: rotationY
                origin.x: background.width / 2
                origin.y: background.height / 2
                axis {
                    x: 1
                    y: 0
                    z: 0
                }
                angle: -5 * (parallaxArea.mouseY - (background.height / 2)) / background.height
                Behavior on angle {
                    PropertyAnimation {
                        target: rotationY
                        properties: "angle"
                        duration: background.parallaxDuration
                    }
                }
            }
        ]
        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            PropertyAnimation {
                target: background
                property: "scale"
                to: 1.3
                duration: 5000
            }
            PauseAnimation {
                duration: 500
            }
            PropertyAnimation {
                target: background
                property: "scale"
                to: 1.2
                duration: 5000
            }
            PauseAnimation {
                duration: 500
            }
        }
    }
    MouseArea {
        id: parallaxArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
