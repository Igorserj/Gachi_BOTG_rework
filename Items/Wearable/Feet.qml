import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        /*...group0Items,*/ ...group1Items, ...group2Items//, ...group3Items
    ]

    readonly property var group0Items: [

    ]
    readonly property var group1Items: [
        {name: "Sneakers", type: "Feet", defense: 1, rarity: "common", additionalInfo: "Put my sneakers on"},
        {name: "Stylish boots", type: "Feet", defense: 1, rarity: "common"},
        {name: "Moccasins", type: "Feet", defense: 1, rarity: "common"},
        {name: "slippers", type: "Feet", defense: 1, rarity: "common"},
        {name: "Homeless socks", type: "Feet", defense: 1, rarity: "uncommon", buffName: ["stink"]},
        {name: "Flippers", type: "Feet", defense: 2, rarity: "rare"},
        {name: "Roller-skates", type: "Feet", defense: 1, rarity: "uncommon", buffName: ["spdUp", "imbalance"]},
        {name: "Women's shoes", type: "Feet", defense: 1, rarity: "uncommon", buffName: ["imbalance"]},
        {name: "Neko paws", type: "Feet", defense: 2, rarity: "rare"}
    ]
    readonly property var group2Items: [
        {name: "Shitpressers", type: "Feet", defense: 2, rarity: "uncommon", buffName: ["dirtyTrace"]},
        {name: "Hermes boots", type: "Feet", defense: 2, rarity: "rare", buffName: ["spdUp"]},
        {name: "Military boots", type: "Feet", defense: 3, rarity: "rare"},
        {name: "Rainbow boots", type: "Feet", defense: 2, rarity: "uncommon", buffName: ["rainbowTrace"]},
        {name: "Climbing shoes", type: "Feet", defense: 2, rarity: "common"}
    ]
    readonly property var group3Items: [
    ]
}
