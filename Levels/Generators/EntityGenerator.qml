import QtQuick 2.15
import "../../Entities/Good"
import "../../Entities/Evil"
import "../../Entities/NPC"
import "../../Entities/Interact"

Item {
    property alias repeater: repeater
    property var objects: []
    property var metadata: []
    property bool ready: objects.length > 0 ? repeater.numberOfCreatedObjects / objects.length === 1 : true

    Repeater {
        id: repeater
        property int numberOfCreatedObjects: 0
        Loader {
            id: entityLoader
            property int entityIndex: -1
            sourceComponent: {
                if (modelData[0] === "hero") {return hero}
                else if (modelData[0] === "hostile") { return hostile }
                else if (modelData[0] === "npc") {return npc }
                else if (modelData[0] === "interact") { return interact }
                else return undefined
            }
            focus: modelData[0] === "hero"
            x: modelData[1]
            y: modelData[2]

            Component.onCompleted: entityIndex = index
            onLoaded: {
                if (modelData[3] !== undefined) item.width = modelData[3]
                if (modelData[4] !== undefined) item.height = modelData[4]
                if (metadata[index].name !== undefined) {
                    item.name = metadata[index].name
                }
                if (metadata[index].hp !== undefined) {
                    item.health = metadata[index].hp
                }
                if (metadata[index].equipment !== undefined) {
                    item.inventory.equipmentCells = metadata[index].equipment
                }
                if (metadata[index].inventory !== undefined) {
                    item.inventory.inventoryCells = metadata[index].inventory
                }
                if (metadata[index].money !== undefined) {
                    item.money = metadata[index].money
                }
                if (metadata[index].anotherRoom !== undefined) {
                    item.anotherRoom = metadata[index].anotherRoom
                }
                if (modelData[0] !== "interact")
                    item.inventory.activeArmor()
                else if (modelData[0] === "interact") {
                    if (metadata[index].scenario !== undefined)
                        item.interactLoader.item.scenario = metadata[index].scenario
                    else if (metadata[index].objects !== undefined)
                        item.interactLoader.item.objects = metadata[index].objects
                }
                index === 0 ? repeater.numberOfCreatedObjects = 1 : repeater.numberOfCreatedObjects++
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
    Component {
        id: npc
        NPC {}
    }
    Component {
        id: interact
        Interact {}
    }
}
