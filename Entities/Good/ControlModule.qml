import QtQuick 2.15

Item {
    focus: true
    Keys.onPressed: {
        if (!!ifaceLoader.item) {
            if (ifaceLoader.item.state === "ui") {
                walking(event.key)
                if (event.key === Qt.Key_I) {
                    if (ifaceLoader.item.interfaceLoader.item.inventoryLoader.status === Loader.Ready) {
                        ifaceLoader.item.interfaceLoader.item.closeInventory()
                    }
                    else {
                        ifaceLoader.item.interfaceLoader.item.openInventory(mainHero, mainHero)
//                        console.log(ifaceLoader.item.interfaceLoader.item.inventoryLoader.item, ifaceLoader.item.interfaceLoader.item.inventoryLoader)
//                        ifaceLoader.item.interfaceLoader.item.inventoryLoader.item.usedByEntity = mainHero
//                        ifaceLoader.item.interfaceLoader.item.inventoryLoader.item.heroEntity = mainHero
                    }
                }
                if (event.key === Qt.Key_E) {
                    interaction()
                }
                if (event.key === Qt.Key_F) {
                    mainHero.inventory.twoHands = !mainHero.inventory.twoHands
                    mainHero.inventory.activeWeapon()
                }
                if (event.key === Qt.Key_J && animations.attackReady && !movementBlocked) {
                    nmyScan()
                }
                if (event.key === Qt.Key_Shift && !movementBlocked) {
                    mainHero.runActive()
                }
                if (event.key === Qt.Key_Escape) {
                    if (ifaceLoader.item.interfaceLoader.item.inventoryLoader.status === Loader.Ready) {
                        ifaceLoader.item.interfaceLoader.item.closeInventory()
                    }
                    else {
                        ifaceLoader.item.state = "menu"
                    }
                }
                if (event.key === Qt.Key_R) {//disable on release
                    ifaceLoader.item.state = "dialogue"
                    ifaceLoader.item.interfaceLoader.item.entity1 = mainHero
                }
            }
            else if (ifaceLoader.item.state === "menu") {
                if (event.key === Qt.Key_Escape) {
                    ifaceLoader.item.state = "ui"
                }
            }
            else if (ifaceLoader.item.state === "dialogue") {
                if (event.key === Qt.Key_Escape || event.key === Qt.Key_R) {//disable on release
                    ifaceLoader.item.state = "ui"
                }
                if (event.key === Qt.Key_Space) {
                    ifaceLoader.item.interfaceLoader.item.indexUp()
                }
            }
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

    function walking(key) {
        if (key === Qt.Key_A && !movementBlocked) {
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
        } else if (key === Qt.Key_D && !movementBlocked) {
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
        if (key === Qt.Key_W && !movementBlocked) {
            toTheTop()
        } else if (key === Qt.Key_S && !movementBlocked) {
            toTheBot()
        }
    }
}
