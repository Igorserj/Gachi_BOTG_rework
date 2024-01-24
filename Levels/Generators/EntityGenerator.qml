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
            readonly property var meta: metadata[index]
            sourceComponent: {
                if (modelData[0] === "hero") {return hero}
                else if (modelData[0] === "hostile") { return hostile }
                else if (modelData[0] === "npc") {return npc }
                else if (modelData[0] === "interact") { return interact }
                else return undefined
            }
            focus: modelData[0] === "hero" && ifaceLoader.status === Loader.Ready
            x: modelData[1] !== undefined ? modelData[1] : 0
            y: modelData[2] !== undefined ? modelData[2] : 0

            Component.onCompleted: entityIndex = index
            onLoaded: {
                if (modelData[3] !== undefined) item.width = modelData[3]
                if (modelData[4] !== undefined) item.height = modelData[4]

                if (modelData[0] === "hero") {
                    item.name = opSave.level.hero.name
                    item.health = opSave.level.hero.health
                    item.maxHealth = opSave.level.hero.maxHealth
                    item.stamina = opSave.level.hero.stamina
                    item.maxStamina = opSave.level.hero.maxStamina
                    item.speedCoeff = opSave.level.hero.speedCoeff
                    item.damage = opSave.level.hero.damage
                    item.defense = opSave.level.hero.defense
                    item.money = opSave.level.hero.money
                    item.facingRight = opSave.level.hero.facingRight
                    item.rot = opSave.level.hero.rot
                    item.name = opSave.level.hero.name
                    item.state = opSave.level.hero.state
                    item.inventory.inventoryCells = opSave.level.hero.inventoryCells
                    item.inventory.previousInventory = opSave.level.hero.previousInventory
                    item.inventory.equipmentCells = opSave.level.hero.equipmentCells
                    item.inventory.previousEquipment = opSave.level.hero.previousEquipment
                    item.inventory.activatedWeapon = opSave.level.hero.activatedWeapon
                    item.inventory.twoHands = opSave.level.hero.twoHands
                    item.inventory.metadataCells = opSave.level.hero.metadataCells
                    item.inventory.previousMetadata = opSave.level.hero.previousMetadata
                    item.buffList.currentBuffs = opSave.level.hero.buffs
                    item.buffList.buffsApply()

                    item.inventory.activeArmor()
                }
                else {
                    // if (meta !== undefined) {
                    if (!!meta.name) item.name = meta.name
                    if (!!meta.type) item.type = meta.type
                    if (!!meta.state) item.state = meta.state
                    if (!!meta.stamina) item.stamina = meta.stamina
                    if (!!meta.hp) item.health = meta.hp
                    if (!!meta.facingRight) item.facingRight = meta.facingRight
                    if (!!meta.rot) item.rot = meta.rot
                    if (!!meta.equipment) item.inventory.equipmentCells = meta.equipment
                    if (!!meta.inventory) item.inventory.inventoryCells = meta.inventory
                    if (!!meta.money) item.money = meta.money
                    if (!!meta.anotherRoom) item.anotherRoom = meta.anotherRoom
                    if (!!meta.buffs) item.buffList.currentBuffs = meta.buffs
                    if (modelData[0] !== "interact")
                    {
                        item.inventory.activeArmor()
                        item.buffList.buffsApply()
                    }
                    else if (modelData[0] === "interact") {
                        if (meta.scenario !== undefined)
                            item.interactLoader.item.scenario = meta.scenario
                        else if (meta.objects !== undefined)
                            item.interactLoader.item.objects = meta.objects
                    }
                    // }
                    // else { console.log("No metadata!") }
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
