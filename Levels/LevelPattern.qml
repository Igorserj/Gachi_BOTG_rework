import QtQuick 2.15
import "Generators"

Item {
    property alias objGen: objGen
    property alias entGen: entGen
    property alias itmGen: itmGen
    property alias room: room
    Image {
        id: room
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectFit
    }
    ObjectsGenerator {
        id: objGen
    }
    EntityGenerator {
        id: entGen
    }
    ItemGenerator {
        id: itmGen
    }

    EventHandler {
        id: eventHandler
    }
}
