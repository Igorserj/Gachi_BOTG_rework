import QtQuick 2.15

Item {
    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_A) {
            toTheLeft()
        } else if (event.key === Qt.Key_D) {
            toTheRight()
        } else if (event.key === Qt.Key_W) {
            toTheTop()
        } else if (event.key === Qt.Key_S) {
            toTheBot()
        }
        if (event.key === Qt.Key_H) {
            health -= 20
        }
        if (event.key === Qt.Key_I) {
            if (ifaceLoader.item.state === "ui")
                ifaceLoader.item.state = "inventory"
            else ifaceLoader.item.state = "ui"
        }
        if (event.key === Qt.Key_J && animations.attackReady) {
            nmyScan()
        }
        if (event.key === Qt.Key_Shift) {
            mainHero.run = 1
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
