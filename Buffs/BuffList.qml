import QtQuick 2.15

Item {
    readonly property var buffNames: ["StrengthUp", "SpeedUp", "HealthHeal", "HealthRegen", "HealthUp",
                                        "Vanish", "StaminaRegen", "StaminaHeal", "StaminaUp"]
    readonly property var debuffNames: ["StrengthDown", "SpeedDown", "HealthDown", "HealthDecrease",
                                        "Stun", "StaminaDown", "StaminaDecrease"]
    readonly property var types: ["Permanent", "Immediate", "Continuous"]
    readonly property var buffs: [strUp, spUp]
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
            sourceComponent: modelData !== "" ? buffs[buffNames.indexOf(modelData)] : undefined
            Component.onCompleted: console.log(modelData)
        }
    }
    Component {
        id: strUp
        BuffPattern {
            type: types[1]
            timeDuration: 10000
            characteristic: "damage"
        }
    }
    Component {
        id: spUp
        BuffPattern {
            type: types[1]
            timeDuration: 5000
            characteristic: "speed"
        }
    }
}
