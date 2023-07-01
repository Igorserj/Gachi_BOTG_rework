import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../../Controls"

Item {
    id: dialogue
    property var entity1
    property var entity2
    property string name1: ""
    property string name2: ""
    property bool enabled1: false
    property bool enabled2: false
    property int index: 0
    property alias dialogueRect: dialogueRect
    property var actionAfterClose //function actionAfterClose() {}
    property var text: [[name1, "Oh shit, i'm sorry"], [name2, "Sorry for what?"]]

    Rectangle {
        id: dialogueRect
        anchors.bottom: parent.bottom
        height: parent.height * 0.3
        width: parent.width
        color: style.blackGlass
        Rectangle {
            color: "transparent"
            anchors.fill: dialogueRect
            clip: true
            z: dialogueRect.z - 1
            FastBlur {
                y: -dialogueRect.y
                width: levelLoader.width
                height: levelLoader.height
                source: levelLoader
                radius: 32
            }
        }
    }
    Rectangle {//mainHero frame
        id: frame1
        anchors.verticalCenter: dialogueRect.top
        x: dialogueRect.width * 0.05
        radius: width / 8
        clip: true
        color: frame1Loader.status !== Loader.Null ? frame1Loader.item.color : style.grayGlass
        width: height
        height: dialogueRect.height * 0.85
        FaceImage {
            id: image
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            entity: entity1
            Desaturate {
                id: des1
                anchors.fill: parent
                source: parent
                desaturation: enabled1 ? 0 : 1
                Behavior on desaturation {
                    PropertyAnimation {
                        target: des1
                        property: "desaturation"
                        easing.type: "OutCubic"
                        duration: 500
                    }
                }
            }
        }
        Rectangle {
            id: filter1
            color: enabled1 ? "#00000000" : "#44000000"
            anchors.fill: image
            Behavior on color {
                PropertyAnimation {
                    target: filter1
                    property: "color"
                    easing.type: "OutCubic"
                    duration: 500
                }
            }
        }
    }
    Loader {
        id: frame1Loader
        anchors.top: frame1.bottom
        anchors.horizontalCenter: frame1.horizontalCenter
        height: frame1.height * 0.2
        width: frame1.width
        sourceComponent: entity1 === undefined ? undefined : entity1Frame
    }
    Rectangle {//second person frame
        id: frame2
        anchors.verticalCenter: dialogueRect.top
        x: dialogueRect.width * 0.95 - width
        radius: width / 8
        clip: true
        color: frame2Loader.status !== Loader.Null ? frame2Loader.item.color : style.grayGlass
        width: height
        height: dialogueRect.height * 0.85
        FaceImage {
            id: image2
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            entity: entity2
            Desaturate {
                id: des2
                anchors.fill: parent
                source: parent
                desaturation: enabled2 ? 0 : 1
                Behavior on desaturation {
                    PropertyAnimation {
                        target: des2
                        property: "desaturation"
                        easing.type: "OutCubic"
                        duration: 500
                    }
                }
            }
        }
        Rectangle {
            id: filter2
            color: enabled2 ? "#00000000" : "#44000000"
            anchors.fill: image2
            Behavior on color {
                PropertyAnimation {
                    target: filter2
                    property: "color"
                    easing.type: "OutCubic"
                    duration: 500
                }
            }
        }
    }
    Loader {
        id: frame2Loader
        anchors.top: frame2.bottom
        anchors.horizontalCenter: frame2.horizontalCenter
        height: frame2.height * 0.2
        width: frame2.width
        sourceComponent: entity2 === undefined ? undefined : entity2Frame
    }

    Rectangle {
        id: textRect
        property alias entityName: entityText.text
        clip: true
        width: (frame2.x - (frame1.x + frame1.width)) * 0.85
        height: dialogueRect.height * 0.85
        radius: width / 16
        anchors.centerIn: dialogueRect
        color: style.blackGlass
        Rectangle {
            id: entityTextRect
            width: parent.width
            height: 0.3 * parent.height
            color: "transparent"//style.darkGlass
            Text {
                id: entityText
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 72
                fontSizeMode: Text.VerticalFit
                text: dialogue.text[index][0]
                font.family: comfortaaName
                color: enabled ? "white" : "#FF999999"

                visible: false
            }
        }
        Rectangle {
            id: dialogueTextRet
            width: parent.width
            height: parent.height//parent.height - entityTextRect.height
            color: "transparent"//style.darkGlass
            Text {
                id: dialogueText
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                maximumLineCount: 3
                lineHeightMode: Text.FixedHeight
                lineHeight: height / 4
                wrapMode: Text.WordWrap
                font.pixelSize: lineHeight * 0.5
                text: dialogue.text[index][1]
                font.family: comfortaaName
                color: enabled ? "white" : "#FF999999"
            }
        }
    }
    SequentialAnimation {
        id: dialogueTextAnimation
        PropertyAnimation {
            target: dialogueText
            property: "opacity"
            to: 0
            duration: 250
        }
        ScriptAction {script: index++}
        PropertyAnimation {
            target: dialogueText
            property: "opacity"
            to: 1
            duration: 250
        }
    }


    Component {
        id: entity1Frame
        Rectangle {
            anchors.fill: parent
            color: style.blackGlass//textFrame.enabled ? style.blackGlass : style.darkGlass //"transparent"
            Text {
                id: textFrame
                text: entity1.name
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 72
                fontSizeMode: Text.VerticalFit
                font.family: comfortaaName
                color: enabled ? "white" : "#FF999999"
                enabled: textRect.entityName === text
                onEnabledChanged: enabled1 = enabled
                Component.onCompleted: name1 = text
            }
        }
    }

    Component {
        id: entity2Frame
        Rectangle {
            anchors.fill: parent
            color: style.blackGlass//textFrame.enabled ? style.blackGlass : style.darkGlass//textFrame.enabled ? style.blackGlass : style.grayGlass
            Text {
                id: textFrame
                text: entity2.name
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 72
                fontSizeMode: Text.VerticalFit
                font.family: comfortaaName
                color: enabled ? "white" : "#FF999999"
                enabled: textRect.entityName === text
                onEnabledChanged: enabled2 = enabled
                Component.onCompleted: name2 = text
            }
        }
    }

    Styles {
        id: style
    }

    function indexUp() {
        if (index + 1 < text.length) {
            dialogueTextAnimation.running = true
        }
        else {
            ifaceLoader.item.state = "ui"
            return actionAfterClose
        }
    }
}
