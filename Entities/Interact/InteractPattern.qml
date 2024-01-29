import QtQuick 2.15
import ".."

Entity {
    color: health > 0 ? "green" : "darkGreen"
    health: interact.health
    maxHealth: interact.maxHealth
    canPickUp: false
    width: (interact.width > 0 ? interact.width : 50 * scaleCoeff)
    height: (interact.height > 0 ? interact.height : 50 * scaleCoeff)
    readonly property double baseHealth: 10
    readonly property double baseMaxHealth: 10
    property var scenario: []

    function interaction(entity) {
        console.log("Nothing to interact with!")
    }

    function heroDataSaving() {
        let hero = opSave.level.hero
        const item = entGen.repeater.itemAt(0).item

        hero.x = entGen.repeater.itemAt(0).x
        hero.y = entGen.repeater.itemAt(0).y

        hero.health = item.health
        hero.maxHealth = item.maxHealth
        hero.stamina = item.stamina
        hero.maxStamina = item.maxStamina
        hero.speedCoeff = item.speedCoeff
        hero.damage = item.damage
        hero.defense = item.defense
        hero.money = item.money
        hero.facingRight = item.facingRight
        hero.rot = item.rot
        hero.name = item.name

        hero.inventoryCells = item.inventory.inventoryCells
        hero.previousInventory = item.inventory.previousInventory
        hero.equipmentCells = item.inventory.equipmentCells
        hero.previousEquipment = item.inventory.previousEquipment
        hero.activatedWeapon = item.inventory.activatedWeapon
        hero.twoHands = item.inventory.twoHands
        hero.metadataCells = item.inventory.metadataCells
        hero.previousMetadata = item.inventory.previousMetadata

        hero.buffs = item.buffList.currentBuffs
    }

    function builderDataSaving() {
        opSave.level.builder.seed = seed
        opSave.level.builder.position = position
        opSave.level.builder.inRoom = inRoom
        opSave.level.builder.floor = loader.item.floor
    }

    function hostileDataSaving() {
        let hostileObj = []
        entGen.objects.map(function (elem, idx) {return elem[0] === "hostile" ? hostileObj.push(idx) : {}})
        if (!inRoom) {
            opSave.level.hostile.corridorEnemyMeta[loader.item.floor][position] = hostileObj.map((elem)=>entGen.metadata[elem])
            hostileObj.map((elem, idx)=> {
                               let nmyMeta = opSave.level.hostile.corridorEnemyMeta[loader.item.floor][position][idx]
                               const item = entGen.repeater.itemAt(elem).item
                               opSave.level.hostile.corridorEnemy[loader.item.floor][position][idx] = ["hostile", entGen.repeater.itemAt(elem).x, entGen.repeater.itemAt(elem).y]
                                nmyMetaSave(nmyMeta, item)
                           }
                           )
        }
        else {
            opSave.level.hostile.roomEnemyMeta[loader.item.floor][position] = hostileObj.map((elem)=>entGen.metadata[elem])
            hostileObj.map((elem, idx)=> {
                               let nmyMeta = opSave.level.hostile.roomEnemyMeta[loader.item.floor][position][idx]
                               const item = entGen.repeater.itemAt(elem).item
                               opSave.level.hostile.roomEnemy[loader.item.floor][position][idx] = ["hostile", entGen.repeater.itemAt(elem).x, entGen.repeater.itemAt(elem).y]
                               nmyMetaSave(nmyMeta, item)
                           }
                           )
        }

        function nmyMetaSave(nmyMeta, item) {
            nmyMeta.hp = item.health
            // nmyMeta.state = item.state
            nmyMeta.stamina = item.stamina
            nmyMeta.money = item.money
            nmyMeta.facingRight = item.facingRight
            nmyMeta.rot = item.rot
            nmyMeta.buffs = item.buffList.currentBuffs

            nmyMeta.inventoryCells = item.inventory.inventoryCells
            nmyMeta.previousInventory = item.inventory.previousInventory
            nmyMeta.equipmentCells = item.inventory.equipmentCells
            nmyMeta.previousEquipment = item.inventory.previousEquipment
            nmyMeta.activatedWeapon = item.inventory.activatedWeapon
            nmyMeta.twoHands = item.inventory.twoHands
            nmyMeta.metadataCells = item.inventory.metadataCells
            nmyMeta.previousMetadata = item.inventory.previousMetadata
        }
    }
}
