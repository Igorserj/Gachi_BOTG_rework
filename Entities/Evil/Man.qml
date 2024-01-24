import QtQuick 2.15

QtObject {
    function init() {
        const meta = hostile.parent.meta
        if (meta.hp === undefined) hostile.health = 45
        if (meta.maxHealth === undefined) hostile.maxHealth = 45

        if (meta.stamina === undefined) hostile.stamina = 20
        if (meta.maxStamina === undefined) hostile.maxStamina = 20

        if (meta.speedCoeff === undefined) hostile.speedCoeff = 12
        if (meta.damage === undefined) hostile.damage = 15
        if (meta.defense === undefined) hostile.defense = 0

        hostile.canPickUp = true

        // hostile.money = 0
        // hostile.facingRight = false
        // hostile.rot = 0
        // hostile.name = ""

        hostile.recovery = false
        hostile.anotherRoom = false
        hostile.color = "red"

        // hostile.state = "alive"
    }
}
