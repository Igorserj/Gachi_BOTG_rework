import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        ...group0Items, ...group1Items, ...group2Items, ...group3Items
    ]

    readonly property var group0Items: [
        {name: "empty bottle", type: "One Hand", range: 1, damage: 2},
        {name: "rose", type: "One Hand", range: 1, damage: 4, buffName: ["sharpness"]}
    ]
    readonly property var group1Items: [
        {name: "stick", type: "One Hand", range: 3, damage: 2, rarity: "common"},
        {name: "knuckless", type: "One Hand", range: 1, damage: 3, rarity: "uncommon"},
        {name: "fork", range: 1, type: "One Hand", damage: 1, rarity: "common", buffName: ["sharpness"]},
        {name: "belt", range: 2, type: "One Hand", damage: 2, rarity: "common",},
        {name: "whip", range: 3, type: "One Hand", damage: 1, rarity: "common"},
        {name: "dragon dildo", range: 3, damage: 1, rarity: "uncommon"},
        {name: "boomerang", type: "One Hand", range: 7, damage: 1, rarity: "rare",  buffName: ["line of sight"]},
        {name: "shuriken", type: "One Hand", range: 7, damage: 4, rarity: "rare", buffName: ["sharpness"]},
        {name: "crowbar", type: "One Hand", range: 3, damage: 3, rarity: "rare"}
    ]
    readonly property var group2Items: [
        {name: "kitchen knife", type: "One Hand", range: 2, damage: 5, rarity: "rare", buffName: ["sharpness"]},
        {name: "nunchucks", type: "One Hand", range: 3, damage: 4, rarity: "rare"},
        {name: "steel stick", type: "One Hand", range: 3, damage: 3, rarity: "common"},
        {name: "torch", type: "One Hand", range: 3, damage: 5, rarity: "uncommon", buffName: ["flame"]}
    ]
    readonly property var group3Items: [
        {name: "military knife", type: "One Hand", range: 3, damage: 8, rarity: "rare", buffName: ["sharpness"]}
    ]
}
