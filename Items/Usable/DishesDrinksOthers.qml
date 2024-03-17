import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        ...group0Items, ...group1Items, ...group2Items//, ...group3Items
    ]

    readonly property var group0Items: [
        {name: "roasted mushrooms", type: "Consumable"},
        {name: "spoiled dish", type: "Consumable"},
        {name: "spoiled drink", type: "Consumable"},
        {name: "plantain salad", type: "Consumable", buffName: ["hpRegen"]},
        {name: "hop beer", type: "Consumable", buffName: ["hpUp"]},
        {name: "camo food", type: "Consumable", buffName: ["vanish"]},
        {name: "mushroom water", type: "Consumable", buffName: ["staHeal"]},
        {name: "poridge", type: "Consumable"},
        {name: "liquid poridge", type: "Consumable"}
    ]
    readonly property var group1Items: [
        {name: "fruit salad", type: "Consumable", hp: 30, rarity: "common"},
        {name: "weed salad", type: "Consumable", hp: 30, rarity: "common"},
        {name: "fruit drink", type: "Consumable", hp: 30, rarity: "common", buffName: ["staHeal"]},
        {name: "mojito", type: "Consumable", hp: 33, rarity: "common", buffName: ["staHeal"]},
        {name: "hercules porridge", type: "Consumable", hp: 22, rarity: "uncommon", buffName: ["dmgUp"]},
        {name: "sweet water", type: "Consumable", hp: 18, rarity: "common", buffName: ["spdUp"]},
        {name: "raspjam", type: "Consumable", hp: 22, rarity: "common", buffName: ["hpHeal"]},
        {name: "refreshing drink", type: "Consumable", hp: 30, rarity: "common", buffName: ["hpRegen"]},
        {name: "coffee energy", type: "Consumable", hp: 18, rarity: "uncommon", buffName: ["staUp"]}
    ]
    readonly property var group2Items: [
        {name: "vodka", type: "Consumable", hp: 10, rarity: "uncommon", buffName: ["spdUp"]},
        {name: "cigarette", type: "Consumable", hp: 5, rarity: "common", buffName: ["dmgUp"]}
    ]
    readonly property var group3Items: [
    ]
}
