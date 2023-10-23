import QtQuick 2.15

CorridorView {
    objGen.objects: [[-100, 0, 100, room.height], [room.width, 0, 100, room.height], [0, room.height, room.width, 100], [0, 0, room.width, floor.y]
    ]
    entGen {
        objects: [["hero", loader.width / 2, floor.y + floor.height / 2]]
        metadata: [
            { name: "Semen" }]
    }

    pobjGen {
        objects: currentRoom === "stairs" ? [["stair", loader.width / 2, floor.y, 0.25 * 1.627 * loader.width, 0.25 * loader.height], ["stair", loader.width / 2, room.height - 0.25 * loader.height, 0.25 * 1.627 * loader.width, 0.25 * loader.height]] :
                                            currentRoom === "entrance" ? [["stair", loader.width / 2, floor.y, 0.25 * 1.627 * loader.width, 0.25 * loader.height]] :
                                                                         [["stair", loader.width / 2, room.height - 0.25 * loader.height, 0.25 * 1.627 * loader.width, 0.25 * loader.height]]
        metadata: currentRoom === "stairs" ?
                      [{model: [
                               "../../PhysicalObjects/Stairs/Stair1.png",
                               "../../PhysicalObjects/Stairs/Stair2.png",
                               "../../PhysicalObjects/Stairs/Stair3.png",
                               "../../PhysicalObjects/Stairs/Stair4.png",
                               "../../PhysicalObjects/Stairs/Stair5.png"], type: "upstairs"},
                       {model: [
                               "../../PhysicalObjects/Stairs/Stair1.png",
                               "../../PhysicalObjects/Stairs/Stair2.png",
                               "../../PhysicalObjects/Stairs/Stair3.png",
                               "../../PhysicalObjects/Stairs/Stair4.png",
                               "../../PhysicalObjects/Stairs/Stair5.png"], type: "downstairs"}
                      ] : currentRoom === "entrance" ?
                          [{model: [
                                   "../../PhysicalObjects/Stairs/Stair1.png",
                                   "../../PhysicalObjects/Stairs/Stair2.png",
                                   "../../PhysicalObjects/Stairs/Stair3.png",
                                   "../../PhysicalObjects/Stairs/Stair4.png",
                                   "../../PhysicalObjects/Stairs/Stair5.png"], type: "upstairs"}
                          ] :
                          [{model: [
                                   "../../PhysicalObjects/Stairs/Stair1.png",
                                   "../../PhysicalObjects/Stairs/Stair2.png",
                                   "../../PhysicalObjects/Stairs/Stair3.png",
                                   "../../PhysicalObjects/Stairs/Stair4.png",
                                   "../../PhysicalObjects/Stairs/Stair5.png"], type: "downstairs"}
                          ]
    }
}
