import QtQuick 2.15
import "Dialogue"
import "Cheats"

Item {
    id:  iface
    state: levelLoader.item.roomLoader.status === Loader.Ready ? levelLoader.item.roomLoader.visible ? "ui" : "pause" : "pause"
    property var pauseStates: ["menu", "dialogue", "pause"]
    property alias interfaceLoader: interfaceLoader
    property string state2: "cheatsOff"
    onState2Changed: {
        if (state2 === "cheatsOn") cheatLoader.sourceComponent = undefined
        else if (state2 === "cheatsOff") cheatLoader.sourceComponent = panel
    }

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
            name: "pause"
            PropertyChanges {
                target: hideAll
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

    SequentialAnimation {
        id: hideAll
        ScriptAction {
            script: interfaceLoader.sourceComponent = undefined
        }
    }

    Loader {
        id: interfaceLoader
        anchors.fill: parent
    }

    Loader {
        id: cheatLoader
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
        Dialogue {}
    }

    Component {
        id: panel
        SidePanel {}
    }
}
