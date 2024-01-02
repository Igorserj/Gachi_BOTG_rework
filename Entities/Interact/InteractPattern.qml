import QtQuick 2.15
import ".."

Entity {
    color: health > 0 ? "green" : "darkGreen"
    health: interact.health
    maxHealth: interact.maxHealth
    canPickUp: false
    width: (interact.width > 0 ? interact.width : 50 * loader.width / 1280)
    height: (interact.height > 0 ? interact.height : 50 * loader.height / 720)
    readonly property double baseHealth: 10
    readonly property double baseMaxHealth: 10
    property var scenario: []

    function interaction(entity) {
        console.log("nothing to interact with!")
    }
    function heroDataSaving() {
        opSave.level.hero.x = entGen.repeater.itemAt(0).x
        opSave.level.hero.y = entGen.repeater.itemAt(0).y

        opSave.level.hero.health = entGen.repeater.itemAt(0).item.health
        opSave.level.hero.maxHealth = entGen.repeater.itemAt(0).item.maxHealth
        opSave.level.hero.stamina = entGen.repeater.itemAt(0).item.stamina
        opSave.level.hero.maxStamina = entGen.repeater.itemAt(0).item.maxStamina
        opSave.level.hero.speedCoeff = entGen.repeater.itemAt(0).item.speedCoeff
        opSave.level.hero.damage = entGen.repeater.itemAt(0).item.damage
        opSave.level.hero.defense = entGen.repeater.itemAt(0).item.defense //20 max
        opSave.level.hero.money = entGen.repeater.itemAt(0).item.money
        opSave.level.hero.facingRight = entGen.repeater.itemAt(0).item.facingRight
        opSave.level.hero.rot = entGen.repeater.itemAt(0).item.rot
        opSave.level.hero.name = entGen.repeater.itemAt(0).item.name
    }
}
