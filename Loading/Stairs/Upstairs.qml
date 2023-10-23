import QtQuick 2.15

Item {
    id: stairs
//    property var objects: ["../../PhysicalObjects/Stairs/Stair1.png", "../../PhysicalObjects/Stairs/Stair2.png", "../../PhysicalObjects/Stairs/Stair3.png", "../../PhysicalObjects/Stairs/Stair4.png", "../../PhysicalObjects/Stairs/Stair5.png", "../../PhysicalObjects/Stairs/Stair6.png", "../../PhysicalObjects/Stairs/Stair7.png", "../../PhysicalObjects/Stairs/Stair8.png", "../../PhysicalObjects/Stairs/Stair9.png", "../../PhysicalObjects/Stairs/Stair10.png"]
    property int repeat: 0
    anchors.horizontalCenter: parent.horizontalCenter
    Repeater {
        id: repeater
        model: objects
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            property real scaling: 1 / 1.14636//1.14159
            source: modelData
            y: index > 0 ? repeater.itemAt(index - 1).y + repeater.itemAt(index - 1).height * 0.19 : funcs.heightCalc()
            width: index > 0 ? repeater.itemAt(index - 1).width / scaling : window.width / 6
            height: width / (sourceSize.width / sourceSize.height)//index > 0 ? repeater.itemAt(index - 1).height / scaling : window.height / 6
            fillMode: Image.PreserveAspectFit
        }
        Component.onCompleted: anim.running = true
    }
    SequentialAnimation {
        id: anim
        SequentialAnimation {
            PropertyAnimation {
                target: stairs
                property: "y"
                to: !!repeater.itemAt(repeat) ? stairs.y - (repeater.itemAt(repeat - 1).y - repeater.itemAt(repeat).y) * stairs.scale : stairs.y
                duration: 250
                easing.type: "InQuad"
            }
            PropertyAnimation {
                target: stairs
                property: "scale"
                to: /*repeat !== objects.length - 1 ?*/ stairs.scale + 0.25// : stairs.scale + 0.6
                duration: 350 / stairs.scale
            }
        }
            PauseAnimation {
                duration: 250
            }
        onFinished: {
            funcs.finish()
        }
    }

    StairsFunc {
        id: funcs
    }
}
