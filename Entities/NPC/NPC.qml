import QtQuick 2.15
import ".."

Entity {
    id: npc
    color: "yellow"
    canPickUp: false
    property var currentIndex: parent.entityIndex
    function interaction(entity) {
        if (!!loader.item) {
            return loader.item.interaction(entity)
        }
    }

    Loader {
        id: loader
        sourceComponent: {
            if (name === "Dude") {
                return dude
            }
        }
    }

    Component {
        id: dude
        DudeFilm {}
    }
}
