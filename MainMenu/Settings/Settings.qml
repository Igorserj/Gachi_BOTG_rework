import QtQuick 2.15
import "../../Controls"

Item {
    id: settings
    property var resolutions: [[1280, 720], [1366, 768], [1600, 900], [1920, 1080], [2560, 1440]]
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
                state: "active"
                Button1 {
                    text: modelData[0] + "x" + modelData[1]
                    enabled: resRep.state === "active" && (screen.width >= modelData[0] && screen.height >= modelData[1])
                    function clickFunction() {
                        var w = modelData[0]
                        var h = modelData[1]
                        window.width = w
                        window.height = h
                        window.x = (screen.width - w) / 2
                        window.y = (screen.height - h) / 2
                    }
                }
            }
        }
        Button1 {
            text: resRep.state === "active" ? locale.settingsFullScreenTrue : locale.settingsFullScreenFalse
            anchors.horizontalCenter: parent.horizontalCenter
            function clickFunction() { changeVisibility() }
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
            index: locale.languages.indexOf(locale.currentLanguage)
            objects: locale.languages
//            activeCells: [true, false, true]
            function actionSet(index) {
                locale.currentLanguage = locale.languages[index]
            }
        }
    }

    function home() {
        composer.state = "home"
    }
    function changeVisibility() {
        if (parseInt(window.visibility) === 2) {
            window.visibility = 5
//            window.flags = (Qt.FramelessWindowHint | Qt.Window /*| Qt.WindowStaysOnTopHint*/)
//            window.setGeometry(0, 0, screen.width, screen.height)
            resRep.state = "disabled"

        }
        else if (parseInt(window.visibility) !== 2) {
            window.showNormal()
            window.visibility = 2
            resRep.state = "active"
        }
    }
}
