import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        /*...group0Items,*/ ...group1Items, ...group2Items//, ...group3Items
    ]

    readonly property var group0Items: [

    ]
    readonly property var group1Items: [
        {name: "garters", type: "Legs", defense: 1, rarity: "common"},
        {name: "jeans", type: "Legs", defense: 1, rarity: "common"},
        {name: "pants", type: "Legs", defense: 1, rarity: "common"},
        {name: "shorts", type: "Legs", defense: 1, rarity: "common"},
        {name: "torn leggings" /*Леггинсы петуха*/, type: "Legs", defense: 1, rarity: "uncommon", buffName: ["spdUp"]},
        {name: "knee pads", type: "Legs", defense: 1, rarity: "common", buffName: ["getUp"]},
        {name: "pantyhose", type: "Legs", defense: 1, rarity: "uncommon"},
        {name: "stockings", type: "Legs", defense: 1, rarity: "uncommon"},
        {name: "sweatpants", type: "Legs", defense: 2, rarity: "rare", buffName: ["spdUp"]},
        {name: "armoured panties", type: "Legs", defense: 2, rarity: "rare"},
        {name: "mini-skirt", type: "Legs", defense: 1, rarity: "uncommon"}
    ]
    readonly property var group2Items: [
        {name: "clown pants", type: "Legs", defense: 2, rarity: "uncommon",},
        {name: "boxers", type: "Legs", defense: 2, rarity: "rare", buffName: ["dmgUp"]},
        {name: "barbarian pants", type: "Legs", defense: 2, rarity: "rare", buffName: ["thorns"]}
    ]
    readonly property var group3Items: [
    ]
}
