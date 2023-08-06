import QtQuick 2.15
import ".."
import "../../PhysicalObjects"

Entity {
    id: hostile
    color: "yellow"
    stamina: maxStamina
    maxStamina: 15
    speedCoeff: 15
}
