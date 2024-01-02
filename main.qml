import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "MainMenu"
import "Levels"
import "Shaders"
import "Controls" as MyControls
import "Loading"
import "Saves"

ApplicationWindow {
    id: window
    width: opSave.settings.screenProps.width
    height: opSave.settings.screenProps.height
    readonly property double recalculatedWidth: (width / height > 16 / 9) ? height / 9 * 16 : width
    readonly property double recalculatedHeight: ((width / height > 16 / 9) ? height : width / 16 * 9) - heading.height
    readonly property double scaleCoeff: loader.width / 1280
    readonly property string comfortaaName: "Arial"//comfortaa.name
    readonly property string monotonName: "Arial"//monoton.name
    property alias loader: loader
    property alias loadingScreen: loadingScreen
    flags: (Qt.FramelessWindowHint | Qt.Window)
    visible: true
    title: "Gachimuchi: Boss of this gym"
    color: "black"
    onClosing: {
        close.accepted = false
        exitDialogLoader.sourceComponent = exitDialog
    }

    Item {
        id: container
        clip: true
        x: (window.width - width) / 2
        y: heading.y + heading.height
        width: opSave.settings.screenProps.visibility === 2 ? recalculatedHeight * 16 / 9 : recalculatedWidth
        height: opSave.settings.screenProps.visibility === 2 ? recalculatedHeight : recalculatedHeight + heading.height
        Loader {
            id: loader
            width: parent.width
            height: parent.height
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

        Operational {
            id: opSave
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
                width: parent.width
                height: parent.height
            }
        }

        Component {
            id: levelBuilder
            LevelBuilder {
                width: parent.width
                height: parent.height
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
    }

    MyControls.Heading {
        id: heading
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
