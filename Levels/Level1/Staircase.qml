import QtQuick 2.15

CorridorView {
    onRoomIsReadyChanged: roomIsReady ? init() : {}
    readonly property var stairs: [
        {model: [
                "../../PhysicalObjects/Stairs/Stair1.png",
                "../../PhysicalObjects/Stairs/Stair2.png",
                "../../PhysicalObjects/Stairs/Stair3.png",
                "../../PhysicalObjects/Stairs/Stair4.png",
                "../../PhysicalObjects/Stairs/Stair5.png"], type: "up"},
        {model: [
                "../../PhysicalObjects/Stairs/Stair1.png",
                "../../PhysicalObjects/Stairs/Stair2.png",
                "../../PhysicalObjects/Stairs/Stair3.png",
                "../../PhysicalObjects/Stairs/Stair4.png",
                "../../PhysicalObjects/Stairs/Stair5.png"], type: "down"}
    ]
    readonly property var passes: [
        {type: "left"},
        {type: "right"}
    ]

    function init() {
        objGen.objects = [[-100, 0, 100, loader.height], [loader.width, 0, 100, loader.height], [0, loader.height, loader.width, 100], [0, 0, loader.width, floor.y]
                ]
        pobjGen.objects = (currentRoom === "stairs" ? [["stair", loader.width / 2, floor.y, 0.25 * 1.627 * loader.width, 0.25 * loader.height], ["stair", loader.width / 2, loader.height - 0.25 * loader.height, 0.25 * 1.627 * loader.width, 0.25 * loader.height]] :
                                                      currentRoom === "entrance" ? [["stair", loader.width / 2, floor.y, 0.25 * 1.627 * loader.width, 0.25 * loader.height]] :
                                                                                   [["stair", loader.width / 2, loader.height - 0.25 * loader.height, 0.25 * 1.627 * loader.width, 0.25 * loader.height]]).concat(position === 0 ? [["pass", floor.x + floor.width - 10, floor.y, 10, floor.height]] : position === 5 ? [["pass", floor.x, floor.y, 10, floor.height]] : [["pass", floor.x, floor.y, 10, floor.height], ["pass", floor.x + floor.width - 10, floor.y, 10, floor.height]])
        pobjGen.metadata = (currentRoom === "stairs" ? stairs : currentRoom === "entrance" ? [stairs[0]] : [stairs[1]]).concat(position === 0 ? [passes[1]] : position === 5 ? [passes[0]] : passes)
        entGen.objects = [["hero", loader.width / 2, floor.y + floor.height / 2]]
        entGen.metadata = [{ name: "Semen" }]
    }
}
