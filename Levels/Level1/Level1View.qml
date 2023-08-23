import QtQuick 2.15
import ".."

RoomPattern {
    room.source: "Assets/Room.png"
    objGen.objects: [[0, 0, 100, room.height], [room.width - 100, 0, 100, room.height], [0 + 100, room.height, room.width - 200, 100], [100, 0, room.width - 200, 300],
        [170, 320, 50, 50], [220, 370, 50, 50], [270, 420, 50, 50],
        [380, 320, 50, 50], [430, 370, 50, 50], [480, 420, 50, 50]
    ]
    entGen {
        objects: [["hero", 1000, 600], ["hostile", -300, -500], ["npc", 490, 470], ["interact", 1000, 350]]
        metadata: [
            { name: "Semen", hp: 110, equipment: ['Hat', 'Jacket', 'Jeans', 'Sneakers', '', 'Bat', '']/*, inventory: []*/},
            { name: "Xyi", hp: 10, money: 5, anotherRoom: true },
            { name: "Dude", hp: 10, money: 3 },
            { name: "bench", scenario: [["Semen", "I won't sit"],
                    ["Semen", 'The bench is broken'], ["script", "Semen dies", "test1"]]}]
    }
    itmGen {
        objects: [[350, 310, 10, 10], [350, 550, 10, 10], [530, 400, 10, 10]]
        metadata: [{name: "Super Vodka", type: "Consumable", isEquipment: false, additionalInfo: "This is super Vodka!", buffName: "StaminaUp", points: 35},
                   {name: "Mask", additionalInfo: "Maska tupa", buffName: "HealthUp", points: 10, type: "Head", isEquipment: true},
                   {name: "money", pcs: 10}]
    }
    pobjGen {
        objects: [["stair", loader.width / 2, loader.height / 2, 0.15 * loader.width, 0.1 * loader.height]]
        metadata: [{model: [
                "../../PhysicalObjects/Stairs/Stair1.png",
                "../../PhysicalObjects/Stairs/Stair2.png",
                "../../PhysicalObjects/Stairs/Stair3.png",
                "../../PhysicalObjects/Stairs/Stair4.png",
                "../../PhysicalObjects/Stairs/Stair5.png"], type: "upstairs"}]
    }
    function scripts(scriptName) {
        if (scriptName === "test1") {
            entGen.repeater.itemAt(1).item.health = 0
        }
    }
}
