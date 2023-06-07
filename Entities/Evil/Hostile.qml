import QtQuick 2.15
import ".."
import "../../PhysicalObjects"

Entity {
    id: hostile
    color: "red"
    stamina: maxStamina
    maxStamina: 15
    speed: 15
    Logic {}
}
