import QtQuick 2.15

Item {
    id: doors
    Rectangle {
        id: blackBox
        color: "black"
        height: loader.height
        width: loader.width
        clip: true
        Image {
            source: "../Gachi_Vignette.png"
            fillMode: Image.PreserveAspectCrop
            width: parent.width
            height: parent.height
            x: -blackBox.x
        }
    }

    SequentialAnimation {
        id: anim
        running: true
        PropertyAction {
            target: loading
            property: "visible"
            value: true
        }
        PropertyAnimation {
            target: blackBox
            duration: 500
            property: "x"
            easing.type: "InQuad"
            from: loader.width
            to: 0
        }
        ScriptAction {
            script: funcs.finish()
        }
    }

    SequentialAnimation {
        running: !anim.running && loader.item.levelLoader.item.roomLoader.status === Loader.Ready

        PauseAnimation {
            duration: 200
        }
        PropertyAnimation {
            target: blackBox
            duration: 500
            property: "x"
            easing.type: "OutQuad"
            from: 0
            to: -loader.width
        }
        PropertyAction {
            target: loading
            property: "visible"
            value: false
        }
        onFinished: loading.source = ""
    }

    DoorsFunc {
        id: funcs
    }
}
