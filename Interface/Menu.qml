import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../Controls"

Rectangle {
    opacity: blur.opacity
    color: style.blackGlass//"#88000000"
    Rectangle {
        id: backRect
        color: style.grayGlass//"#55777777"
        height: col.childrenRect.height + 100 * loader.width / 1280
        width: col.childrenRect.width + 150 * loader.height / 720
        radius: width / 16
        anchors.centerIn: parent
        Rectangle {
            id: frontRect
            visible: false
            width: backRect.width * 0.95
            height: backRect.height * 0.95
            radius: width / 16
            x: (-frontRect.width + backRect.width) / 2
            y: (-frontRect.height + backRect.height) / 2
            color: style.darkGlass
        }
        FastBlur {
            source: frontRect
            anchors.fill: frontRect
            transparentBorder: true
            radius: 32
        }
        Column {
            id: col
            anchors.centerIn: frontRect
            spacing: loader.height / 20
            Repeater {
                anchors.horizontalCenter: parent.horizontalCenter
                model: locale.menuButtonNames
                Button1 {
                    text: modelData
                    anchors.horizontalCenter: parent.horizontalCenter
                    function clickFunction() {actionSet(index)}
                }
            }
        }
    }

    function actionSet(index) {
        if (index === 0) continueGame()
        else if (index === 1) mainMenu()
        else if (index === 2) quitGame()
    }

    function continueGame() {
        ifaceLoader.item.state = "ui"
    }
    function mainMenu() {
        loadMenu()
    }
    function quitGame() {
        exitDialogLoader.sourceComponent = exitDialog
    }

    Styles {
        id: style
    }
}
