import QtQuick 2.15

Item {
    readonly property var buffNames: ["StrengthUp", "SpeedUp", "HealthHeal", "HealthRegen", "HealthUp",
        "Vanish", "StaminaRegen", "StaminaHeal", "StaminaUp", "DefenseUp"]
    readonly property var debuffNames: ["StrengthDown", "SpeedDown", "HealthDown", "HealthDecrease",
        "Stun", "StaminaDown", "StaminaDecrease"]
    readonly property var types: ["Immediate", "Continuous", "Instant"]
    readonly property var buffs: [strUp, spUp, hpHeal, hpRegen, hpUp,
        , staRegen, staHeal, staUp, defUp
    ]

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
            property int points: modelData[3]
            property bool isReversible: modelData[4]
            sourceComponent: modelData[0] !== "" ? buffs[buffNames.indexOf(modelData[0])] : undefined
        }
    }
    Component {
        id: strUp
        BuffPattern {
            type: types[0]
            timeDuration: 10000
            characteristic: "damage"
            name: "Increased damage"
            description: "Your damage increased by 1.5 times."
        }
    }
    Component {
        id: spUp
        BuffPattern {
            type: types[0]
            timeDuration: 5000
            characteristic: "speed"
            name: "Increased speed"
            description: "Your speed increased by 1.1 times."
        }
    }

    Component {
        id: hpHeal
        BuffPattern {
            type: types[2]
            timeDuration: 1
            characteristic: "health"
            name: "Healing"
            description: "Healed by N hp."
//            points: 20
        }
    }

    Component {
        id: hpRegen
        BuffPattern {
            type: types[1]
            timeDuration: 10000
            deltaDuration: 1000
            characteristic: "health"
            name: "Health regeneration"
            description: "Heal by 5 every second."
//            points: 5
        }
    }

    Component {
        id: hpUp
        BuffPattern {
            type: types[0]
            timeDuration: 10000
            characteristic: "maxHealth"
            name: "Increased max health"
            description: "Your health increased by points hp."
//            points: 20
        }
    }

    Component {
        id: staRegen
        BuffPattern {
            type: types[1]
            timeDuration: 10000
            deltaDuration: 1000
            characteristic: "stamina"
            name: "Stamina regeneration"
            description: "Restore 5 energy every second."
//            points: 5
        }
    }

    Component {
        id: staHeal
        BuffPattern {
            type: types[2]
            timeDuration: 1
            characteristic: "stamina"
            name: "Recovery"
            description: "Restored by N energy."
//            points: 20
        }
    }

    Component {
        id: staUp
        BuffPattern {
            type: types[0]
            timeDuration: 10000
            characteristic: "maxStamina"
            name: "Increased max stamina"
            description: "Your stamina increased by 20 energy."
//            points: 10
        }
    }

    Component {
        id: defUp
        BuffPattern {
            type: types[0]
            timeDuration: 10000
            characteristic: "defense"
            name: "Increased defense"
            description: ""
//            points: 10
        }
    }

    function updateBuffs(addBuff = "", index = -1, permanent = false, points = 0, reversible = false) {
        var buffProperties = []
        if (currentBuffs.length > 0) {
            for (let i = 0; i < currentBuffs.length; i++) {
                let buff = repeater.itemAt(i).item
                if (buff !== null) {
                    let buff2 = []
                    buff2.push(currentBuffs[i][0], buff.timeElapsed, buff.isPermanent, points, reversible)
                    buffProperties.push(buff2)
                }
            }
        }
        if (index !== -1) {
            let buff = repeater.itemAt(index).item
            if (buff !== null) {
                buff.animation.stop()
            }
            buffProperties.splice(index, 1)
        }
        else {
            let buff2 = []
            buff2.push(addBuff, 0, permanent, points, reversible)
            buffProperties.push(buff2)
        }
        toolTip.hide()
        currentBuffs = buffProperties
        repeater.model = currentBuffs
    }
}
