import QtQuick 2.15

Item {
    function interaction(entity) {
        ifaceLoader.item.interfaceLoader.item.dialogueOpen(0, currentIndex)
        connectionLoader.sourceComponent = con1
        let name1 = ifaceLoader.item.interfaceLoader.item.name1
        let name2 = ifaceLoader.item.interfaceLoader.item.name2
        ifaceLoader.item.interfaceLoader.item.text = [[name2, "Here's your clothes"], [name2, 'Go and change it'], ["script", "trigger"]]
    }
    function initiation() {
        //       - npc.name = "Dude"
    }

    Loader {
        id: connectionLoader
    }

    Component {
        id: con1
        Connections {
            target: ifaceLoader.item.interfaceLoader.item
            function onRunChanged() {
                console.log("triggered")
                connectionLoader.sourceComponent = undefined
            }
        }
    }
}
