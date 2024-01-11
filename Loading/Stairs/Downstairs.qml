import QtQuick 2.15

Item {
    id: stairs
//    property var objects: ["../../PhysicalObjects/Stairs/Stair1.png", "../../PhysicalObjects/Stairs/Stair2.png", "../../PhysicalObjects/Stairs/Stair3.png", "../../PhysicalObjects/Stairs/Stair4.png", "../../PhysicalObjects/Stairs/Stair5.png", "../../PhysicalObjects/Stairs/Stair6.png", "../../PhysicalObjects/Stairs/Stair7.png", "../../PhysicalObjects/Stairs/Stair8.png", "../../PhysicalObjects/Stairs/Stair9.png", "../../PhysicalObjects/Stairs/Stair10.png"]
    property int repeat: 0
    scale: 1.5
    anchors.horizontalCenter: parent.horizontalCenter
    Repeater {
        id: repeater
        model: objects
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            property real scaling: 1 / 1.14636
            source: modelData
            y: index > 0 ? repeater.itemAt(index - 1).y - repeater.itemAt(index - 1).height * 0.05 : funcs.heightCalc()
            width: loader.width / 6 / Math.pow(scaling, index)
            height: width / (sourceSize.width / sourceSize.height)
            fillMode: Image.PreserveAspectFit
        }
        Component.onCompleted: anim.running = true
    }
    SequentialAnimation {
        id: anim
        SequentialAnimation {
            PropertyAction {
                target: loading
                property: "visible"
                value: true
            }
            PropertyAnimation {
                target: stairs
                property: "scale"
                to: stairs.scale + 0.25
                duration: 350 / stairs.scale
            }
            PropertyAnimation {
                target: stairs
                property: "y"
                to: !!repeater.itemAt(repeat) ? stairs.y - (repeater.itemAt(repeat - 1).y - repeater.itemAt(repeat).y) : stairs.y
                duration: 250
                easing.type: "InQuad"
            }
        }
            PauseAnimation {
                duration: 250
            }
        onFinished: {
            funcs.finish()
        }
    }

    SequentialAnimation {
        running: !anim.running && loader.item.levelLoader.item.roomLoader.status === Loader.Ready
        PropertyAction {
            target: loading
            property: "visible"
            value: false
        }
    }

    StairsFunc {
        id: funcs
    }
}
