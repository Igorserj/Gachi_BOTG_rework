import QtQuick 2.15

Item {
    property string characteristic: ""
    property string type: ""
    property double timeDuration: 0
    property double deltaDuration: 0
    property int timeLeft: (timeDuration - parent.timeElapsed) / 1000 + 1
    property int points: parent.points !== 0 ? parent.points : predefinedPoints
    property int predefinedPoints: 0
    property string name: ""
    property string description: ""
    property bool isPermanent: parent.isPermanent
    property bool isReversible: parent.isReversible
    property alias animation: animation

    ParallelAnimation {
        id: animation
        running: ifaceLoader.status === Loader.Ready ? ifaceLoader.item.state === "ui" : false
        loops: loopsCalc()

        PauseAnimation {
            duration: pauseCalc()
        }

        ScriptAction {
            script: isReversible ? typeTake() : typeGive()
        }

        onFinished: {
            if (isPermanent) {}
            else typeTake()
            updateBuffs(parent.buffName, parent.currentIndex, isPermanent, points, isReversible, parent.timeElapsed)
        }
    }

    Timer {
        id: timer
        property bool started: false
        running: started && ifaceLoader.status === Loader.Ready ? ifaceLoader.item.state === "ui" : false
        repeat: true
        interval: 100
        onTriggered: timeCalc()
    }

    function timeCalc() {
        parent.timeElapsed += timer.interval
        currentBuffs[currentIndex][5] = parent.timeElapsed
    }

    function loopsCalc() {
        if (type === "Continuous") {
            return Math.ceil(timeDuration / deltaDuration)
        }
        else return 1
    }

    function pauseCalc() {
        if (isPermanent) {return 0}
        else {
            if (type === "Continuous") {
                return (deltaDuration - parent.timeElapsed % deltaDuration)
            }
            else if (type !== "Continuous") {
                return (timeDuration - parent.timeElapsed % timeDuration)
            }
        }
    }

    function typeGive() {
        if (type === "Immediate") immediateGive()
        else if (type === "Continuous") giving()
        else if (type === "Instant") giving()
        timer.started = true
    }

    function giving() {
        if (characteristic === "damage") usedByEntity.damage += points
        else if (characteristic === "speed") usedByEntity.speedCoeff += points
        else if (characteristic === "health") usedByEntity.health += points
        else if (characteristic === "stamina") usedByEntity.stamina += points
        else if (characteristic === "maxHealth") usedByEntity.maxHealth += points
        else if (characteristic === "maxStamina") usedByEntity.maxStamina += points
        else if (characteristic === "defense") usedByEntity.defense += points
    }

    function immediateGive() {
        if (parent.timeElapsed === 0) {
            giving()
        }
    }

    function typeTake() {
        if (type === "Immediate") taking()
        else if (type === "Continuous") {}
        else if (type === "Instant") {}
    }

    function taking() {
        if (characteristic === "damage") usedByEntity.damage -= points
        else if (characteristic === "speed") usedByEntity.speedCoeff -= points
        else if (characteristic === "health") usedByEntity.health -= points
        else if (characteristic === "stamina") usedByEntity.stamina -= points
        else if (characteristic === "maxHealth") usedByEntity.maxHealth -= points
        else if (characteristic === "maxStamina") usedByEntity.maxStamina -= points
        else if (characteristic === "defense") usedByEntity.defense -= points
    }
}
