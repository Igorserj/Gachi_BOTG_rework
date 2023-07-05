import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../../Controls"

Rectangle {
    id: cell
    property string type: ""
    readonly property int currentIndex: parent.colIndex * 5 + index
    property bool isEquipment: itemList.equipmnets.includes(type)
    height: invInterface.height / 7
    width: height
    radius: width / 8
    clip: true
    color: "#9E9E9E"
    Rectangle {
        id: frontRect
        width: parent.width * 0.9
        height: parent.height * 0.9
        anchors.centerIn: parent
        radius: width / 8
        visible: false
        color: style.darkGlass
    }
    FastBlur {
        anchors.fill: frontRect
        source: frontRect
        radius: 32
        transparentBorder: true
    }

    Text {
        id: cellText
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        text: itemName()
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: !invItem.visible
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: showToolTip()
        onExited: toolTip.hide()
        onClicked: showContextMenu(mouseX, mouseY, mouse.button)
        onHoverEnabledChanged: if (!hoverEnabled) toolTip.hide()
    }

    Styles {
        id: style
    }

    function optionChoose() {
        var text = cellText.text
        if (text !== "") {
            if (itemList.itemNames.includes(text)) {
                if (type === itemList.items[itemList.itemNames.indexOf(text)].type) {
                    contextMenu.set = 2
                    return locale.inventoryCellOptions[2]
                }
                else if (itemList.items[itemList.itemNames.indexOf(text)].isEquipment) {
                    contextMenu.set = 1
                    return locale.inventoryCellOptions[1]
                }
                else if (!itemList.items[itemList.itemNames.indexOf(text)].isEquipment) {
                    contextMenu.set = 0
                    return locale.inventoryCellOptions[0]
                }
            }
            else {
                var entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
                var itemType
                var itemIsEquipment
                if (isEquipment) {
                    itemType = entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex].type
                    itemIsEquipment = entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex].isEquipment
                }
                else {
                    itemType = entityInv.metadataCells[currentIndex].type
                    itemIsEquipment = entityInv.metadataCells[currentIndex].isEquipment
                }
                if (type === itemType) {
                    contextMenu.set = 2
                    return locale.inventoryCellOptions[2]
                }
                else if (itemIsEquipment) {
                    contextMenu.set = 1
                    return locale.inventoryCellOptions[1]
                }
                else if (!itemIsEquipment) {
                    contextMenu.set = 0
                    return locale.inventoryCellOptions[0]
                }
            }
//            update()
        }
        return [""]
    }
    function itemName() {
        var entityInv = usedByEntity.inventory
        if (isEquipment) return entityInv.equipmentCells[currentIndex]
        else return entityInv.inventoryCells[currentIndex]
    }

    function unMoveItem() {
        invItem.itemName = ""
        invItem.index = -1
        invItem.isEquipment = false
        invItem.metadata = {}
        inventoryArea.enabled = false
    }
    function moveItem() {
        invItem.itemName = cellText.text
        invItem.index = currentIndex
        invItem.isEquipment = isEquipment
        invItem.metadata = usedByEntity.inventory.metadataCells[currentIndex]//levelLoader.item.entGen.repeater.itemAt(0).item.inventory.metadataCells[currentIndex]
        inventoryArea.enabled = true
    }
    function useItem() {
        var cells = cellText.text
        if (itemList.itemNames.includes(cells)) {
            const i = itemList.itemNames.indexOf(cells)
            itemList.items[i].usedByEntity = invInterface.usedByEntity
            itemList.items[i].use()
        }
        else {
            let entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
//            itemList.customItem.usedByEntity = invInterface.usedByEntity
//            itemList.customItem.buffName = entityInv.metadataCells[currentIndex].buffName
//            itemList.customItem.points = entityInv.metadataCells[currentIndex].points
//            itemList.customItem.use()
//            itemList.customItem.usedByEntity = undefined
//            itemList.customItem.buffName = ""
            console.log("act4")
//            let items = itemList.customItem.model
//            items.push({buffName: entityInv.metadataCells[currentIndex].buffName, points: entityInv.metadataCells[currentIndex].points, usedByEntity: invInterface.usedByEntity, action: "use"})
//            itemList.customItem.model = items
            itemList.customItem.pool.push({buffName: entityInv.metadataCells[currentIndex].buffName, points: entityInv.metadataCells[currentIndex].points, usedByEntity: invInterface.usedByEntity, action: "use"})
            itemList.customItem.modelUpdate()
        }
        destroyItem()
    }
    function equipItem() {
        var entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
        for (let i = 0; i < entityInv.equipmentCells.length; i++) {
            if (itemList.itemNames.indexOf(cellText.text) !== -1) {
                if (itemList.items[itemList.itemNames.indexOf(cellText.text)].type === itemList.equipmnets[i]) {
                    invItem.index = i
                    invItem.isEquipment = true
                    invItem.itemName = entityInv.equipmentCells[i]
                }
            }
            else {
                if (entityInv.metadataCells[currentIndex].type === itemList.equipmnets[i]) {
                    invItem.index = i
                    invItem.isEquipment = true
                    invItem.itemName = entityInv.equipmentCells[i]
                    invItem.metadata = entityInv.metadataCells[entityInv.inventoryCells.length + i]
                }
            }
        }
        invItem.itemName2 = cellText.text
        inventoryArea.enabled = true
        swapCells()
    }
    function unEquipItem() {
        var entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
        let i = entityInv.inventoryCells.indexOf('')
        inventoryArea.enabled = true
        entityInv.equipmentCells[currentIndex] = entityInv.inventoryCells[i]
        let localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex]
        entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex] = entityInv.metadataCells[i]
        entityInv.metadataCells[i] = localMeta
        entityInv.inventoryCells[i] = cellText.text
        unMoveItem()
        interfaceLoader.item.inventoryCells = entityInv.inventoryCells
        interfaceLoader.item.equipmentCells = entityInv.equipmentCells
        invInterface.update()
        entityInv.activeArmor()
    }

    function destroyItem() {
        var entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
        if (!isEquipment) {
            entityInv.inventoryCells[currentIndex] = ''
            entityInv.metadataCells[currentIndex] = {}
            interfaceLoader.item.inventoryCells = entityInv.inventoryCells
        }
        invInterface.update()
    }

    function dropItem() {
        var entity = usedByEntity.parent//levelLoader.item.entGen.repeater.itemAt(0)
        if (!isEquipment) {
            if (entity.item.facingRight === true) {
                levelLoader.item.itmGen.objects.push([entity.x + entity.item.width + 20, entity.y + entity.item.height - 10, 10, 10])
            }
            else {
                levelLoader.item.itmGen.objects.push([entity.x - 20, entity.y + entity.item.height - 10, 10, 10])
            }
            if (entity.item.inventory.metadataCells[currentIndex].name === undefined) {
                levelLoader.item.itmGen.metadata.push({name: entity.item.inventory.inventoryCells[currentIndex]})
            }
            else {
                levelLoader.item.itmGen.metadata.push(entity.item.inventory.metadataCells[currentIndex])
            }
            levelLoader.item.itmGen.repeater.model = levelLoader.item.itmGen.objects
            destroyItem()
//            entityInv.inventoryCells[currentIndex] = ''
//            entityInv.metadataCells[currentIndex] = {}
//            interfaceLoader.item.inventoryCells = entityInv.inventoryCells
        }
    }

    function showToolTip() {
        var cells = cellText.text
        if (isEquipment) {
            if (cells !== "") {
                if (itemList.itemNames.includes(cells)) {
                    const i = itemList.itemNames.indexOf(cells)
                    toolTip.mainText = itemList.items[i].name
                    toolTip.addText = itemList.items[i].additionalInfo
                    toolTip.show(cell.x + cell.width + equipRow.x, equipRow.y)
                }
                else {
                    let entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
                    toolTip.mainText = cells
                    toolTip.addText = entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex].additionalInfo
                    toolTip.show(cell.x + cell.width + equipRow.x, equipRow.y)
                }
            }
        }
        else {
            if (cells !== "") {
                if (itemList.itemNames.includes(cells)) {
                    const i = itemList.itemNames.indexOf(cells)
                    toolTip.mainText = itemList.items[i].name
                    toolTip.addText = itemList.items[i].additionalInfo
                    toolTip.show(cell.x + cell.width + col.x, row.y + col.y)
                }
                else {
                    let entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
                    toolTip.mainText = cells
                    toolTip.addText = entityInv.metadataCells[currentIndex].additionalInfo
                    toolTip.show(cell.x + cell.width + col.x, row.y + col.y)
                }
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
        swapCells()
    }

    function swapCells() {
        if (invItem.visible) {
            var entityInv = usedByEntity.inventory//levelLoader.item.entGen.repeater.itemAt(0).item.inventory
            var localMeta
            if (!isEquipment) {
                if (invItem.isEquipment && !(entityInv.equipmentCells[invItem.index] !== "" && cellText.text !== "")) {
                    entityInv.equipmentCells[invItem.index] = cellText.text
                    localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index]
                    entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index] = entityInv.metadataCells[currentIndex]
                }
                else if (!invItem.isEquipment /*&& !(entityInv.equipmentCells[invItem.index] !== "" && cellText.text !== "")*/) {
                    entityInv.inventoryCells[invItem.index] = cellText.text
                    localMeta = entityInv.metadataCells[invItem.index]
                    entityInv.metadataCells[invItem.index] = entityInv.metadataCells[currentIndex]
                }
                else {return}
                entityInv.inventoryCells[currentIndex] = invItem.itemName
                entityInv.metadataCells[currentIndex] = localMeta
                unMoveItem()
                interfaceLoader.item.inventoryCells = entityInv.inventoryCells
                interfaceLoader.item.equipmentCells = entityInv.equipmentCells
                entityInv.activeArmor()
            }
            else if (isEquipment) {
                if (itemList.itemNames.indexOf(invItem.itemName) !== -1 && invItem.itemName !== "") {
                    if (itemList.items[itemList.itemNames.indexOf(invItem.itemName)].type === type) {
                        if (invItem.isEquipment) {
                            entityInv.equipmentCells[invItem.index] = cellText.text
                            localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index]
                            entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index] = entityInv.metadataCells[currentIndex]
                        }
                        else if (!invItem.isEquipment) {
                            entityInv.inventoryCells[invItem.index] = cellText.text
                            localMeta = entityInv.metadataCells[invItem.index]
                            entityInv.metadataCells[invItem.index] = entityInv.metadataCells[currentIndex]
                        }
                        entityInv.equipmentCells[currentIndex] = invItem.itemName
                        entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex] = localMeta
                        unMoveItem()
                        interfaceLoader.item.inventoryCells = entityInv.inventoryCells
                        interfaceLoader.item.equipmentCells = entityInv.equipmentCells
                        entityInv.activeArmor()
                    }
                }
                else if (!!entityInv.metadataCells[invItem.index].type && invItem.itemName !== "") {
                    if (entityInv.metadataCells[invItem.index].type === type) {
                        if (invItem.isEquipment) {
                            entityInv.equipmentCells[invItem.index] = cellText.text
                            localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index]
                            entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index] = entityInv.metadataCells[currentIndex]
                        }
                        else if (!invItem.isEquipment) {
                            entityInv.inventoryCells[invItem.index] = cellText.text
                            localMeta = entityInv.metadataCells[invItem.index]
                            entityInv.metadataCells[invItem.index] = entityInv.metadataCells[currentIndex]
                        }
                        entityInv.equipmentCells[currentIndex] = invItem.itemName
                        entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex] = localMeta
                        unMoveItem()
                        interfaceLoader.item.inventoryCells = entityInv.inventoryCells
                        interfaceLoader.item.equipmentCells = entityInv.equipmentCells
                        entityInv.activeArmor()
                    }
                }
            }
            invInterface.update()
        }
    }
}
