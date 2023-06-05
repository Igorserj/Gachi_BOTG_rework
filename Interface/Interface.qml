import QtQuick 2.15
import "Inventory"

Item {
    state: "ui"
    property alias interfaceLoader: interfaceLoader
    states: [
        State {
            name: "ui"
            PropertyChanges {
                target: unBlurred
                running: true
            }
        },
        State {
            name: "menu"
            PropertyChanges {
                target: blurred
                running: true
            }
        },
        State {
            name: "inventory"
            PropertyChanges {
                target: openInventory
                running: true
            }
        }
    ]

    SequentialAnimation {
        id: blurred
        ScriptAction {
            script: interfaceLoader.sourceComponent = menu
        }
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
        ScriptAction {
            script: interfaceLoader.sourceComponent = ui
        }
    }
    SequentialAnimation {
        id: openInventory
        ScriptAction {
            script: interfaceLoader.sourceComponent = inventory
        }
    }

    Loader {
        id: interfaceLoader
        anchors.fill: parent
    }
    Component {
        id: ui
        UserInterface {
            Component.onCompleted: toolTip.hide()
        }
    }

    Component {
        id: menu
        Menu {}
    }

    Component {
        id: inventory
        Inventory {
            inventoryCells: levelLoader.item.entGen.repeater.itemAt(0).item.inventory.inventoryCells
            equipmentCells: levelLoader.item.entGen.repeater.itemAt(0).item.inventory.equipmentCells
        }
    }
}
