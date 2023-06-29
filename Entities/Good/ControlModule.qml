import QtQuick 2.15

Item {
    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_A && !movementBlocked) {
            if (facingRight === false) {
                toTheLeft()
            }
            else {
             facingRight = false
                if (run === 1) {
                    toTheLeft()
                    stamina -= 2
                }
            }
        } else if (event.key === Qt.Key_D && !movementBlocked) {
            if (facingRight === true) {
                toTheRight()
            }
            else {
                facingRight = true
                if (run === 1) {
                    toTheRight()
                    stamina -= 2
                }
            }
        }
        if (event.key === Qt.Key_W && !movementBlocked) {
            toTheTop()
        } else if (event.key === Qt.Key_S && !movementBlocked) {
            toTheBot()
        }
        if (event.key === Qt.Key_I) {
            if (ifaceLoader.item.state === "ui") {
                ifaceLoader.item.state = "inventory"
                ifaceLoader.item.interfaceLoader.item.usedByEntity = mainHero
            }
            else if (ifaceLoader.item.state === "inventory") {
                ifaceLoader.item.state = "ui"
            }
        }
        if (event.key === Qt.Key_E) {
            loot()
        }
        if (event.key === Qt.Key_J && animations.attackReady && !movementBlocked) {
            nmyScan()
        }
        if (event.key === Qt.Key_Shift && !movementBlocked) {
            mainHero.runActive()
        }
        if (event.key === Qt.Key_Escape) {
            if (ifaceLoader.item.state === "ui")
                ifaceLoader.item.state = "menu"
            else ifaceLoader.item.state = "ui"
        }
    }
    Keys.onReleased: {
        if (!event.isAutoRepeat) {
            if (event.key === Qt.Key_A)
                walkLeft = false
            else if (event.key === Qt.Key_D)
                walkRight = false
            else if (event.key === Qt.Key_W)
                walkUp = false
            else if (event.key === Qt.Key_S)
                walkDown = false

            if (event.key === Qt.Key_Shift) {
                mainHero.run = 0
            }
        }
    }
}
