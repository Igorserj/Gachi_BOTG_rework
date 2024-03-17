import QtQuick 2.15

Corridor {
    onRoomIsReadyChanged: roomIsReady ? init() : {}

    function init() {
        const v = stairSeed()
        const stairs = [
                         {model: [], type: "up"},
                         {model: [], type: "down"}
                     ]
        const stairsPos = [
                            ["stair", loader.width / 2, floor.y + (25 * scaleCoeff), 0.25 * 1.627 * loader.width, 0.25 * loader.height],
                            ["stair", loader.width / 2, floor.y + floor.height - (35 * scaleCoeff), 0.25 * 1.627 * loader.width, 0.25 * loader.height]
                        ]
        stairs[0].model = v[0]
        stairs[1].model = v[1]
        objGen.objects = [[-100, 0, 100, loader.height], [loader.width, 0, 100, loader.height], [0, loader.height, loader.width, 100], [0, 0, loader.width, floor.y]
                ]
        const oldObjects = pobjGen.objects
        const oldMetadata = pobjGen.metadata
        pobjGen.objects = (currentRoom === "stairs" ? stairsPos :
                                                      currentRoom === "entrance" ? [stairsPos[0]] :
                                                                                   [stairsPos[1]]).concat(oldObjects)
        pobjGen.metadata = (currentRoom === "stairs" ? stairs : currentRoom === "entrance" ? [stairs[0]] : [stairs[1]]).concat(oldMetadata)
        entGen.objects = [["hero", opSave.level.hero.x, opSave.level.hero.y]
                ]
        entGen.metadata = [{}]
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
