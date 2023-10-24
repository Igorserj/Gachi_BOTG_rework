import QtQuick 2.15

Item {
    id: interact
    property string name: "default"
    property double health: !!interactLoader.item ? interactLoader.item.baseHealth : 0
    property double maxHealth: !!interactLoader.item ? interactLoader.item.baseMaxHealth : 0
    property alias interactLoader: interactLoader
    property var currentIndex: parent.entityIndex
//    width: childrenRect.width
//    height: childrenRect.height
    Loader {
        id: interactLoader
        sourceComponent: {
            if (name === "default") {
                return interactPattern
            }
            else if (name === "bench") {
                return bench
            }
            else if (name === "upstairs" || name === "downstairs") {
                return stairs
            }
        }
    }
    Component {
        id: interactPattern
        InteractPattern {}
    }
    Component {
        id: bench
        Bench {}
    }
    Component {
        id: stairs
        StairsInteract {}
    }
}
