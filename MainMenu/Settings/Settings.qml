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
                    buttonArea.onClicked: {
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
//        DropDown {
//            objects: resolutions.concat()
//            function actionSet(index) {
//                var w = modelData[0]
//                var h = modelData[1]
//                window.width = w
//                window.height = h
//                window.x = (screen.width - w) / 2
//                window.y = (screen.height - h) / 2
//            }
//        }
        Button1 {
            text: resRep.state === "active" ? locale.settingsFullScreenTrue : locale.settingsFullScreenFalse
            anchors.horizontalCenter: parent.horizontalCenter
            buttonArea.onClicked: changeVisibility()
        }
        Button1 {
            text: frameTimer.state === frameTimer.statesList[0] ? locale.settingsFPSon : locale.settingsFPSoff
            anchors.horizontalCenter: parent.horizontalCenter
            buttonArea.onClicked: frameTimer.state = frameTimer.state === frameTimer.statesList[0] ? frameTimer.statesList[1] : frameTimer.statesList[0]
        }
        Button1 {
            anchors.horizontalCenter: parent.horizontalCenter
            text: locale.settingsSave
            buttonArea.onClicked: home()
        }
        DropDown {
            index: locale.languages.indexOf(locale.currentLanguage)
            objects: locale.languages
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
            window.showFullScreen()
//            window.x = 0
//            window.y = 0
//            window.height = screen.height
//            window.width = screen.width
//            window.flags = Qt.Window | Qt.FramelessWindowHint

            resRep.state = "disabled"
        } else if (parseInt(window.visibility) !== 2) {
            window.showNormal()
//            window.flags = Qt.Window
            resRep.state = "active"
            console.log(window.visibility)
        }
    }
}
