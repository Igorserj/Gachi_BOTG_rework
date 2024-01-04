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

    property var currentBuffs: /*!!hero ? opSave.level.hero.buffs :*/ []
    property int buffLevel: 1
    property var usedByEntity: entity
    property alias repeater: repeater
    visible: false

    // Component.onCompleted: {
    //     if (currentBuffs.length > 0 && usedByEntity === entGen.repeater.itemAt(0).item) {
    //         for (let i = 0; i < currentBuffs.length; i++) {
    //             console.log(opSave.level.hero.buffs[i])
    //             updateBuffs(opSave.level.hero.buffs[i][0], -1, opSave.level.hero.buffs[i][1], opSave.level.hero.buffs[i][2], opSave.level.hero.buffs[i][3])
    //         }
    //     }
    // }

    Repeater {
        id: repeater
        Loader {
            id: buffLoad
            property string buffName: modelData[0]
            property var currentIndex: index
            property double timeElapsed: modelData[1]
            property bool isPermanent: modelData[2]
            property int points: modelData[3]
            property bool isReversible: modelData[4]
            sourceComponent: buffName !== "" ? buffs[buffNames.indexOf(buffName)] : undefined
        }
    }
    Component {
        id: strUp
        BuffPattern {
            type: types[0]
            timeDuration: 15000
            predefinedPoints: 5
            characteristic: "damage"
            name: "Increased damage"
            description: "Your damage increased by 1.5 times."
        }
    }
    Component {
        id: spUp
        BuffPattern {
            type: types[0]
            timeDuration: 15000
            points: 3
            characteristic: "speed"
            name: "Increased speed"
            description: "Your speed increased on 10 points."
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
            predefinedPoints: 20
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
            predefinedPoints: 5
        }
    }

    Component {
        id: hpUp
        BuffPattern {
            type: types[0]
            timeDuration: 30000
            characteristic: "maxHealth"
            name: "Increased max health"
            description: "Your health increased by points hp."
            predefinedPoints: 20
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
            predefinedPoints: 5
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
            predefinedPoints: 20
        }
    }

    Component {
        id: staUp
        BuffPattern {
            type: types[0]
            timeDuration: 10000
            characteristic: "maxStamina"
            name: "Increased max stamina"
            description: "Your stamina increased by 10 energy."
            predefinedPoints: 10
        }
    }

    Component {
        id: defUp
        BuffPattern {
            type: types[0]
            timeDuration: 30000
            characteristic: "defense"
            name: "Increased defense"
            description: ""
            predefinedPoints: 10
        }
    }

    function updateBuffs(addBuff = "", index = -1, permanent = false, points = 0, reversible = false) {
        let buffProperties = []
        let buff
        let buff2 = []
        if (currentBuffs.length > 0) {
            for (let i = 0; i < currentBuffs.length; i++) {
                let buff = repeater.itemAt(i)
                if (buff !== null && buff.item !== null) {
                    buff2 = []
                    buff2.push(buff.buffName, buff.item.timeElapsed, buff.isPermanent, buff.points, buff.isReversible)
                    buffProperties.push(buff2)
                }
            }
        }
        if (index !== -1) {
            buff = repeater.itemAt(index).item
            if (buff !== null) {
                buff.animation.stop()
            }
            buffProperties.splice(index, 1)
        }
        else {
            buff2 = []
            buff2.push(addBuff, 0, permanent, points, reversible)
            buffProperties.push(buff2)
        }
        toolTip.hide()
        currentBuffs = buffProperties
        repeater.model = currentBuffs
    }
}
