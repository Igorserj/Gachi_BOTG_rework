import QtQuick 2.15
import ".."

Entity {
    color: health > 0 ? "green" : "darkGreen"
    health: interact.health
    maxHealth: interact.maxHealth
    readonly property double baseHealth: 10
    readonly property double baseMaxHealth: 10

    function interaction(entity) {

    }
}
