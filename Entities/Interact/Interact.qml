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
            if (name === "default") return interactPattern
            else if (name === "bench") return bench
            else if (name === "upstairs" || name === "downstairs") return stairs
            else if (name === "leftpass" || name === "rightpass") return pass
        }
    }
    Component {
        id: interactPattern
        InteractPattern {
//            Component.onCompleted: console.log("default")
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
}
