import QtQuick 2.15

QtObject {
    function init() {
        hostile.health = 45
        hostile.maxHealth = 45

        hostile.stamina = 15
        hostile.maxStamina = 15

        hostile.speedCoeff = 9
        hostile.damage = 15
        hostile.defense = 0

        hostile.canPickUp = true

        // hostile.money = 0
        // hostile.facingRight = false
        // hostile.rot = 0
        // hostile.name = ""

        hostile.recovery = false
        hostile.anotherRoom = false
        hostile.color = "red"

        hostile.state = "alive"
    }
}
