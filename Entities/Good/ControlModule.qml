import QtQuick 2.15

Item {
    focus: true
    property bool keyEPressed: true
    property bool keyIPressed: true
    Keys.onPressed: {
        if (!!ifaceLoader.item) {
            if (ifaceLoader.item.state === "ui") {
                walking(event.key)
                if (event.key === Qt.Key_I && (!keyIPressed && !interactionBlocked)) {
                    keyIPressed = true
                    if (ifaceLoader.item.interfaceLoader.item.inventoryLoader.status === Loader.Ready) {
                        ifaceLoader.item.interfaceLoader.item.closeInventory()
                    }
                    else {
                        ifaceLoader.item.interfaceLoader.item.openInventory(mainHero, mainHero)
                    }
                }
                if (event.key === Qt.Key_E && !keyEPressed && !interactionBlocked) {
                    keyEPressed = true
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
                // if (event.key === Qt.Key_R) {//disable on release
                //     ifaceLoader.item.state = "dialogue"
                //     ifaceLoader.item.interfaceLoader.item.entity1 = mainHero
                // }
                if (event.key === Qt.Key_C) {//disable on release
                    if (ifaceLoader.item.state2 === "cheatsOn") ifaceLoader.item.state2 = "cheatsOff"
                    else if (ifaceLoader.item.state2 === "cheatsOff") ifaceLoader.item.state2 = "cheatsOn"

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

    SequentialAnimation {
        running: keyEPressed
        PauseAnimation {duration: 250}
        ScriptAction {script: keyEPressed = false}
    }

    SequentialAnimation {
        running: keyIPressed
        PauseAnimation {duration: 250}
        ScriptAction {script: keyIPressed = false}
    }
}
