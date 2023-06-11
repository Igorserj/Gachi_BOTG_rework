import QtQuick 2.15

Item {
    readonly property var buffNames: ["StrengthUp", "SpeedUp", "HealthHeal", "HealthRegen", "HealthUp",
        "Vanish", "StaminaRegen", "StaminaHeal", "StaminaUp"]
    readonly property var debuffNames: ["StrengthDown", "SpeedDown", "HealthDown", "HealthDecrease",
        "Stun", "StaminaDown", "StaminaDecrease"]
    readonly property var types: ["Permanent", "Immediate", "Continuous"]
    readonly property var buffs: [strUp, spUp, , , hpUp]
    property var currentBuffs: []
    property int buffLevel: 1
    property var usedByEntity: entity
    property alias repeater: repeater
    visible: false

    Repeater {
        id: repeater
        Loader {
            id: buffLoad
            property var currentIndex: index
            property double timeElapsed: modelData[1]
            property bool isPermanent: modelData[2]
            sourceComponent: modelData[0] !== "" ? buffs[buffNames.indexOf(modelData[0])] : undefined
        }
    }
    Component {
        id: strUp
        BuffPattern {
            type: types[1]
            timeDuration: 10000
            characteristic: "damage"
            name: "Increased damage"
            description: "Your damage increased by 1.5 times."
        }
    }
    Component {
        id: spUp
        BuffPattern {
            type: types[1]
            timeDuration: 5000
            characteristic: "speed"
            name: "Increased speed"
            description: "Your speed increased by 1.1 times."
        }
    }

    Component {
        id: hpUp
        BuffPattern {
            type: types[1]
            timeDuration: 10000
            characteristic: "health"
            name: "Increased max health"
            description: "Your health increased by 20 hp."
        }
    }

    function updateBuffs(addBuff = "", index = -1, permanent = false) {
        var buffProperties = []
        if (currentBuffs.length > 0) {
            for (let i = 0; i < currentBuffs.length; i++) {
                let buff = repeater.itemAt(i).item
                let buff2 = []
                buff2.push(currentBuffs[i][0], buff.timeElapsed, buff.isPermanent)
                buffProperties.push(buff2)
            }
        }
        if (index !== -1) {
            repeater.itemAt(index).item.animation.stop()
            buffProperties.splice(index, 1)
        }
        else {
            let buff2 = []
            buff2.push(addBuff, 0, permanent)
            buffProperties.push(buff2)
        }
        toolTip.hide()
        currentBuffs = buffProperties
        repeater.model = currentBuffs
    }
}
