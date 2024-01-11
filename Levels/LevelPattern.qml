import QtQuick 2.15
import "Level1"

Item {
    property alias roomLoader: roomLoader
    readonly property var staircaseLayout: ["entrance", "stairs", "stairs", "roof"]
    property var corridorsLayout: [
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"]]

    property var allocation: []
    property var corridorShift: []
    property string currentRoom: ""  /*--entrance--*/

    function alloc(type) {
        script.sendMessage({ 'seed' : seed, "type": type })
    }

    WorkerScript {
        id: script
        source: "allocation.mjs"
        onMessage: {
            corridorsLayout = messageObject.corridorsLayout
            corridorShift = messageObject.corShift
            if (messageObject.type === "new") {
                position = messageObject.corShift[floor] + 1
                opSave.level.builder.position = position
            }
            allocation = messageObject.allocation
            console.log(allocation)
            currentRoom = inRoom ? messageObject.allocation[floor][position] : messageObject.corridorsLayout[floor][position]
        }
    }

    Loader {
        id: roomLoader
        focus: true
        width: loader.width
        height: loader.height
        sourceComponent: {
            if (currentRoom === "corridor") return corridor
            else if (["room", "02", "04", "key"].includes(currentRoom)) return room
            else if (["wc1", "wc2"].includes(currentRoom)) return wc
            else if (["entrance", "stairs", "roof"].includes(currentRoom)) return staircase
            else if (currentRoom === "library") return library
            else if (currentRoom === "canteen") return canteen
            else return undefined
        }
    }

    Component {
        id: level1View
        Level1View {}
    }

    Component {
        id: staircase
        Staircase {}
    }

    Component {
        id: library
        Library {}
    }
    Component {
        id: canteen
        Canteen {}
    }
    Component {
        id: room
        Room {}
    }
    Component {
        id: corridor
        Corridor {}
    }
    Component {
        id: wc
        WC {
            type: currentRoom
        }
    }
}
