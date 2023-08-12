import QtQuick 2.15
import "Dialogue"

Item {
    id:  iface
    state: "ui"
    property alias interfaceLoader: interfaceLoader
    onStateChanged: toolTip.hide()
    states: [
        State {
            name: "ui"
            PropertyChanges {
                target: openUi
                running: true
            }
            PropertyChanges {
                target: unBlurred
                running: true
            }
        },
        State {
            name: "menu"
            PropertyChanges {
                target: openMenu
                running: true
            }
            PropertyChanges {
                target: blurred
                running: true
            }
        },
        State {
            name: "dialogue"
            PropertyChanges {
                target: openDialogue
                running: true
            }
        }
    ]

    SequentialAnimation {
        id: blurred
        ScriptAction {
            script: {
                blur.radius = 32
                blur.opacity = 1
            }
        }
    }
    SequentialAnimation {
        id: unBlurred
        ScriptAction {
            script: {
                blur.radius = 0
                blur.opacity = 0
            }
        }
    }

//    function openMenu() {interfaceLoader.sourceComponent = menu}
//    function openUi() {interfaceLoader.sourceComponent = ui}
//    function openDialogue() {interfaceLoader.sourceComponent = dialogue}
    SequentialAnimation {
        id: openMenu
        ScriptAction {
            script: interfaceLoader.sourceComponent = menu
        }
    }

    SequentialAnimation {
        id: openUi
        ScriptAction {
            script: interfaceLoader.sourceComponent = ui
        }
    }

    SequentialAnimation {
        id: openDialogue
        ScriptAction {
            script: interfaceLoader.sourceComponent = dialogue
        }
    }

    Loader {
        id: interfaceLoader
        anchors.fill: parent
    }
    Component {
        id: ui
        UserInterface {}
    }

    Component {
        id: menu
        Menu {}
    }

    Component {
        id: dialogue
        Dialogue {
//            function scriptRun() {
//                levelLoader.item.entGen.repeater.itemAt(1).item.health = 0
//            }
        }
    }
}
