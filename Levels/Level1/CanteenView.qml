import QtQuick 2.15

RoomView {
    readonly property var tiles: ["Assets/Tile/Tile.png"]
    readonly property var wallTiles: ["Assets/Wall_tile/Tile.png"]
    readonly property var walls: ["Assets/Wall/Wall.png"]
    readonly property var fences: ["Assets/Fence/Fence.png"]
    property alias floor: floor

    room.source: walls[seed[0] % walls.length]

    Column {
        id: floor
        y: loader.height - childrenRect.height
        height: childrenRect.height
        width: childrenRect.width
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
        anchors.bottom: floor.top
        anchors.horizontalCenter: floor.horizontalCenter
        Repeater {
            model: 4
            Row {
                id: row
                property int rowIndex: index
                Repeater {
                    model: 5
                    Image {
                        source: wallTiles[(seed[(((row.rowIndex + 1) * (index + 1))) % seed.length] * (index + 1) * (row.rowIndex + 1)) % tiles.length]
                        rotation: 90 * ((((row.rowIndex + 1) * (index + 1))) % 4)
                        width: loader.width / 19
                        height: width
                        opacity: (index === 0 || index === 4) || (row.rowIndex === 0 || row.rowIndex === 3) ? 1 : 0
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }
}
