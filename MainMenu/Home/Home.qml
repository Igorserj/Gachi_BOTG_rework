import QtQuick 2.15
import "../../Controls"
import QtGraphicalEffects 1.15

Item {
    property var buttonNames: locale.homeButtonNames
    property int actionSet: 0
    property alias buttonsModel: buttons.model
    Logo {
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
                enabled: opSave.level.builder.seed.length === 6 || modelData !== buttonNames[1][1]
                anchors.right: parent.right
                function clickFunction() { return actionSet === 0 ? action(index) : action2(index) }
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
        loadLevel("new")
    }

    function continueGame() {
        vignetteLoader.sourceComponent = undefined
        loadLevel()
    }

    function back() {
        composer.state = "home"
    }
}
