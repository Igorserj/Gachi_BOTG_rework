import QtQuick 2.15
import ".."

RoomPattern {
    readonly property var tiles: ["Assets/Floor_planks/Plank.png"]
    property alias floor: floor
    room.source: "Assets/Wall/Wall.png"
    Column {
        id: floor
        y: roomLoader.height - childrenRect.height
        z: room.z
        Repeater {
            model: 4
            Row {
                id: row
                property int rowIndex: index
                x: index % 2 === 0 ? -roomLoader.width / 16 : 0
                Repeater {
                    model: 9
                    Image {
                        source: tiles[(seed[(((row.rowIndex + 1) * (index + 1))) % seed.length] * (index + 1) * (row.rowIndex + 1)) % tiles.length]
                        rotation: 180 * ((((row.rowIndex + 1) * (index + 1))) % 2)
                        width: roomLoader.width / 8
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }
}
