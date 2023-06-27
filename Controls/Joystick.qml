import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: joystick
    property double posX: 0
    property double posY: 0
    property bool moving: false
    height: parent.height * 0.3
    width: height
    Rectangle {
        id: base
        anchors.fill: parent
        opacity: 0.7
        RadialGradient {
            source: parent
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#666666"
                }
                GradientStop {
                    position: 0.4
                    color: "#000000"
                }
                GradientStop {
                    position: 0.6
                    color: "#FFFFFF"
                }
            }
        }
        radius: width / 2
    }
    Image {
        id: babyImage
        source: "Assets/baby.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height / 4
        width: parent.width / 4
        x: babyArea.pressed ? (babyArea.mouseX + width / 2 > parent.width) ? parent.width - width : (babyArea.mouseX - width / 2 < 0) ? 0 : babyArea.mouseX - width / 2 : (parent.width - width) / 2
        y: babyArea.pressed ? (babyArea.mouseY + height / 2 > parent.height) ? parent.height - height : (babyArea.mouseY - height / 2 < 0) ? 0 : babyArea.mouseY - height / 2 : (parent.height - height) / 2
    }
    MouseArea {
        id: babyArea
        anchors.fill: parent
    }
    SequentialAnimation {
        running: babyArea.pressed
        loops: Animation.Infinite
        ScriptAction {
            script: {
                joystick.enabled ? [posX = (babyImage.x - (base.width - babyImage.width) / 2)
                                    / babyImage.width / 1.5, posX = Math.abs(posX)
                                    > 0.2 ? posX : 0, posY = ((base.height - babyImage.height) / 2
                                                              - babyImage.y) / babyImage.height
                                    / 1.5, moving = true, console.log(
                                        posX + " " + posY), posY = Math.abs(
                                        posY) > 0.2 ? posY : 0, moving = false] : {}
            }
        }
        PauseAnimation {
            duration: 75
        }
    }
}
