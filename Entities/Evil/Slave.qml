import QtQuick 2.15

QtObject {
    function init() {
        const meta = hostile.parent.meta
        if (meta.hp === undefined) hostile.health = 20
        if (meta.maxHealth === undefined) hostile.maxHealth = 20

        if (meta.stamina === undefined) hostile.stamina = 15
        if (meta.maxStamina === undefined) hostile.maxStamina = 15

        if (meta.speedCoeff === undefined) hostile.speedCoeff = 15
        if (meta.damage === undefined) hostile.damage = 5
        if (meta.defense === undefined) hostile.defense = 0

        hostile.canPickUp = true

        // hostile.money = 0
        // hostile.facingRight = false
        // hostile.rot = 0
        // hostile.name = ""

        hostile.recovery = false
        hostile.anotherRoom = false

        hostile.color = "orange"

        // hostile.state = "alive"
    }
}
