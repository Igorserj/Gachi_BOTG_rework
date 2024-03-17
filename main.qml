import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "MainMenu"
import "Levels"
import "Shaders"
import "Controls" as Controls
import "Loading"
import "Saves"
import "Localization"

ApplicationWindow {
    id: window
    width: 1280
    height: 720
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
        x: 0
        y: 0
        width: 1280
        height: 720
        Loader {
            id: loader
            width: parent.width
            height: parent.height
            z: 0
            sourceComponent: menuCompose

            Controls.ToolTip {
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
                width: loader.width
                height: loader.height
            }
        }

        Component {
            id: levelBuilder
            LevelBuilder {
                width: loader.width
                height: loader.height
            }
        }

        Component {
            id: frameTimer
            Controls.FrameTimer {
            }
        }

        Component {
            id: exitDialog
            Controls.Dialog {
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

    Controls.Heading {
        id: heading
    }

    function loadMenu() {
        loader.focus = false
        loader.sourceComponent = menuCompose
    }
    function loadLevel(type) {
        loader.focus = true
        if (type === "new") {
            opSave.level.levelBuilderClear()
        }
        loader.sourceComponent = levelBuilder
        if (type === "new") {
            opSave.level.heroClear()
            seedGeneration()
            loader.item.levelChooser("new")
        }
        else {
            loader.item.levelChooser("")
        }
    }

    function seedGeneration() {
        let seed = []
        for (let i = 0; i < 6; i++) {
            seed.push(Math.floor(Math.random() * 10))
        }
        seed = [8,8,3,9,7,5]
        loader.item.seed = seed
        opSave.level.builder.seed = seed
        console.log(seed)
    }

    function updateSizes() {
        if (opSave.settings.screenProps.visibility === 2) {
            heading.head.width = opSave.settings.screenProps.width
            heading.head.height = 0.05 * opSave.settings.screenProps.height
            const heightCoeff = 16 * (opSave.settings.screenProps.width * 9 / 16 + heading.height) / opSave.settings.screenProps.width
            width = (opSave.settings.screenProps.width / opSave.settings.screenProps.height < 16 / heightCoeff) ? opSave.settings.screenProps.height / heightCoeff * 16 : opSave.settings.screenProps.width
            height = (opSave.settings.screenProps.width / opSave.settings.screenProps.height < 16 / heightCoeff) ? opSave.settings.screenProps.height : opSave.settings.screenProps.width / 16 * heightCoeff
            container.width = width
            container.height = (9 * width) / 16
            container.x = (width - container.width) / 2
            container.y = heading.y + heading.height
        }
        else {
            heading.head.width = 0
            heading.head.height = 0
            const heightCoeff = 16 * (opSave.settings.screenProps.width * 9 / 16 + heading.height) / opSave.settings.screenProps.width
            width = (opSave.settings.screenProps.width / opSave.settings.screenProps.height < 16 / heightCoeff) ? opSave.settings.screenProps.height / heightCoeff * 16 : opSave.settings.screenProps.width
            height = (opSave.settings.screenProps.width / opSave.settings.screenProps.height < 16 / heightCoeff) ? opSave.settings.screenProps.height : opSave.settings.screenProps.width / 16 * heightCoeff
            container.width = width
            container.height = (9 * width) / 16
            container.x = (width - container.width) / 2
            container.y = heading.y + heading.height
        }
    }
}
