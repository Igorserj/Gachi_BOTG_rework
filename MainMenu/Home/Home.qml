import QtQuick 2.15
import "../../Controls"

Item {
    property var buttonNames: locale.homeButtonNames/*[["Почати гру", "Налаштування", "Вихід"], ["Нова гра", "Продовжити", "Назад"]]*/
    property int actionSet: 0
    property alias buttonsModel: buttons.model
    Image {
        source: "../Assets/logo.png"
        fillMode: Image.PreserveAspectFit
        width: height * 2
        height: (parent.height - homeColumn.height) / 2
        x: parent.width - width - composer.width / 30
    }
    Column {
        id: homeColumn
        width: composeLoader.width / 4
        x: composer.width - width - composer.width / 30
        anchors.verticalCenter: parent.verticalCenter
        spacing: parent.height / 20
        Repeater {
            id: buttons
            model: buttonNames[0]
            Button1 {
                text: modelData
                anchors.right: parent.right
                function clickFunction() { return actionSet === 0 ? action(index) : action2(
                                                                        index) }
            }
        }
    }
    function action(index) {
        if (index === 0)
            game()
        else if (index === 1)
            settings()
        else if (index === 2)
            quitGame()
    }

    function game() {
        composer.state = "start"
    }
    function settings() {
        composer.state = "settings"
    }
    function quitGame() {
        exitDialogLoader.sourceComponent = exitDialog
    }

    function action2(index) {
        if (index === 0) {
            newGame()
        }
        else if (index === 1) {
            continueGame()
        }
        else if (index === 2)
            back()
    }

    function newGame() {
        vignetteLoader.sourceComponent = undefined
        //        loader.state = "level"
        loadLevel()
    }

    function continueGame() {
        vignetteLoader.sourceComponent = undefined
    }

    function back() {
        composer.state = "home"
    }
}
