import QtQuick 2.15
import "../../Controls"

Rectangle {
    id: invInterface
    property var inventoryCells: []
    property var equipmentCells: []
    property var usedByEntity
    property var heroEntity
    width: parent.width * 0.8
    height: parent.height * 0.8
    color: style.blackGlass
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
            model: usedByEntity !== undefined ? Math.ceil(usedByEntity.inventory.inventoryCells.length / 5) : 0
            Row {
                id: row
                property int colIndex: index
                spacing: 5
                Repeater {
                    id: repeater
                    model: usedByEntity.inventory.inventoryCells.length - index * 5 > 5 ? 5 : usedByEntity.inventory.inventoryCells.length - index * 5
                    InventoryCell {
                        id: invCell
                    }
                }
            }
        }
    }
    Rectangle {
        anchors.top: col.bottom
        anchors.right: col.right
        width: col.width
        height: equipRow.y - (col.y + col.height)
        color: "transparent"
        Text {
            id: name
            text: usedByEntity !== undefined ? "$" + usedByEntity.money : "$0"
            height: parent.height
            width: parent.width
            horizontalAlignment: Text.AlignRight
            font.pointSize: 72
            fontSizeMode: Text.VerticalFit
            font.family: comfortaaName
            color: "white"
        }
    }
    Row {
        id: equipRow
        property int colIndex: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 5
        Repeater {
            model: usedByEntity !== undefined ? usedByEntity.inventory.equipmentCells : 0
            InventoryCell {
                type: itemList.equipmnets[index]
            }
        }
    }
    ContextMenu {
        id: contextMenu
        opacity: 0
        function actionSet(index) {
            if (set === 0) {
                actionSet1(index) }
            else if (set === 1) {
                actionSet2(index)
            }
            else if (set === 2) {
                actionSet3(index)
            }
            else if (set === 3) {
                actionSet4(index)
            }
        }

        function actionSet1(index) {
            if (index === 0) {obj.cl.moveItem()}
            else if (index === 1) {obj.cl.useItem()}
            else if (index === 2) {obj.cl.dropItem()}
            else if (index === 3) {obj.cl.destroyItem()}
            update()
        }
        function actionSet2(index) {
            if (index === 0) {obj.cl.moveItem()}
            else if (index === 1) {obj.cl.equipItem()}
            else if (index === 2) {obj.cl.dropItem()}
            else if (index === 3) {obj.cl.destroyItem()}
            update()
        }
        function actionSet3(index) {
            if (index === 0) {obj.cl.moveItem()}
            else if (index === 1) {obj.cl.unEquipItem()}
            update()
        }

        function actionSet4(index) {
            if (index === 0) {obj.cl.lootItem()}
            else if (index === 1) {obj.cl.moveItem()}
            else if (index === 2) {obj.cl.destroyItem()}
            update()
        }
    }
    InventoryItem {
        id: invItem
    }
    Styles {
        id: style
    }
    function update() {
        ifaceLoader.item.interfaceLoader.item.usedByEntity = usedByEntity
    }
}
