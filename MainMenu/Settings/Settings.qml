import QtQuick 2.15
import "../../Controls"

Item {
    id: settings
    readonly property var resolutions: [[640, 360], [1280, 720], [1366, 768], [1600, 900], [1920, 1080], [2560, 1440]]
    Column {
        spacing: height / 20
        height: settings.height * 0.9
        x: (settings.width - width) / 2
        y: (settings.height - height) / 2
        Row {
            id: resRow
            spacing: settings.width / 30
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater {
                id: resRep
                model: resolutions
                // state: opSave.settings.screenProps.visibility === 5 ? "active" : "disabled"
                Button1 {
                    text: modelData[0] + "x" + modelData[1]
                    enabled: resRep.state === "active" && (screen.width >= modelData[0] && screen.height >= modelData[1])
                    function clickFunction() {
                        const w = modelData[0]
                        const h = modelData[1]
                        window.width = w
                        window.height = h
                        opSave.settings.screenProps.width = w
                        opSave.settings.screenProps.height = h
                    }
                }
                Component.onCompleted: visibilittyCheck()
            }
        }
        Button1 {
            text: resRep.state === "active" ? locale.settingsFullScreenTrue : locale.settingsFullScreenFalse
            anchors.horizontalCenter: parent.horizontalCenter
            function clickFunction() { heading.changeVisibility(); visibilittyCheck() }
        }
//        DropDown {
//            objects: ["Windowed", "Fullscreen", ""]
//        }
        Button1 {
            text: frameTimerLoader.status === Loader.Null ? locale.settingsFPSon : locale.settingsFPSoff
            anchors.horizontalCenter: parent.horizontalCenter
            function clickFunction() { return frameTimerLoader.status === Loader.Null ? frameTimerLoader.sourceComponent = frameTimer :
                                                                            [frameTimerLoader.item.state = frameTimerLoader.item.statesList[0], frameTimerLoader.sourceComponent = undefined] }
        }
        Button1 {
            anchors.horizontalCenter: parent.horizontalCenter
            text: locale.settingsSave
            function clickFunction() { home() }
        }
        DropDown {
            index: locale.languages.indexOf(opSave.settings.currentLanguage)
            objects: locale.languages
            function actionSet(index) {
                opSave.settings.currentLanguage = locale.languages[index]
            }
        }
    }

    function home() {
        composer.state = "home"
    }

    function visibilittyCheck() {
        if (opSave.settings.screenProps.visibility === 2) {
            resRep.state = "active"
        }
        else {
            resRep.state = "disabled"
        }
    }
}
