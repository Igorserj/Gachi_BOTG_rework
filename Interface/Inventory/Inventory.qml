import QtQuick 2.15
import "../../Controls"

Item {
    property var inventoryCells: []
    property var equipmentCells: []
    property alias invInterface: invInterface
    MouseArea {
        id: inventoryArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: true
        onClicked: contextMenu.hide()
    }
    Rectangle {
        id: invInterface
        color: style.blackGlass
        width: parent.width * 0.225
        height: parent.height * 0.45
        anchors.bottom: equipPanel.bottom
        x: heroEntity === usedByEntity ? 0 : equipPanel.width
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            Rectangle {
                width: parent.width
                height: invInterface.height / 7
                color: "transparent"
                Text {
                    text: usedByEntity.name
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit
                    font.pointSize: 100
                    color: "white"
                }
            }
            Column {
                id: col
                anchors.horizontalCenter: parent.horizontalCenter
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
            Button1 {
                id: button
                anchors.horizontalCenter: col.horizontalCenter
                enabled: (usedByEntity !== heroEntity && usedByEntity.money > 0)
                height: invInterface.height / 7
                width: height
                text: usedByEntity !== undefined ? "$" + usedByEntity.money : "$0"
                buttonArea.onClicked: { heroEntity.money += usedByEntity.money; usedByEntity.money = 0 }
            }
        }
        function update() {
            ifaceLoader.item.interfaceLoader.item.usedByEntity = usedByEntity
        }
    }
    Rectangle {
        id: equipPanel
        anchors.bottom: parent.bottom
        x: heroEntity === usedByEntity ? invInterface.width : 0
        height: invInterface.height / 6
        width: parent.width - invInterface.width
        color: style.blackGlass
        Row {
            id: equipRow
            property int colIndex: 0
            x: -parent.x + (parent.parent.width - width) / 2
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            Repeater {
                model: usedByEntity !== undefined ? usedByEntity.inventory.equipmentCells : 0
                InventoryCell {
                    type: itemList.equipments[index]
                }
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
            invInterface.update()
        }
        function actionSet2(index) {
            if (index === 0) {obj.cl.moveItem()}
            else if (index === 1) {obj.cl.equipItem()}
            else if (index === 2) {obj.cl.dropItem()}
            else if (index === 3) {obj.cl.destroyItem()}
            invInterface.update()
        }
        function actionSet3(index) {
            if (index === 0) {obj.cl.moveItem()}
            else if (index === 1) {obj.cl.unEquipItem()}
            invInterface.update()
        }

        function actionSet4(index) {
            if (index === 0) {obj.cl.lootItem()}
            else if (index === 1) {obj.cl.moveItem()}
            else if (index === 2) {obj.cl.destroyItem()}
            invInterface.update()
        }
    }
    InventoryItem {
        id: invItem
    }
    Styles {
        id: style
    }
    Connections {
        target: entGen.repeater.itemAt(0)
        function onXChanged() {
            if (usedByEntity !== heroEntity)
                closeInventory()
        }
        function onYChanged() {
            if (usedByEntity !== heroEntity)
                closeInventory()
        }
    }
}
