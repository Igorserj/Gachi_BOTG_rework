import QtQuick 2.15
import ".."

LevelPattern {
    room.source: "Assets/Room.png"
    objGen.objects: [[0, 0, 100, room.height], [room.width - 100, 0, 100, room.height], [0 + 100, room.height, room.width - 200, 100], [100, 0, room.width - 200, 300],
        [170, 320, 50, 50], [220, 370, 50, 50], [270, 420, 50, 50],
        [380, 320, 50, 50], [430, 370, 50, 50], [480, 420, 50, 50]
    ]
    entGen {
        objects: [["hero", 1000, 600], ["hostile", 300, 500], ["npc", 490, 470], ["interact", 1000, 350]/*, ["hostile", 350, 500], ["hostile", 250, 500], ["hostile", 300, 400], ["hostile", 250, 400]*/]
        metadata: [{name: "Semen", hp: 110, equipment: ['Hat', 'Jacket', 'Jeans', 'Sneakers', '', 'Bat', '']/*, inventory: []*/}, {name: "Xyi", hp: 10, money: 5}, {name: "Dude", hp: 10, money: 3}, {name: "bench"}]
    }
    itmGen {
        objects: [[350, 310, 10, 10], [350, 550, 10, 10], [530, 400, 10, 10]]
        metadata: [{name: "Super Vodka", type: "Consumable", isEquipment: false, additionalInfo: "This is super Vodka!", buffName: "StaminaUp", points: 35},
                   {name: "Mask", additionalInfo: "Maska tupa", buffName: "HealthUp", points: 10, type: "Head", isEquipment: true},
                   {name: "money", pcs: 10}]
    }
}
