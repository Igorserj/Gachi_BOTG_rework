import QtQuick 2.15

RoomView {
    readonly property var tiles: ["Assets/Floor_planks/Plank.png"]
    readonly property var walls: ["Assets/Bookshelves/Bookshelf.png"]
    property alias floor: floor

    room.source: "Assets/Wall/Wall.png"

    Column {
        id: wall
        anchors.bottom: floor.top
        Repeater {
            model: 7
            Row {
                id: row
                property int rowIndex: index
                Repeater {
                    model: 9
                    Image {
                        source: walls[(seed[(((row.rowIndex + 1) * (index + 1))) % seed.length] * (index + 1) * (row.rowIndex + 1)) % walls.length]
                        rotation: 180 * ((((row.rowIndex + 1) * (index + 1))) % 2)
                        width: loader.width / 9
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }

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
                x: index % 2 === 0 ? -loader.width / 16 : 0
                Repeater {
                    model: 9
                    Image {
                        source: tiles[(seed[(((row.rowIndex + 1) * (index + 1))) % seed.length] * (index + 1) * (row.rowIndex + 1)) % tiles.length]
                        rotation: 180 * ((((row.rowIndex + 1) * (index + 1))) % 2)
                        width: loader.width / 8
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }
}
