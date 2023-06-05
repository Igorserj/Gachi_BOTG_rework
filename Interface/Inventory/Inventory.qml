import QtQuick 2.15

Rectangle {
    id: invInterface
    property var inventoryCells: []
    property var equipmentCells: []
    readonly property var equipments: ["One Hand", "Two Hands", "Head", "Body", "Legs"]
    readonly property var options: ["Move", "Drop"]
    width: parent.width * 0.8
    height: parent.height * 0.8
    color: "#99363636"
    MouseArea {
        id: inventoryArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: false
    }
    Column {
        id: col
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5
        Repeater {
            model: Math.ceil(inventoryCells.length / 5)
            Row {
                id: row
                property int colIndex: index
                spacing: 5
                Repeater {
                    id: repeater
                    model: inventoryCells.length - index * 5 > 5 ? 5 : inventoryCells.length - index * 5
                    InventoryCell {}
                }
            }
        }
    }
    Row {
        id: equipRow
        property int colIndex: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 5
        Repeater {
            model: equipmentCells
            InventoryCell {
                type: equipments[index]
            }
        }
    }
    Rectangle {
        id: invItem
        visible: inventoryArea.enabled
        height: invInterface.height / 7
        width: height
        radius: width / 8
        color: "#DD363436"
        x: inventoryArea.mouseX
        y: inventoryArea.mouseY
    }
}
