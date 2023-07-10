import QtQuick 2.15

Item {
    property string characteristic: ""
    property string type: ""
    property double timeDuration: 0
    property double deltaDuration: 0
    property int iteration: 0
    property double timeElapsed: parent.timeElapsed
    property int timeLeft: 0
    property int points: parent.points !== 0 ? parent.points : predefinedPoints
    property int predefinedPoints: 0
    property string name: ""
    property string description: ""
    property bool isPermanent: parent.isPermanent
    property bool isReversible: parent.isReversible
    property alias animation: animation
    property alias instantAnimation: instantAnimation

    ParallelAnimation {
        id: animation
        running: type !== "Instant" && !isPermanent
        paused: running ? ifaceLoader.item.state === "menu" : false
        SequentialAnimation {
            id: buffRun
            loops: type === "Immediate" ? 1 : type === "Continuous" ? Math.ceil((timeDuration - timeElapsed) / deltaDuration) : 1
            ScriptAction {
                script: {
                    if (type === "Immediate") {
                        if (timeElapsed === 0) {
                            console.log(characteristic, points)
                            if (characteristic === "damage") {
                                usedByEntity.damage *= 1.5
                            }
                            else if (characteristic === "speed") {
                                usedByEntity.speedCoeff *= 1.1
                            }
                            else if (characteristic === "health") {
                                usedByEntity.health += points
                            }
                            else if (characteristic === "stamina") {
                                usedByEntity.stamina += points
                            }
                            else if (characteristic === "maxHealth") {
                                usedByEntity.maxHealth += points
                            }
                            else if (characteristic === "maxStamina") {
                                usedByEntity.maxStamina += points
                            }
                        }
                    }
                    else if (type === "Continuous") {
                        if (timeElapsed !== 0) {
                            if (characteristic === "health" && usedByEntity.health + points <= usedByEntity.maxHealth) {
                                usedByEntity.health += points
                            }
                            else if (characteristic === "health" && usedByEntity.health + points > usedByEntity.maxHealth) {
                                usedByEntity.health = usedByEntity.maxHealth
                            }

                            if (characteristic === "stamina" && usedByEntity.stamina + points <= usedByEntity.maxStamina) {
                                usedByEntity.stamina += points
                            }
                            else if (characteristic === "stamina" && usedByEntity.stamina + points > usedByEntity.maxStamina) {
                                usedByEntity.stamina = usedByEntity.maxStamina
                            }
                        }
                    }
                }
            }
            PauseAnimation {
                duration: type === "Immediate" ? (timeDuration - timeElapsed) : deltaDuration
            }
            ScriptAction {
                script: {
                    iteration++
                }
            }
        }
        SequentialAnimation {
            running: buffRun.running
            loops: (timeDuration - timeElapsed) / 250
            PauseAnimation {
                duration: 250
            }
            ScriptAction {
                script: {
                    timeElapsed += 250
                    timeLeft = ((timeDuration - timeElapsed) / 1000)
                }
            }
        }
        onFinished: {
            if (type === "Immediate") {
                if (characteristic === "damage") {
                    usedByEntity.damage /= 1.5
                }
                else if (characteristic === "speed") {
                    usedByEntity.speedCoeff /= 1.1
                }
                else if (characteristic === "maxHealth") {
                    usedByEntity.maxHealth -= points
                    if (usedByEntity.health > usedByEntity.maxHealth) {
                        usedByEntity.health = usedByEntity.maxHealth
                    }
                }
                else if (characteristic === "maxStamina") {
                    usedByEntity.maxStamina -= points
                    if (usedByEntity.stamina > usedByEntity.maxStamina) {
                        usedByEntity.stamina = usedByEntity.maxStamina
                    }
                }
            }
            else if (type === "Continuous") {
                if (characteristic === "health" && usedByEntity.health + points <= usedByEntity.maxHealth) {
                    usedByEntity.health += points
                }
                else if (characteristic === "health" && usedByEntity.health + points > usedByEntity.maxHealth) {
                    usedByEntity.health = usedByEntity.maxHealth
                }

                if (characteristic === "stamina" && usedByEntity.stamina + points <= usedByEntity.maxStamina) {
                    usedByEntity.stamina += points
                }
                else if (characteristic === "stamina" && usedByEntity.stamina + points > usedByEntity.maxStamina) {
                    usedByEntity.stamina = usedByEntity.maxStamina
                }
            }
            updateBuffs("", parent.currentIndex)
        }
    }

    SequentialAnimation {
        id: instantAnimation
        running: type === "Instant" || isPermanent
        ScriptAction {
            script: {
                if (isPermanent) {
                    permanentScript()
                }
                else instantScript()
            }
        }
        onFinished: {
            updateBuffs("", parent.currentIndex)
        }
    }

    function instantScript() {

        if (characteristic === "health") {
            if (usedByEntity.health + points <= usedByEntity.maxHealth) {
                usedByEntity.health += points
            }
            else {
                usedByEntity.health = usedByEntity.maxHealth
            }
        }
        if (characteristic === "stamina") {
            if (usedByEntity.stamina + points <= usedByEntity.maxStamina) {
                usedByEntity.stamina += points
            }
            else {
                usedByEntity.stamina = usedByEntity.maxStamina
            }
        }
        timeElapsed = 0
        timeLeft = 0
    }

    function permanentScript() {
        if (isReversible) {
            points = -points
        }
        if (characteristic === "maxHealth") {
            usedByEntity.maxHealth += points
        }
        else if (characteristic === "health") {
            usedByEntity.health += points
        }
        else if (characteristic === "maxStamina") {
            usedByEntity.maxStamina += points
        }
        else if (characteristic === "stamina") {
            usedByEntity.stamina += points
        }
        else if (characteristic === "damage") {
            usedByEntity.damage += points
        }
        else if (characteristic === "speed") {
            usedByEntity.speedCoeff += points
        }
        else if (characteristic === "defense") {
            usedByEntity.defense += points
        }

        timeElapsed = 0
        timeLeft = 0
    }
}
