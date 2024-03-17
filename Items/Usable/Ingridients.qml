import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        /*...group0Items,*/ ...group1Items, ...group2Items//, ...group3Items
    ]

    readonly property var group0Items: [

    ]
    readonly property var group1Items: [
        {name: "apple", type: "Consumable", hp: 10, rarity: "common"},
        {name: "banana", type: "Consumable", hp: 10, rarity: "common"},
        {name: "mushroom", type: "Consumable", hp: 5, rarity: "common"},
        {name: "cheese", type: "Consumable", hp: 15, rarity: "uncommon"},
        {name: "water", type: "Consumable", hp: 10, rarity: "common"},
        {name: "buckweat", type: "Consumable", hp: 5, rarity: "uncommon"},
        {name: "sugar", type: "Consumable", hp: 2, rarity: "common"},
        {name: "raspberry", type: "Consumable", hp: 5, rarity: "common"},
        {name: "plantain", type: "Consumable", hp: 10, rarity: "uncommon"},
        {name: "yellowPlantain", type: "Consumable", hp: 10, rarity: "uncommon"},
        {name: "chanterelles", type: "Consumable", hp: 5, rarity: "common"}
    ]
    readonly property var group2Items: [
        {name: "hop", type: "Consumable", hp: 2, rarity: "uncommon"},
        {name: "camoshroom", type: "Consumable", hp: 5, rarity: "uncommon"},
        {name: "coffeeSeed", type: "Consumable", hp: 2, rarity: "uncommon"}
    ]
    readonly property var group3Items: [

    ]
}
