import QtQuick 2.15

Rectangle {
    id: cell
    property string type: ""
    readonly property int currentIndex: parent.colIndex * 5 + index
    property bool isEquipment: itemList.equipmnets.includes(type)
    height: invInterface.height / 7
    width: height
    radius: width / 8
    clip: true

    Text {
        id: cellText
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: itemName()
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: !invItem.visible
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: showToolTip()
        onExited: toolTip.hide()
        onClicked: showContextMenu(mouseX, mouseY, mouse.button)
    }

    function optionChoose() {
        var text = cellText.text
        if (text !== "") {
            if (itemList.items[itemList.itemNames.indexOf(text)].isEquipment) {
                return ["Move", "Equip", "Drop"]
            }
            else return ["Move", "Use", "Drop"]
        }
        return [""]
    }
    function itemName() {
        if (isEquipment) return equipmentCells[currentIndex]
        else return inventoryCells[currentIndex]
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

    function showToolTip() {
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
    function showContextMenu(mouseX, mouseY, button) {
        if (button === Qt.RightButton && contextMenu.opacity === 0 && cellText.text !== "") {
            contextMenu.obj = cell
            contextMenu.objects = optionChoose()
            if (isEquipment) contextMenu.show(cell.x + equipRow.x + mouseX, equipRow.y + mouseY)
            else contextMenu.show(cell.x + parent.x + col.x + mouseX, parent.y + col.y + mouseY)
        }
        else contextMenu.hide()

        if (invItem.visible) {
            var entityInv = levelLoader.item.entGen.repeater.itemAt(0).item.inventory
            if (isEquipment && itemList.items[itemList.itemNames.indexOf(invItem.itemName)].type === type) {
//                console.log(type, itemList.equipmnets[currentIndex])
                if (invItem.isEquipment) entityInv.equipmentCells[invItem.index] = cellText.text
                else entityInv.inventoryCells[invItem.index] = cellText.text
                entityInv.equipmentCells[currentIndex] = invItem.itemName
                unMoveItem()
                interfaceLoader.item.inventoryCells = entityInv.inventoryCells
                interfaceLoader.item.equipmentCells = entityInv.equipmentCells
                entityInv.activeItems()
            }
            else if (!isEquipment) {
                if (invItem.isEquipment) entityInv.equipmentCells[invItem.index] = cellText.text
                else entityInv.inventoryCells[invItem.index] = cellText.text
                entityInv.inventoryCells[currentIndex] = invItem.itemName
                unMoveItem()
                interfaceLoader.item.inventoryCells = entityInv.inventoryCells
                interfaceLoader.item.equipmentCells = entityInv.equipmentCells
                entityInv.activeItems()
            }
        }
    }
}
