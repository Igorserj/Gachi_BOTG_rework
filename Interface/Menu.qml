import QtQuick 2.15
import "../Controls"

Rectangle {
    opacity: blur.opacity
    color: "#88000000"
    Rectangle {
        color: "#55777777"
        width: parent.width / 3
        height: parent.height / 2
        radius: width / 8
        anchors.centerIn: parent
        Column {
            anchors.centerIn: parent
            spacing: parent.height / 8
            Repeater {
                anchors.horizontalCenter: parent.horizontalCenter
                model: locale.menuButtonNames
                Button1 {
                    text: modelData
                    anchors.horizontalCenter: parent.horizontalCenter
                    buttonArea.onClicked: actionSet(index)
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
        Qt.quit()
    }
}
