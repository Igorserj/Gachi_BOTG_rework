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
            y: index > 0 ? repeater.itemAt(index - 1).y - repeater.itemAt(index - 1).height * 0.05 : heightCalc()
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
                property: "scale"
                to: /*repeat !== objects.length - 1 ?*/ stairs.scale + 0.25// : stairs.scale + 0.6
                duration: 350 / stairs.scale
            }
            PropertyAnimation {
                target: stairs
                property: "y"
                to: !!repeater.itemAt(repeat) ? stairs.y - (repeater.itemAt(repeat - 1).y - repeater.itemAt(repeat).y) /** stairs.scale*/ : stairs.y
                duration: 250
                easing.type: "InQuad"
            }
        }
            PauseAnimation {
                duration: 250
            }
        onFinished: {
            finish()
        }
    }

    function heightCalc() {
        let fullHeight = 0
        let height = 0
        let y = 0
        let width = window.width / 6
        for (let i = 1; i < objects.length; i++) {
            width *= 1.14636
            height = width / (358 / 220)
            y -= height * 0.05
            if (i === objects.length - 1) {fullHeight = y + height}
        }
        stairs.scale = 358 / width
        repeater.height = fullHeight
        repeater.width = width
        return (window.height - fullHeight) / 2
    }
    function finish() {
        ++repeat
        if (repeat < objects.length) anim.running = true
    }
}
