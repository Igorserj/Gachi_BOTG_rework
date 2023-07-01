import QtQuick 2.15
import "../../Entities/Good"
import "../../Entities/Evil"

Item {
    property alias repeater: repeater
    property var objects: []
    property var metadata: []
    property bool ready: repeater.numberOfCreatedObjects / objects.length === 1
    Repeater {
        id: repeater
        property int numberOfCreatedObjects: 0
        model: objects
        Loader {
            id: entityLoader
            property int entityIndex: -1
            asynchronous: true
            sourceComponent: modelData[0] === "hero" ? hero : modelData[0] === "hostile" ? hostile : undefined
            focus: modelData[0] === "hero"
            x: modelData[1]
            y: modelData[2]
            Component.onCompleted: entityIndex = index
            onLoaded: {
                item.name = metadata[index].name
                if (index !== 0 && metadata[index].hp !== undefined) {
                    item.health = metadata[index].hp
                }
                repeater.numberOfCreatedObjects++
            }
        }
    }

    Component {
        id: hero
        MainHero {}
    }
    Component {
        id: hostile
        Hostile {}
    }
}
