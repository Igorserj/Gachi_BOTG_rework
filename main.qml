import QtQuick 2.15
import QtQuick.Window 2.15
import "MainMenu"
import "Levels"
import "Controls"

Window {
    id: window
    width: 1280
    height: 720
    property double recalculatedWidth: width / height > 16 / 9 ? height / 9 * 16 : width //width / 16 * 9 >= height ? width : height / 9 * 16
    property double recalculatedHeight: width / height > 16 / 9 ? height : width / 16 * 9 //height / 9 * 16 <= width ? height : width / 16 * 9
    visible: true
    title: "Gachimuchi: Boss of this gym"
    color: "black"

    Loader {
        id: loader
        focus: true
        x: (window.width - recalculatedWidth) / 2
        y: (window.height - recalculatedHeight) / 2
        z: 0
        sourceComponent: menuCompose
        ToolTip {
            id: toolTip
            z: 1
        }
//        ContextMenu {
//            id: contextMenu
//            z: 1
//        }
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

    function loadMenu() {
        loader.sourceComponent = undefined
        loader.sourceComponent = menuCompose
    }
    function loadLevel() {
        loader.sourceComponent = undefined
        loader.sourceComponent = levelBuilder
    }
}
