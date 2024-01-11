import QtQuick 2.15
import ".."

RoomPattern {
    id: wc
    readonly property var tiles: ["Assets/Tile/Tile.png"/*, "Assets/Tile/Tile2.png", "Assets/Tile/Tile3.png", "Assets/Tile/Tile4.png",
        "Assets/Tile/Tile5.png", "Assets/Tile/Tile6.png", "Assets/Tile/Tile7.png", "Assets/Tile/Tile8.png", "Assets/Tile/Tile9.png",
        "Assets/Tile/Tile10.png"*/
    ]
    readonly property var walls: [
        "Assets/Wall_tile/Tile.png"/*, "Assets/Wall_tile/Tile2.png", "Assets/Wall_tile/Tile3.png", "Assets/Wall_tile/Tile4.png", "Assets/Wall_tile/Tile5.png",
        "Assets/Wall_tile/Tile6.png", "Assets/Wall_tile/Tile7.png", "Assets/Wall_tile/Tile8.png", "Assets/Wall_tile/Tile9.png", "Assets/Wall_tile/Tile10.png"*/
    ]
    property string type: "wc1"
    property alias floor: floor
    property alias wall: wall

    room.source: "Assets/Wall/Wall.png"

    Tiles {
        y: floor.y - childrenRect.height
        rows: 13
        columns: 36
    }

    Column {
        id: floor
        height: childrenRect.height
        width: childrenRect.width
        y: loader.height - childrenRect.height
        Repeater {
            model: 4
            Row {
                id: row
                property int rowIndex: index
                Repeater {
                    model: 19
                    Image {
                        source: tiles[(seed[(((row.rowIndex + 1) * (index + 1))) % seed.length] * (index + 1) * (row.rowIndex + 1)) % tiles.length]
                        rotation: 90 * ((((row.rowIndex + 1) * (index + 1))) % 4)
                        width: loader.width / 19
                        height: width
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }

    Tiles {
        id: wall
        y: floor.y
        x: loader.width / 4
        rows: 4
        columns: 2
    }

    Image {
        id: sink
        source: "Assets/Sink.png"
        fillMode: Image.PreserveAspectFit
        width: loader.width / 7.4
        x: (loader.width / 4 - width) / 2
        y: floor.y - height * 1.2
    }

    Mirror {
        anchors.horizontalCenter: sink.horizontalCenter
        anchors.bottom: sink.top
    }

    Image {
        source: "Assets/Urinal.png"
        fillMode: Image.PreserveAspectFit
        visible: type === "wc1"
        width: loader.width / 12
        x: loader.width / 4 + 0.16 * (loader.width - loader.width / 4) - width / 2
        y: floor.y - height * 1.3
    }
    Image {
        source: "Assets/Urinal.png"
        fillMode: Image.PreserveAspectFit
        visible: type === "wc1"
        width: loader.width / 12
        x: loader.width / 4 + 0.49 * (loader.width - loader.width / 4) - width / 2
        y: floor.y - height * 1.3
    }
    Image {
        source: "Assets/Urinal.png"
        fillMode: Image.PreserveAspectFit
        visible: type === "wc1"
        width: loader.width / 12
        x: loader.width / 4 + 0.82 * (loader.width - loader.width / 4) - width / 2
        y: floor.y - height * 1.3
    }

    Row {
        opacity: 1 / 2.75
        x: wall.x + wall.width
        y: loader.height - childrenRect.height
        z: itmGen.z + 1
        Repeater {
            model: 3
            Row {
                height: door.height
                clip: true
                Tiles {
                    rows: Math.round(door.height / (loader.width / 36)) + 1
                    columns: index === 0 ? 2 : 1
                }
                Image {
                    id: door
                    source: "Assets/Door.png"
                    fillMode: Image.PreserveAspectFit
                    width: loader.width / 6
                }
                Tiles {
                    rows: Math.round(door.height / (loader.width / 36)) + 1
                    columns: 1
                }
            }
        }
    }
}
