import QtQuick 2.15
import ".."

Entity {
    id: hostile
    property string type: ""

    Loader {
        id: hostileLoader
        sourceComponent: type === "slave" ? slave : type === "man" ? man : undefined
        onLoaded: item.init()
    }
    Component {
        id: slave
        Slave {}
    }
    Component {
        id: man
        Man {}
    }

    Logic {}
}
