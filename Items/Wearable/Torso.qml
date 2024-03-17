import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        ...group0Items, ...group1Items, ...group2Items//, ...group3Items
    ]

    readonly property var group0Items: [
        {name: "baldric & garters", type: "Body", defense: 4},
        {name: "master look", type: "Body", defense: 5, buffName: ["greatDmgUp"]},
        {name: "slave look", type: "Body", defense: 3, buffName: ["dmgUp"]},
        {name: "peacoat & t-shirt", type: "Body", defense: 4, buffName: ["honour"]},
    ]
    readonly property var group1Items: [
        {name: "t-shirt", type: "Body", defense: 1, rarity: "common" },
        {name: "baldric"/*портупея*/, type: "Body", defense: 1, rarity: "common"},
        {name: "broken handcuffs", type: "Body", defense: 1, rarity: "uncommon", buffName: ["dmgUp"]},
        {name: "windcheater"/*ветровка*/, type: "Body", defense: 2, rarity: "uncommon"},
        {name: "backpack", type: "Body", defense: 1, rarity: "uncommon", buffName: ["invUp"]},
        {name: "jacket", type: "Body", defense: 1, rarity: "uncommon"},
        {name: "sweatshirt", type: "Body", defense: 2, rarity: "rare", buffName: ["wetness"], additionalInfo: "It is unclear who could use a sweatshirt in such hot weather"},
        {name: "croptop", type: "Body", defense: 1, rarity: "uncommon"},
        {name: "armoured bra", type: "Body", defense: 2, rarity: "rare"}
    ]
    readonly property var group2Items: [
        {name: "army peacoat", type: "Body", defense: 2, rarity: "uncommon",}
    ]
    readonly property var group3Items: [
    ]
}
