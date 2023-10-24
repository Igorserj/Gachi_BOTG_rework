import QtQuick 2.15
import ".."

Entity {
    color: health > 0 ? "green" : "darkGreen"
    health: interact.health
    maxHealth: interact.maxHealth
    canPickUp: false
    width: interact.width > 0 ? interact.width : 50
    height: interact.health > 0 ? interact.height : 50
    readonly property double baseHealth: 10
    readonly property double baseMaxHealth: 10
    property var scenario: []

    function interaction(entity) {

    }
}
