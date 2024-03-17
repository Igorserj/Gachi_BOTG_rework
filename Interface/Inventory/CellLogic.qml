import QtQuick 2.15

QtObject {
    property var equipRow: parent
    property var itmGen: levelLoader.item.roomLoader.item.itmGen
    function optionChoose() {
        const text = cellView.cellText
        if (text !== "") {
            const entityInv = usedByEntity.inventory
            let itemType
            let itemIsEquipment
            if (isEquipment) {
                itemType = entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex].type
                itemIsEquipment = itemList.equipments.includes(itemType)
            }
            else {
                itemType = entityInv.metadataCells[currentIndex].type
                itemIsEquipment = itemList.equipments.includes(itemType)
            }
            if (usedByEntity === heroEntity) {
                if (type === itemType) { // Equipment cell
                    contextMenu.set = 2
                    return locale.inventoryCellOptions[2]
                }
                else if (itemIsEquipment) { //Equipment item in inventory cell
                    contextMenu.set = 1
                    return locale.inventoryCellOptions[1]
                }
                else if (!itemIsEquipment) { //Not equipment item
                    contextMenu.set = 0
                    return locale.inventoryCellOptions[0]
                }
            }
            else if (usedByEntity !== heroEntity) {
                if (type === itemType) { // Equipment cell
                    contextMenu.set = 2
                    return locale.inventoryCellOptions[2]
                }
                else {
                    contextMenu.set = 3
                    return locale.inventoryCellOptions[3]
                }
            }
        }
        return [""]
    }
    function itemName() {
        const entityInv = usedByEntity.inventory
        if (isEquipment) return modelData
        else return entityInv.inventoryCells[currentIndex]
    }

    function unMoveItem() {
        invItem.itemName = ""
        invItem.index = -1
        invItem.metadata = {}
        invItem.visible = false
    }
    function moveItem() {
        invItem.itemName = cellView.cellText
        invItem.index = currentIndex
        invItem.metadata = usedByEntity.inventory.metadataCells[currentIndex]
        invItem.visible = true
    }
    function useItem() {
        if (usedByEntity.health < usedByEntity.maxHealth) {
            const cells = cellView.cellText
            const cell = usedByEntity.inventory.metadataCells[currentIndex]
            itemList.customItem.pool.push({buffName: cell.buffName, points: cell.points, usedByEntity: usedByEntity, action: "use", hp: cell.hp, defense: cell.defense})
            itemList.customItem.modelUpdate()
            destroyItem()
        }
        else {
            toolTip.mainText = "Full hp"
            toolTip.addText = "You can't use this item because your health is full"
            toolTip.show(inventoryArea.mouseX, inventoryArea.mouseY)
        }
    }
    function equipItem() {
        function equiping(type) {
            ws2.sendMessage({
                                "type": type,
                                "itemName": cellText,
                                "metadata": entityInv.metadataCells,
                                "equipment": entityInv.equipmentCells,
                                "inventory": entityInv.inventoryCells,
                                "equipments": itemList.equipments,
                                "currentIndex": currentIndex
                            })
        }

        let entityInv = usedByEntity.inventory
        const cellText = cellView.cellText
        const items = itemList.items
        let type = ""
        console.log(entityInv.metadataCells.map((a)=>a.defense))
        type = entityInv.metadataCells[currentIndex].type
        equiping(type)
    }

    function equiped(isSwappable, type, name) {
        if (isSwappable) {
            invItem.itemName2 = cellView.cellText
            inventoryArea.enabled = true
            invItem.visible = true
            swapCells()
        }
        else {
            toolTip.mainText = "Unequip item!"
            toolTip.addText = "There is no vacant cell of type " + type + ". Unequip " + name
            toolTip.show(inventoryArea.mouseX, inventoryArea.mouseY)
        }
    }

    function unEquipItem() {
        const entityInv = usedByEntity.inventory
        const i = entityInv.inventoryCells.indexOf('')
        if (i !== -1) {
            inventoryArea.enabled = true
            entityInv.equipmentCells[currentIndex] = entityInv.inventoryCells[i]
            let localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex]
            entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex] = entityInv.metadataCells[i]
            entityInv.metadataCells[i] = localMeta
            entityInv.inventoryCells[i] = cellView.cellText
            unMoveItem()
            interfaceLoader.item.inventoryLoader.item.inventoryCells = entityInv.inventoryCells
            interfaceLoader.item.inventoryLoader.item.equipmentCells = entityInv.equipmentCells
            invInterface.update()
            entityInv.activeArmor()
        }
        else {
            toolTip.mainText = "Not enough space!"
            toolTip.addText = "There is no vacant cell in your inventory"
            toolTip.show(inventoryArea.mouseX, inventoryArea.mouseY)
        }
    }

    function destroyItem() {
        let entityInv = usedByEntity.inventory
        if (!isEquipment) {
            entityInv.inventoryCells[currentIndex] = ''
            entityInv.metadataCells[currentIndex] = {}
            interfaceLoader.item.inventoryLoader.item.inventoryCells = entityInv.inventoryCells
        }
        invInterface.update()
    }

    function dropItem() {

        function itemDrop() {
            ws.sendMessage({
                               "objects": levelLoader.item.roomLoader.item.objGen.objects,
                               'facingRight': entity.item.facingRight,
                               "entityX": entity.x,
                               "entityY": entity.y,
                               "entityW": entity.item.width,
                               "entityH": entity.item.height
                           })
        }

        const entity = usedByEntity.parent
        if (!isEquipment) {
            itemDrop()
        }
    }
    function pushing(item) {
        itmGen.objects.push(item)
        if (usedByEntity.parent.item.inventory.metadataCells[currentIndex].name === undefined) {
            itmGen.metadata.push({name: usedByEntity.parent.item.inventory.inventoryCells[currentIndex]})
        }
        else {
            itmGen.metadata.push(usedByEntity.parent.item.inventory.metadataCells[currentIndex])
        }
    }
    function dropping(item) {
        pushing(item)
        itmGen.repeater.model = itmGen.objects
        destroyItem()
    }

    function lootItem() {
        let entityInv = usedByEntity.inventory
        let heroInv = heroEntity.inventory
        const i = heroInv.inventoryCells.indexOf('')
        if (i !== -1) {
            inventoryArea.enabled = true
            entityInv.inventoryCells[currentIndex] = heroInv.inventoryCells[i]
            const localMeta = entityInv.metadataCells[currentIndex]
            entityInv.metadataCells[currentIndex] = heroInv.metadataCells[i]
            heroInv.metadataCells[i] = localMeta
            heroInv.inventoryCells[i] = cellView.cellText
            unMoveItem()
            interfaceLoader.item.inventoryLoader.item.inventoryCells = entityInv.inventoryCells
            invInterface.update()
            entityInv.activeArmor()
        }
        else {
            toolTip.mainText = "Not enough space!"
            toolTip.addText = "There is no vacant cells in your inventory"
            toolTip.show(inventoryArea.mouseX, inventoryArea.mouseY)
        }
    }

    function showToolTip() {
        const cells = cellView.cellText
        if (contextMenu.opacity === 0) {
            if (isEquipment) {
                if (cells !== "") {
                    let entityInv = usedByEntity.inventory
                    toolTip.mainText = cells
                    toolTip.addText = !!entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex].additionalInfo ? entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex].additionalInfo : ""
                    toolTip.show(cellView.parent.x + equipRow.x + equipPanel.x + cell.width, equipRow.parent.y)
                }
            }
            else {
                if (cells !== "") {
                    let entityInv = usedByEntity.inventory
                    toolTip.mainText = cells
                    toolTip.addText = !!entityInv.metadataCells[currentIndex].additionalInfo ? entityInv.metadataCells[currentIndex].additionalInfo : ""
                    toolTip.show(cell.x + cell.width + equipRow.x + invInterface.x, col.y + row.y + col.parent.y + invInterface.y)
                }
            }
        }
    }
    function showContextMenu(mouseX, mouseY, button) {
        if (button === Qt.RightButton && contextMenu.opacity === 0 && cellView.cellText !== "") {
            contextMenu.obj = cell
            contextMenu.objects = optionChoose()
            if (isEquipment) contextMenu.show(cellView.parent.x + equipRow.x + equipPanel.x + cell.width, equipRow.parent.y)
            else contextMenu.show(cell.x + cell.width + equipRow.x + invInterface.x, row.y + equipRow.parent.y + invInterface.y)
        }
        else contextMenu.hide()
        swapCells()
    }

    function swapCells() {
        if (invItem.visible) {
            let entityInv = usedByEntity.inventory
            let localMeta
            if (!isEquipment) {
                if (invItem.isEquipment && !(entityInv.equipmentCells[invItem.index] !== "" && cellView.cellText !== "")) {
                    entityInv.equipmentCells[invItem.index] = cellView.cellText
                    localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index]
                    entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index] = entityInv.metadataCells[currentIndex]
                }
                else if (!invItem.isEquipment) {
                    entityInv.inventoryCells[invItem.index] = cellView.cellText
                    localMeta = entityInv.metadataCells[invItem.index]
                    entityInv.metadataCells[invItem.index] = entityInv.metadataCells[currentIndex]
                }
                else {return}
                entityInv.inventoryCells[currentIndex] = invItem.itemName
                entityInv.metadataCells[currentIndex] = localMeta
                unMoveItem()
                interfaceLoader.item.inventoryLoader.item.inventoryCells = entityInv.inventoryCells
                interfaceLoader.item.inventoryLoader.item.equipmentCells = entityInv.equipmentCells
                entityInv.activeArmor()
            }
            else if (isEquipment) {
                if (!!entityInv.metadataCells[invItem.index].type && invItem.itemName !== "") {
                    if (entityInv.metadataCells[invItem.index].type === type) {
                        if (invItem.isEquipment) {
                            entityInv.equipmentCells[invItem.index] = cellView.cellText
                            localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index]
                            entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index] = entityInv.metadataCells[currentIndex]
                        }
                        else if (!invItem.isEquipment) {
                            entityInv.inventoryCells[invItem.index] = cellView.cellText
                            localMeta = entityInv.metadataCells[invItem.index]
                            entityInv.metadataCells[invItem.index] = entityInv.metadataCells[currentIndex]
                        }
                        entityInv.equipmentCells[currentIndex] = invItem.itemName
                        entityInv.metadataCells[entityInv.inventoryCells.length + currentIndex] = localMeta
                        unMoveItem()
                        interfaceLoader.item.inventoryLoader.item.inventoryCells = entityInv.inventoryCells
                        interfaceLoader.item.inventoryLoader.item.equipmentCells = entityInv.equipmentCells
                        entityInv.activeArmor()
                    }
                }
            }
            invInterface.update()
        }
    }
}
