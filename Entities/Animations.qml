import QtQuick 2.15

Item {
    /*--------------------------------------------*/
    //moveLeft, moveRight, moveUp, moveDown
    property bool moveLeftRun: false
    property bool moveRightRun: false
    property bool moveUpRun: false
    property bool moveDownRun: false
    property int speed: run === 0 ? entity.speed : entity.speed * 1.75
    readonly property int moveDuration: 100
    readonly property int staminaQ: 1
    /*--------------------------------------------*/

    /*--------------------------------------------*/
    //dealDamage, decreasing(health)
    property bool attackReady: true
    property var targets: []
    property var healths: []
    property bool pauseCondition: ifaceLoader.status === Loader.Ready ? ifaceLoader.item.pauseStates.includes(ifaceLoader.item.state) : true
    /*--------------------------------------------*/

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
        id: moveLeft
        running: (moveLeftRun && entity.walkLeft === 1) && !movementBlocked
        paused: running ? pauseCondition : false
        ScriptAction {
            script: {
                moveRightRun = false
            }
        }
        ParallelAnimation {
            ParallelAnimation {
                PropertyAnimation {
                    target: entity.parent
                    property: anotherRoom ? "" : "x"
                    to: entity.parent.x - speed
                    duration: moveDuration
                }
                SequentialAnimation {
                    PropertyAction {
                        target: entity.parent
                        property: anotherRoom ? "x" : ""
                        value: entity.parent.x - speed
                    }
                    PauseAnimation {
                        duration: moveDuration
                    }
                }
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            if (run === 1) runActive()
            moveLeftRun = false
            objScan(1, 0)
            itmScan(1, 0)
        }
    }

    SequentialAnimation {
        id: moveRight
        running: (moveRightRun && entity.walkRight === 1) && !movementBlocked
        paused: running ? pauseCondition : false
        ScriptAction {
            script: {
                moveLeftRun = false
            }
        }
        ParallelAnimation {
            ParallelAnimation {
                PropertyAnimation {
                    target: entity.parent
                    property: anotherRoom ? "" : "x"
                    to: entity.parent.x + speed
                    duration: moveDuration
                }
                SequentialAnimation {
                    PropertyAction {
                        target: entity.parent
                        property: anotherRoom ? "x" : ""
                        value: entity.parent.x + speed
                    }
                    PauseAnimation {
                        duration: moveDuration
                    }
                }
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            if (run === 1) runActive()
            moveRightRun = false
            objScan(1, 1)
            itmScan(1, 1)
        }
    }

    SequentialAnimation {
        id: moveUp
        running: (moveUpRun && entity.walkUp === 1) && !movementBlocked
        paused: running ? pauseCondition : false
        ScriptAction {
            script: {
                moveDownRun = false
            }
        }
        ParallelAnimation {
            ParallelAnimation {
                PropertyAnimation {
                    target: entity.parent
                    property: anotherRoom ? "" : "y"
                    to: entity.parent.y - speed
                    duration: moveDuration
                }
                SequentialAnimation {
                    PropertyAction {
                        target: entity.parent
                        property: anotherRoom ? "y" : ""
                        value: entity.parent.y - speed
                    }
                    PauseAnimation {
                        duration: moveDuration
                    }
                }
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            if (run === 1) runActive()
            moveUpRun = false
            objScan(0, 0)
            itmScan(0, 0)
        }
    }

    SequentialAnimation {
        id: moveDown
        running: (moveDownRun && entity.walkDown === 1) && !movementBlocked
        paused: running ? pauseCondition : false
        ScriptAction {
            script: {
                moveUpRun = false
            }
        }
        ParallelAnimation {
            ParallelAnimation {
                PropertyAnimation {
                    target: entity.parent
                    property: anotherRoom ? "" : "y"
                    to: entity.parent.y + speed
                    duration: moveDuration
                }
                SequentialAnimation {
                    PropertyAction {
                        target: entity.parent
                        property: anotherRoom ? "y" : ""
                        value: entity.parent.y + speed
                    }
                    PauseAnimation {
                        duration: moveDuration
                    }
                }
            }
            ScriptAction {
                script: staminaDecrease.running = true
            }
        }
        onFinished: {
            if (run === 1) runActive()
            moveDownRun = false
            objScan(0, 1)
            itmScan(0, 1)
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
        running: (entity.stamina < entity.maxStamina && run === 0) && !movementBlocked
        loops: Animation.Infinite
        PauseAnimation {
            duration: 250
        }
        ScriptAction {
            script: {
                recovery = true
                if (entity.stamina + staminaQ > entity.maxStamina) entity.stamina = entity.maxStamina
                else entity.stamina += staminaQ
            }
        }
        PauseAnimation {
            duration: 250
        }
    }
    PropertyAction {
        running: entity.stamina === entity.maxStamina && run === 0
        target: entity
        property: "recovery"
        value: false
    }

    SequentialAnimation {
        id: horizontalCloser
        paused: running ? pauseCondition : false
        PropertyAnimation {
            id: horizontalCloserX
            target: entity.parent
            property: "x"
            duration: 100
        }
    }
    SequentialAnimation {
        id: verticalCloser
        paused: running ? pauseCondition : false
        PropertyAnimation {
            id: verticalCloserY
            target: entity.parent
            property: "y"
            duration: 100
        }
    }

    SequentialAnimation {
        id: decrasing
        paused: running ? pauseCondition : false
        PauseAnimation {
            duration: 350
        }
        ScriptAction {
            id: healthDecrase
            script: dealDamageScript()
        }
    }

    SequentialAnimation {
        //healthOverfill
        running: health > maxHealth
        loops: Animation.Infinite
        PauseAnimation {
            duration: 1000
        }
        ScriptAction {
            script: --health
        }
    }

    SequentialAnimation {
        running: facingRight
        PropertyAnimation {
            target: entity
            property: "rot"
            to: 0
            easing.type: Easing.OutCubic
        }
    }
    SequentialAnimation {
        running: !facingRight
        PropertyAnimation {
            target: entity
            property: "rot"
            to: -180
            easing.type: Easing.OutCubic
        }
    }
}
