import QtQuick 2.15

Rectangle {
    id: cell
    property string type: ""
    readonly property int currentIndex: parent.colIndex * 5 + index
    property bool isEquipment: itemList.types.includes(type)
    height: invInterface.height / 7
    width: height
    radius: width / 8
    clip: true
    Text {
        id: cellText
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (isEquipment) equipmentCells[currentIndex]
            else inventoryCells[currentIndex]
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: !invItem.visible
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: {
            var cells = cellText.text
            if (isEquipment) {
                if (cells !== "") {
                    const i = itemList.itemNames.indexOf(cells)
                    toolTip.mainText = itemList.items[i].name
                    toolTip.addText = itemList.items[i].additionalInfo
                    toolTip.show(cell.x + cell.width + equipRow.x, equipRow.y)
                }
            }
            else {
                if (cells !== "") {
                    const i = itemList.itemNames.indexOf(cells)
                    toolTip.mainText = itemList.items[i].name
                    toolTip.addText = itemList.items[i].additionalInfo
                    toolTip.show(cell.x + cell.width + col.x, row.y + col.y)
                }
            }
        }
        onExited: toolTip.hide()
        onClicked: {
            if (mouse.button === Qt.RightButton && contextMenu.opacity === 0 && cellText.text !== "") {
                contextMenu.obj = cell
                contextMenu.objects = options
                if (isEquipment) contextMenu.show(cell.x + equipRow.x + mouseX, equipRow.y + mouseY)
                else contextMenu.show(cell.x + parent.parent.x + col.x + mouseX, parent.parent.y + col.y + mouseY)
            }
            else contextMenu.hide()

            if (invItem.visible) {
                var entityInv = levelLoader.item.entGen.repeater.itemAt(0).item.inventory
                if (isEquipment) {
                    if (invItem.isEquipment) entityInv.equipmentCells[invItem.index] = cellText.text
                    else entityInv.inventoryCells[invItem.index] = cellText.text
                    entityInv.equipmentCells[currentIndex] = invItem.itemName
                    unMoveItem()
                    interfaceLoader.item.inventoryCells = entityInv.inventoryCells
                    interfaceLoader.item.equipmentCells = entityInv.equipmentCells
                }
                else {
                    if (invItem.isEquipment) entityInv.equipmentCells[invItem.index] = cellText.text
                    else entityInv.inventoryCells[invItem.index] = cellText.text
                    entityInv.inventoryCells[currentIndex] = invItem.itemName
                    unMoveItem()
                    interfaceLoader.item.inventoryCells = entityInv.inventoryCells
                    interfaceLoader.item.equipmentCells = entityInv.equipmentCells
                }
            }
        }
    }

    function unMoveItem() {
        invItem.itemName = ""
        invItem.index = -1
        invItem.isEquipment = false
        inventoryArea.enabled = false
    }
    function moveItem() {
        invItem.itemName = cellText.text
        invItem.index = currentIndex
        invItem.isEquipment = isEquipment
        inventoryArea.enabled = true
    }
    function useItem() {
        const i = itemList.itemNames.indexOf(cellText.text)
        itemList.items[i].usedByEntity = invInterface.usedByEntity
        itemList.items[i].use()
        dropItem()
    }

    function dropItem() {
        var entityInv = levelLoader.item.entGen.repeater.itemAt(0).item.inventory
        if (isEquipment) {
            entityInv.equipmentCells[currentIndex] = ''
            interfaceLoader.item.equipmentCells = entityInv.equipmentCells
        }
        else {
            entityInv.inventoryCells[currentIndex] = ''
            interfaceLoader.item.inventoryCells = entityInv.inventoryCells
        }

    }
}
