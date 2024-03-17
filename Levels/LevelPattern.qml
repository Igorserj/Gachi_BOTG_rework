import QtQuick 2.15
import "Level1"
import "Generators"
import "../Items"

Item {
    id: lvlPattern
    property alias roomLoader: roomLoader
    readonly property var staircaseLayout: ["entrance", "stairs", "stairs", "roof"]
    property var corridorsLayout: [
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"],
        ["corridor", "corridor", "corridor", "corridor", "corridor"]]

    property var allocation: []
    property var corridorEnemy: []
    property var corridorEnemyMeta: []
    property var roomEnemy: []
    property var roomEnemyMeta: []
    property var corridorShift: []
    property string currentRoom: ""  /*--entrance--*/

    function alloc(type) {
        allocScript.sendMessage({ 'seed' : seed, "type": type })
    }

    WorkerScript {
        id: allocScript
        source: "allocation.mjs"
        onMessage: {
            corridorsLayout = messageObject.corridorsLayout
            corridorShift = messageObject.corShift
            allocation = messageObject.allocation
            if (messageObject.type === "new") {
                position = messageObject.corShift[floor] + 1
                corridorEnemy = messageObject.corNmy
                roomEnemy = messageObject.roomNmy
                corridorEnemyMeta = messageObject.corNmyM
                roomEnemyMeta = messageObject.roomNmyM

                opSave.level.builder.position = position
                opSave.level.hostile.corridorEnemy = corridorEnemy
                opSave.level.hostile.roomEnemy = roomEnemy
                opSave.level.hostile.corridorEnemyMeta = corridorEnemyMeta
                opSave.level.hostile.roomEnemyMeta = roomEnemyMeta

                const enemiesAllocByName = messageObject.enemiesAllocByName
                generator.enemiesAllocByName = {
                    treassure: enemiesAllocByName.treassure,
                    corridor: enemiesAllocByName.corridor,
                    room: enemiesAllocByName.room
                }
                generator.layouts = {
                    corridorsLayout: corridorsLayout,
                    allocation: allocation
                }
            }
            else {
                position = opSave.level.builder.position
                corridorEnemy = opSave.level.hostile.corridorEnemy
                corridorEnemyMeta = opSave.level.hostile.corridorEnemyMeta
                roomEnemy = opSave.level.hostile.roomEnemy
                roomEnemyMeta = opSave.level.hostile.roomEnemyMeta

                generator.generator.treassuresSpawn = opSave.level.items.treassuresSpawn
                generator.generator.roomsLayout = opSave.level.items.roomsLayout
                generator.generator.corridorsLayout = opSave.level.items.corridorsLayout
                generator.generator.enemiesTreassure = opSave.level.items.enemiesTreassure
                generator.generator.enemiesCorridor = opSave.level.items.enemiesCorridor
                generator.generator.enemiesRoom = opSave.level.items.enemiesRoom
                currentRoom = inRoom ? messageObject.allocation[floor][position] : messageObject.corridorsLayout[floor][position]
            }

            // item.name = meta.name
            // item.type = meta.type
            // item.state = meta.state
            // item.stamina = meta.stamina
            // item.health = meta.hp
            // item.facingRight = meta.facingRight
            // item.rot = meta.rot
            // item.money = meta.money
            // item.anotherRoom = meta.anotherRoom
            // item.buffList.currentBuffs = meta.buffs

            // item.inventory.inventoryCells = meta.inventoryCells
            // item.inventory.previousInventory = meta.previousInventory
            // item.inventory.equipmentCells = meta.equipmentCells
            // item.inventory.previousEquipment = meta.previousEquipment
            // item.inventory.activatedWeapon = meta.activatedWeapon
            // item.inventory.twoHands = meta.twoHands
            // item.inventory.metadataCells = meta.metadataCells
            // item.inventory.previousMetadata = meta.previousMetadata
            console.log(allocation)
        }
    }
    Items {
        id: items
    }
    ItemsListGenerator {
        id: generator
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
