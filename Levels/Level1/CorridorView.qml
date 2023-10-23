import QtQuick 2.15

RoomView {
    readonly property var tiles: ["Assets/Tile/Tile.png"/*, "Assets/Tile/Tile2.png", "Assets/Tile/Tile3.png", "Assets/Tile/Tile4.png",
        "Assets/Tile/Tile5.png", "Assets/Tile/Tile6.png", "Assets/Tile/Tile7.png", "Assets/Tile/Tile8.png", "Assets/Tile/Tile9.png",
        "Assets/Tile/Tile10.png"*/
    ]
    readonly property var fences: ["Assets/Fence/Fence.png"/*, "Assets/Fence/Fence2.png", "Assets/Fence/Fence3.png", "Assets/Fence/Fence4.png",
        "Assets/Fence/Fence5.png", "Assets/Fence/Fence6.png", "Assets/Fence/Fence7.png", "Assets/Fence/Fence8.png", "Assets/Fence/Fence9.png",
        "Assets/Fence/Fence10.png"*/
    ]
    readonly property var walls: ["Assets/Wall/Wall.png"/*, "Assets/Wall/Wall2.png", "Assets/Wall/Wall3.png", "Assets/Wall/Wall4.png",
        "Assets/Wall/Wall5.png", "Assets/Wall/Wall6.png", "Assets/Wall/Wall7.png", "Assets/Wall/Wall8.png", "Assets/Wall/Wall9.png",
        "Assets/Wall/Wall10.png"*/
    ]
    property alias floor: floor

    room.source: walls[seed[0] % walls.length]

    Row {
        y: floor.y - childrenRect.height
        Repeater {
            model: 11
            Image {
                source: fences[(seed[(index + 1) % seed.length] * index) % fences.length]
                width: loader.width / 11
                height: width
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Column {
        id: floor
        y: loader.height - childrenRect.height
        Repeater {
            model: 5
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
}
