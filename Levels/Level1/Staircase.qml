import QtQuick 2.15

CorridorView {
    onRoomIsReadyChanged: roomIsReady ? init() : {}
    readonly property var stairs: [
        {model: [], type: "up"},
        {model: [], type: "down"}
    ]
    readonly property var passes: [
        {type: "left"},
        {type: "right"}
    ]

    function init() {
        const v = stairSeed()
        stairs[0].model = v[0]
        stairs[1].model = v[1]
        objGen.objects = [[-100, 0, 100, loader.height], [loader.width, 0, 100, loader.height], [0, loader.height, loader.width, 100], [0, 0, loader.width, floor.y]
                ]
        pobjGen.objects = (currentRoom === "stairs" ? [["stair", loader.width / 2, floor.y, 0.25 * 1.627 * loader.width, 0.25 * loader.height], ["stair", loader.width / 2, floor.y + floor.height - 10/*loader.height - 0.25 * loader.height*/, 0.25 * 1.627 * loader.width, 0.25 * loader.height]] :
                                                      currentRoom === "entrance" ? [["stair", loader.width / 2, floor.y, 0.25 * 1.627 * loader.width, 0.25 * loader.height]] :
                                                                                   [["stair", loader.width / 2, floor.y + floor.height - 10/*loader.height - 0.25 * loader.height*/, 0.25 * 1.627 * loader.width, 0.25 * loader.height]]).concat(position === 0 ? [["pass", floor.x + floor.width - 10, floor.y, 10, floor.height]] : position === 5 ? [["pass", floor.x, floor.y, 10, floor.height]] : [["pass", floor.x, floor.y, 10, floor.height], ["pass", floor.x + floor.width - 10, floor.y, 10, floor.height]])
        pobjGen.metadata = (currentRoom === "stairs" ? stairs : currentRoom === "entrance" ? [stairs[0]] : [stairs[1]]).concat(position === 0 ? [passes[1]] : position === 5 ? [passes[0]] : passes)
        entGen.objects = [["hero", loader.width / 2, floor.y + floor.height / 2]]
        entGen.metadata = [{ name: "Semen" }]

        itmGen.objects = [[350, 600, 10, 10], [350, 550, 10, 10], [530, 600, 10, 10]]
        itmGen.metadata = [{name: "Super Vodka", type: "Consumable", isEquipment: false, additionalInfo: "This is super Vodka!", buffName: "StaminaUp", points: 35},
                   {name: "Mask", additionalInfo: "Maska tupa", buffName: "HealthUp", points: 10, type: "Head", isEquipment: true},
                   {name: "money", pcs: 10}]
    }

    function stairSeed() {
        const model = ["../../PhysicalObjects/Stairs/Stair1.png",
                       "../../PhysicalObjects/Stairs/Stair2.png",
                       "../../PhysicalObjects/Stairs/Stair3.png",
                       "../../PhysicalObjects/Stairs/Stair4.png",
                       "../../PhysicalObjects/Stairs/Stair5.png",
                       "../../PhysicalObjects/Stairs/Stair6.png",
                       "../../PhysicalObjects/Stairs/Stair7.png",
                       "../../PhysicalObjects/Stairs/Stair8.png",
                       "../../PhysicalObjects/Stairs/Stair9.png",
                       "../../PhysicalObjects/Stairs/Stair10.png"
                    ]
        let upstairs = []
        let downstairs = []
        let k = []
        let k2 = []
        for (let i = 0; i < 5; i++) {
            k = (Math.abs(seed[i] - seed[i + 1]) * Math.cos((corridorShift[loader.item.floor] + loader.item.floor) / Math.PI)).toString()
            k2 = (seed[i] + seed[i + 1] * Math.cos((corridorShift[loader.item.floor] - loader.item.floor) / Math.PI)).toString()
            upstairs.push(model[k[k.length - 1]])
            downstairs.push(model[k2[k2.length - 1]])
        }
        return [upstairs, downstairs]
    }
}
