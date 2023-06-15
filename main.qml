import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "MainMenu"
import "Levels"
import "Controls" as MyControls

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    property double recalculatedWidth: width / height > 16 / 9 ? height / 9 * 16 : width
    property double recalculatedHeight: width / height > 16 / 9 ? height : width / 16 * 9
    visible: true
    title: "Gachimuchi: Boss of this gym"
    color: "black"
    onClosing: {
        close.accepted = false
        exitDialog.show()
    }

    Loader {
        id: loader
        focus: true
        x: (window.width - recalculatedWidth) / 2
        y: (window.height - recalculatedHeight) / 2
        z: 0
        sourceComponent: menuCompose

        MyControls.ToolTip {
            id: toolTip
            z: 1
        }
    }
    Localization {
        id: locale
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

    FontLoader {
        id: comfortaa
        name: "Comfortaa"
        source: "Fonts/Comfortaa/Comfortaa-VariableFont_wght.ttf"
    }

    MyControls.FrameTimer {
        id: frameTimer
    }

    MyControls.Dialog {
        id: exitDialog
        mainText: locale.exitDialogText
        anchors.centerIn: parent
        objects: locale.exitDialogOptions
        function actionSet(index) {
            if (index === 0) exitDialog.hide()
            else if (index === 1) {
                Qt.quit()
            }
        }
    }


    function loadMenu() {
        loader.sourceComponent = menuCompose
    }
    function loadLevel() {
        loader.sourceComponent = levelBuilder
    }
}
