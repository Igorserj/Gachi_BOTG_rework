import QtQuick 2.15

Item {
    readonly property var itemNames: ["Vodka", "Bat", "Hat"]
    readonly property var items: [vodka, bat, hat]
    readonly property var types: ["Head", "Body", "Legs", "One Hand", "Two Hands", "Consumable"]
    visible: false

    ItemPattern {
        id: hat
        type: types[0]
        name: "Hat"
        additionalInfo: "Just a normal hat"
    }

    ItemPattern {
        id: vodka
        type: types[5]
        name: "Vodka"
        additionalInfo: "Vodka don't need to be presented"
        buffName: "StrengthUp"
    }

    ItemPattern {
        id: bat
        type: types[4]
        name: "Bat"
        additionalInfo: "Beat them up!"
        buffName: "SpeedUp"
    }
}
