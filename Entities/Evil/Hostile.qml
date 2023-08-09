import QtQuick 2.15
import ".."

Entity {
    id: hostile
    color: "red"
    stamina: maxStamina
    maxStamina: 15
    speedCoeff: 15
    Logic {}
}
