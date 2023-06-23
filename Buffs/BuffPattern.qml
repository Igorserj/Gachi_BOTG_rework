import QtQuick 2.15

Item {
    property string characteristic: ""
    property string type: ""
    property double timeDuration: 0
    property double deltaDuration: 0
    property int iteration: 0
    property double timeElapsed: parent.timeElapsed
    property int timeLeft: 0
    property int hp: parent.hp
    property string name: ""
    property string description: ""
    property bool isPermanent: parent.isPermanent
    property alias animation: animation
    property alias instantAnimation: instantAnimation
    ParallelAnimation {
        id: animation
        running: type !== "Instant"
        paused: running ? ifaceLoader.item.state === "menu" : false
        SequentialAnimation {
            id: buffRun
            loops: isPermanent ? Animation.Infinite : type === "Immediate" ? 1 : type === "Continuous" ? Math.ceil((timeDuration - timeElapsed) / deltaDuration) : 1
            ScriptAction {
                script: {
                    if (timeElapsed === 0) {
                        if (characteristic === "damage") {
                            usedByEntity.damage *= 1.5
                        }
                        else if (characteristic === "speed") {
                            usedByEntity.speed *= 1.1
                        }
                        else if (characteristic === "health") {
                            usedByEntity.maxHealth += 20
                        }
                    }
                }
            }
            PauseAnimation {
                duration: isPermanent ? 9999999 : type === "Immediate" ? (timeDuration - timeElapsed) : deltaDuration
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
                    if (isPermanent) {
                        timeElapsed = 1
                        timeLeft = 9999999
                    }
                    else {
                        timeElapsed += 250
                        timeLeft = ((timeDuration - timeElapsed) / 1000)
                    }
                }
            }
        }
        onFinished: {
            if (characteristic === "damage") {
                usedByEntity.damage /= 1.5
            }
            else if (characteristic === "speed") {
                usedByEntity.speed /= 1.1
            }
            else if (characteristic === "health") {
                usedByEntity.maxHealth -= 20
            }
            updateBuffs("", parent.currentIndex)
        }
    }

    SequentialAnimation {
        id: instantAnimation
        running: type === "Instant"
        ScriptAction {
            script: {
                if (characteristic === "health") {
                    usedByEntity.health += hp
                    timeElapsed = 0
                    timeLeft = 0
                }
            }
        }
        onFinished: {
            updateBuffs("", parent.currentIndex)
        }
    }
}
