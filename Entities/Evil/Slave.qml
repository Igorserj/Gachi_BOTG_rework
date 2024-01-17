import QtQuick 2.15

QtObject {
    function init() {
        hostile.health = 20
        hostile.maxHealth = 20

        hostile.stamina = 10
        hostile.maxStamina = 10

        hostile.speedCoeff = 13
        hostile.damage = 5
        hostile.defense = 0

        hostile.canPickUp = true

        // hostile.money = 0
        // hostile.facingRight = false
        // hostile.rot = 0
        // hostile.name = ""

        hostile.recovery = false
        hostile.anotherRoom = false

        hostile.color = "orange"

        hostile.state = "alive"
    }
}
