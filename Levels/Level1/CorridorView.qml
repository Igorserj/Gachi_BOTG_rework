import QtQuick 2.15

RoomView {
    id: roomView
    property bool roomIsReady: wall.ready && floor.ready
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
        id: wall
        y: floor.y - childrenRect.height
        property bool ready: fenceRepeater.numberOfCreatedObjects / fenceRepeater.count === 1
        Repeater {
            id: fenceRepeater
            property int numberOfCreatedObjects: 0
            model: 11
            Image {
                source: fences[(seed[(index + 1) % seed.length] * index) % fences.length]
                width: loader.width / 11
                height: width
                fillMode: Image.PreserveAspectFit
            }
            onItemAdded: numberOfCreatedObjects++
        }
    }

    Column {
        id: floor
        x: 0
        y: loader.height - childrenRect.height
        height: childrenRect.height
        width: childrenRect.width
        property bool ready: tileRepeater.numberOfCreatedObjects / (5 * 19) === 1
        Repeater {
            id: tileRepeater
            model: 5
            property int numberOfCreatedObjects: 0
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
                    onItemAdded: tileRepeater.numberOfCreatedObjects++
                }
            }
        }
    }

    Row {
        id: wall2
        y: floor.y + floor.height - childrenRect.height
        z: itmGen.z + 1
        property bool ready: fenceRepeater2.numberOfCreatedObjects / fenceRepeater2.count === 1
        Repeater {
            id: fenceRepeater2
            property int numberOfCreatedObjects: 0
            model: 11
            Image {
                source: fences[(seed[(index + 1) % seed.length] * index) % fences.length]
                width: loader.width / 11
                height: width
                fillMode: Image.PreserveAspectFit
                opacity: (index > 2 && index < 8) && staircaseLayout.includes(currentRoom)/*pobjGen.objects.length === 4*/ ? 0 : 1//0.95
            }
            onItemAdded: numberOfCreatedObjects++
        }
    }
}
