import QtQuick 2.15

QtObject {
    // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var itemList: [
        ...group0Items, ...group1Items, ...group2Items, ...group3Items
    ]

    readonly property var group0Items: [
        {name: "broken gas mask", type: "Head", defense: 1, buffName: ["stamina up"], additionalInfo: "The lightweight gas mask with broken lenses"},
        {name: "rezz look", type: "Head", defense: 3, buffName: ["strong light"]},
        {name: "torn master mask", type: "Head", defense: 3, additionalInfo: "Leather mask of Ivan Chornozem with critical damages"}
    ]
    readonly property var group1Items: [
        {name : "cap", type: "Head", defense: 1, rarity: "common", additionalInfo: "An ordinary cap, which rappers wear"},
        {name: "slave mask", type: "Head", defense: 1, rarity: "common", additionalInfo: "A mask made for masochists"},
        {name: "nerd glasses", type: "Head", defense: 1, rarity: "uncommon", buffName: ["improved vision"], additionalInfo: "The glasses of a great boy"},
        {name: "sunglasses", type: "Head", defense: 1, rarity: "uncommon", buffName: ["brightness down"], additionalInfo: "You look cool"},
        {name: "rezz glasses", type: "Head", defense: 1, rarity: "rare", buffName: ["light"], additionalInfo: "It glows"},
        {name: "helmet with horns", type: "Head", defense: 2, rarity: "rare", buffName: ["thorns"], additionalInfo: "Fus Ro Dah!"},
        {name: "guy fawkes mask", type: "Head", defense: 1, rarity: "uncommon", buffName: ["anonymizer"], additionalInfo: "Ass hacking"},
        {name: "pigeon helm", type: "Head", defense: 1, rarity: "uncommon", additionalInfo: "Not your size"},
        {name: "mud mask", type: "Head", defense: 1, rarity: "rare", buffName: ["weak regeneration"], additionalInfo: "Mask made of mud has regenerative properties"},
        {name: "ninja protector", type: "Head", defense: 2, rarity: "rare", buffName: ["vanish"], additionalInfo: "Protector of ninja from unknown village"}
    ]
    readonly property var group2Items: [
        {name: "gas mask", type: "Head", defense: 2, rarity: "uncommon", buffName: ["stamina up", "blurry vision"], additionalInfo: "The lightweight gas mask protects your breath"},
        {name: "skull", type: "Head", defense: 1, rarity: "rare", buffName: ["metamorphosis"], additionalInfo: "Looks like a real animal skull"},
        {name: "headphones", type: "Head", defense: 1, rarity: "uncommon", buffName: ["audition"], additionalInfo: "Lost prototype of over-ear headphones"},
        {name: "night vision", type: "Head", defense: 1, rarity: "rare", buffName: ["night vision"], additionalInfo: "A device for night operations"},
        {name: "super gas mask", type: "Head", defense: 3, rarity: "rare", buffName: ["great stamina up", "infinite run stamina"], additionalInfo: "Improved version of the gas mask, also protects your breath"}
    ]

    readonly property var group3Items: [
        {name: "master mask", type: "Head", defense: 4, rarity: "common", buffName: ["true friends"], additionalInfo: "Leather mask of Ivan Chornozem. You're a great fighter"}
    ]
}
