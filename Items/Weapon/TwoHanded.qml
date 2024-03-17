import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        ...group0Items, ...group1Items, ...group2Items//, ...group3Items
    ]

    readonly property var group0Items: [
        {name: "inactive chainsaw", type: "Two Hands", range: 4, damage: 5}
    ]
    readonly property var group1Items: [
        {name: "bat", type: "Two Hands", range: 3, damage: 4, rarity: "common"},
        {name: "steel bat", type: "Two Hands", range: 3, damage: 6, rarity: "uncommon"},
        {name: "noose", type: "Two Hands", range: 1, damage: 10, rarity: "rare"},
        {name: "cinder block", type: "Two Hands", range: 5, damage: 7, rarity: "rare", buffName: ["slowness"]}
    ]
    readonly property var group2Items: [
        {name: "chainsaw", type: "Two Hands", range: 4, damage: 10, rarity: "rare", buffName: ["sharpness"]},
        {name: "spear", type: "Two Hands", range: 5, damage: 3, rarity: "common", buffName: ["sharpness"]},
        {name: "bow", type: "Two Hands", range: 10, damage: 2, rarity: "rare", buffName: ["sharpness"]},
        {name: "scythe", type: "Two Hands", range: 5, damage: 8, rarity: "rare"},
        {name: "pitchfork", type: "Two Hands", range: 5, damage: 5, rarity: "uncommon", buffName: ["sharpness"]}
    ]
    readonly property var group3Items: [
    ]
}
