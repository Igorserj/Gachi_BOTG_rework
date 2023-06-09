import QtQuick 2.15

Item {
    property string characteristic: ""
    property string type: ""
    property double timeDuration: 0
    property double deltaDuration: 0
    property int iteration: 0
    property double timeElapsed: 0
    readonly property double timeLeft: (timeDuration - timeElapsed).toFixed(1)
    ParallelAnimation {
        running: true
        paused: ifaceLoader.item.state === "menu"
        loops: type === "Immediate" ? 1 : type === "Continuous" ? Math.ceil(timeDuration / deltaDuration) : Animation.Infinite
        SequentialAnimation {
            ScriptAction {
                script: {
                    if (characteristic === "damage") {
                        usedByEntity.damage *= 1.5
                    }
                    else if (characteristic === "speed") {
                        usedByEntity.speed *= 1.1
                    }
                }
            }
            PauseAnimation {
                duration: type === "Immediate" ? timeDuration : deltaDuration
            }
            ScriptAction {
                script: {
                    if (characteristic === "damage") {
                        usedByEntity.damage /= 1.5
                    }
                    else if (characteristic === "speed") {
                        usedByEntity.speed /= 1.1
                    }
                    iteration++
                }
            }
        }
        SequentialAnimation {
            PauseAnimation {
                duration: 250
            }
            ScriptAction {
                script: timeElapsed += 250
            }
        }
        onFinished: { currentBuffs[parent.parent.currentIndex] = ""; console.log(currentBuffs); repeater.model = currentBuffs }
    }

}
