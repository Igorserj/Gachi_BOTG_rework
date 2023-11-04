import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "MainMenu"
import "Levels"
import "Shaders"
import "Controls" as MyControls
import "Loading"

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    property double recalculatedWidth: width / height > 16 / 9 ? height / 9 * 16 : width
    property double recalculatedHeight: width / height > 16 / 9 ? height : width / 16 * 9
    maximumHeight: recalculatedHeight
    maximumWidth: recalculatedWidth
    minimumHeight: recalculatedHeight
    minimumWidth: recalculatedWidth
    property string comfortaaName: "Arial"//comfortaa.name
    property string monotonName: "Arial"//monoton.name
    property alias loader: loader
    property alias loadingScreen: loadingScreen
    visible: true
    title: "Gachimuchi: Boss of this gym"
    color: "black"
    onClosing: {
        close.accepted = false
        exitDialogLoader.sourceComponent = exitDialog
    }

    Loader {
        id: loader
        x: (window.width - recalculatedWidth) / 2
        y: (window.height - recalculatedHeight) / 2
        z: 0
        sourceComponent: menuCompose

        MyControls.ToolTip {
            id: toolTip
            z: 1
        }
    }
    Loader {
        id: vignetteLoader
        sourceComponent: vignette
    }

    Loading {
        id: loadingScreen
    }

    Loader {
        id: frameTimerLoader
    }
    Loader {
        id: exitDialogLoader
        anchors.fill: parent
        onLoaded: item.show()
    }

    Localization {
        id: locale
    }
    Component {
        id: vignette
        SpotLight {
            image: loader
            upperLimit: 0.75
            lowerLimit: 1.0
            colorR: .85
            colorG: .85
            colorB: .85
            lightPosX: 0.875
            lightPosY: 0.5
            hideControls: true
        }
    }
    Component {
        id: menuCompose
        MenuCompose {
            width: recalculatedWidth
            height: recalculatedHeight
        }
    }

    Component {
        id: levelBuilder
        LevelBuilder {
            width: recalculatedWidth
            height: recalculatedHeight
        }
    }

    Component {
        id: frameTimer
        MyControls.FrameTimer {
        }
    }

    Component {
        id: exitDialog
        MyControls.Dialog {
            mainText: locale.exitDialogText
            anchors.centerIn: parent
            objects: locale.exitDialogOptions
            function actionSet(index) {
                if (index === 0) hide()
                else if (index === 1) {
                    Qt.quit()
                }
            }
        }
    }

    function loadMenu() {
        loader.focus = false
        loader.sourceComponent = menuCompose
    }
    function loadLevel() {
        loader.focus = true
        loader.sourceComponent = levelBuilder
        let seed = []
        for (let i = 0; i < 6; i++) {
            seed.push(Math.floor(Math.random() * 10))
        }
        loader.item.seed = seed
        loader.item.levelChooser()
        console.log(seed)
    }
}
