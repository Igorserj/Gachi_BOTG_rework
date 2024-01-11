import QtQuick 2.15

Item {
    id: interact
    property string name: "default"
    property double health: !!interactLoader.item ? interactLoader.item.baseHealth : 0
    property double maxHealth: !!interactLoader.item ? interactLoader.item.baseMaxHealth : 0
    property alias interactLoader: interactLoader
    readonly property var currentIndex: parent.entityIndex

    Loader {
        id: interactLoader
        sourceComponent: {
            if (name === "bench") return bench
            else if (name === "upstairs" || name === "downstairs") return stairs
            else if (name === "leftpass" || name === "rightpass") return pass
            else if (name === "frontdoor" || name === "backdoor") return door
            else if (name !== "default") console.error("No interact object!")
        }
    }

    Component {
        id: bench
        Bench {}
    }
    Component {
        id: stairs
        StairsInteract {}
    }
    Component {
        id: pass
        PassInteract {}
    }
    Component {
        id: door
        DoorInteract {}
    }
}
