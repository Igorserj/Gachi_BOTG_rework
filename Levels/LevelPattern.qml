import QtQuick 2.15
import "Level1"

Item {
    property alias roomLoader: roomLoader
    readonly property var staircaseLayout: ["entrance", "stairs", "stairs", "roof"]
    readonly property var corridorsLayout: [
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"]]

    property var allocation: []
    property var corridorShift: []
    property string currentRoom: "stairs"
    Component.onCompleted: alloc()

    function alloc() {
        script.sendMessage({ 'seed' : seed })
    }

    WorkerScript {
        id: script
        source: "allocation.mjs"
        onMessage: { corridorShift = messageObject.corShift; allocation = messageObject.allocation; console.log(allocation) }
    }

    Loader {
        id: roomLoader
        focus: true
        width: loader.width
        height: loader.height
        sourceComponent: {
            if (currentRoom === "corridor") return corridor
            else if (currentRoom === "entrance" || currentRoom === "stairs" || currentRoom === "roof") return staircase
            else if (currentRoom === "room" || currentRoom === "02" || currentRoom === "04" || currentRoom === "key") return room
            else if (currentRoom === "wc1" || currentRoom === "wc2") return wc
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
//    Component {
//        id: wc2
//        WC {
//            type: "WC2"
//        }
//    }
}
