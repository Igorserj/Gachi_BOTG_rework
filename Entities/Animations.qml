import QtQuick 2.15

Item {
    /*--------------------------------------------*/
    //moveLeft, moveRight, moveUp, moveDown
    property bool moveLeftRun: false
    property bool moveRightRun: false
    property bool moveUpRun: false
    property bool moveDownRun: false
    property int speed: run === 0 ? entity.speed : stamina >= 2 ? entity.speed * 2 : entity.speed
    readonly property int moveDuration: 100
    readonly property int staminaQ: 1
    /*--------------------------------------------*/

    /*--------------------------------------------*/
    //dealDamage, decreasing(health)
    property bool attackReady: true
    property var targets: []
    property var healths: []
    /*--------------------------------------------*/

    SequentialAnimation {
        id: moveLeft
        running: moveLeftRun && entity.walkLeft === 1
        paused: running ? ifaceLoader.item.state === "menu" : false
        ScriptAction {
            script: {
                moveRightRun = false
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: entity.parent
                property: "x"
                to: entity.parent.x - speed
                duration: moveDuration
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            moveLeftRun = false
            objScan(1, 0)
        }
    }

    SequentialAnimation {
        id: moveRight
        running: moveRightRun && entity.walkRight === 1
        paused: running ? ifaceLoader.item.state === "menu" : false
        ScriptAction {
            script: {
                moveLeftRun = false
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: entity.parent
                property: "x"
                to:  entity.parent.x + speed
                duration: moveDuration
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            moveRightRun = false
            objScan(1, 1)
        }
    }

    SequentialAnimation {
        id: moveUp
        running: moveUpRun && entity.walkUp === 1
        paused: running ? ifaceLoader.item.state === "menu" : false
        ScriptAction {
            script: {
                moveDownRun = false
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: entity.parent
                property: "y"
                to: entity.parent.y - speed
                duration: moveDuration
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            moveUpRun = false
            objScan(0, 0)
        }
    }

    SequentialAnimation {
        id: moveDown
        running: moveDownRun && entity.walkDown === 1
        paused: running ? ifaceLoader.item.state === "menu" : false
        ScriptAction {
            script: {
                moveUpRun = false
            }
        }
        ParallelAnimation {
            PropertyAnimation {
                target: entity.parent
                property: "y"
                to: entity.parent.y + speed
                duration: moveDuration
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            moveDownRun = false
            objScan(0, 1)
        }
    }

    PropertyAnimation {
        id: staminaDecrease
        target: entity
        property: run === 1 && stamina > staminaQ ? "stamina" : ""
        to: entity.stamina - 2 * staminaQ
        duration: moveDuration
    }

    SequentialAnimation {
        running: entity.stamina < entity.maxStamina && run === 0
        loops: Animation.Infinite
        PauseAnimation {
            duration: 250
        }
        ScriptAction {
            script: {
                if (entity.stamina + staminaQ > entity.maxStamina) entity.stamina = entity.maxStamina
                else entity.stamina += staminaQ
            }
        }
        PauseAnimation {
            duration: 250
        }
    }

    function comeCloser(hor, edge) {
        if (hor === 1) {
            horizontalCloserX.to = edge
            horizontalCloser.running = true
        }
        else {
            verticalCloserY.to = edge
            verticalCloser.running = true
        }
    }

    SequentialAnimation {
        id: horizontalCloser
        paused: running ? ifaceLoader.item.state === "menu" : false
        PropertyAnimation {
            id: horizontalCloserX
            target: entity.parent
            property: "x"
            duration: 100
        }
    }
    SequentialAnimation {
        id: verticalCloser
        paused: running ? ifaceLoader.item.state === "menu" : false
        PropertyAnimation {
            id: verticalCloserY
            target: entity.parent
            property: "y"
            duration: 100
        }
    }

    function dealDamage(targetList, healthList) {
        targets = targetList
        healths = healthList
        if (!!targets) {
            decrasing.running = true
        }
    }
    function dealDamageScript() {
        for (let i = 0; i < targets.length; i++) {
            targets[i].health = healths[i]
        }
        attackReady = true
    }

    SequentialAnimation {
        id: decrasing
        paused: running ? ifaceLoader.item.state === "menu" : false
        PauseAnimation {
            duration: 350
        }
        ScriptAction {
            id: healthDecrase
            script: dealDamageScript()
        }
    }
}
