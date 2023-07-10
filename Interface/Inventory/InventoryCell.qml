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
                var entityInv = usedByEntity.inventory
                let type1 = itemList.items[itemList.itemNames.indexOf(text)].type
                if (type === type1) {
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
                var entityInv = usedByEntity.inventory
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
        invItem.metadata = usedByEntity.inventory.metadataCells[currentIndex]
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
            const cell = usedByEntity.inventory.metadataCells[currentIndex]
            itemList.customItem.pool.push({buffName: cell.buffName, points: cell.points, usedByEntity: invInterface.usedByEntity, action: "use", hp: cell.hp, defense: cell.defense})
            itemList.customItem.modelUpdate()
        }
        destroyItem()
    }
    function equipItem() {
        var entityInv = usedByEntity.inventory
        let isSwappable = false
        let type
        let name = ""

        if (itemList.itemNames.indexOf(cellText.text) !== -1) type = itemList.items[itemList.itemNames.indexOf(cellText.text)].type
        else type = entityInv.metadataCells[currentIndex].type

        for (let i = 0; i < entityInv.equipmentCells.length; i++) {
                if (type === itemList.equipmnets[i] && entityInv.equipmentCells[i] === "") {
                    invItem.index = i
                    invItem.isEquipment = true
                    invItem.itemName = entityInv.equipmentCells[i]
                    invItem.metadata = entityInv.metadataCells[entityInv.inventoryCells.length + i]
                    isSwappable = true
                }
                else if (type === itemList.equipmnets[i] && entityInv.equipmentCells[i] !== "") {
                    name = entityInv.equipmentCells[i]
                }
            }

        if (isSwappable) {
            invItem.itemName2 = cellText.text
            inventoryArea.enabled = true
            swapCells()
        }
        else {
            toolTip.mainText = "Unequip item!"
            toolTip.addText = "There is no vacant cell of type " + type + ". Unequip " + name
            toolTip.show(cell.x + cell.width + col.x, row.y + col.y)
        }
    }
    function unEquipItem() {
        var entityInv = usedByEntity.inventory
        let i = entityInv.inventoryCells.indexOf('')
        if (i !== -1) {
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
        else {
            toolTip.mainText = "Not enough space!"
            toolTip.addText = "There is no vacant cell in your inventory"
            toolTip.show(equipRow.x + col.x + cell.width, equipRow.y + col.y)
        }
    }

    function destroyItem() {
        var entityInv = usedByEntity.inventory
        if (!isEquipment) {
            entityInv.inventoryCells[currentIndex] = ''
            entityInv.metadataCells[currentIndex] = {}
            interfaceLoader.item.inventoryCells = entityInv.inventoryCells
        }
        invInterface.update()
    }

    function dropItem() {
        var entity = usedByEntity.parent
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
        }
    }

    function lootItem() {
        var entityInv = usedByEntity.inventory
        var heroInv = heroEntity.inventory
        let i = heroInv.inventoryCells.indexOf('')
        if (i !== -1) {
            inventoryArea.enabled = true
            entityInv.inventoryCells[currentIndex] = heroInv.inventoryCells[i]
            let localMeta = entityInv.metadataCells[currentIndex]
            entityInv.metadataCells[currentIndex] = heroInv.metadataCells[i]
            heroInv.metadataCells[i] = localMeta
            heroInv.inventoryCells[i] = cellText.text
            unMoveItem()
            interfaceLoader.item.inventoryCells = entityInv.inventoryCells
            invInterface.update()
            entityInv.activeArmor()
        }
        else {
            toolTip.mainText = "Not enough space!"
            toolTip.addText = "There is no vacant cells in your inventory"
            toolTip.show(cell.x + cell.width + col.x, row.y + col.y)
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
                    let entityInv = usedByEntity.inventory
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
                    let entityInv = usedByEntity.inventory
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
            var entityInv = usedByEntity.inventory
            var localMeta
            if (!isEquipment) {
                if (invItem.isEquipment && !(entityInv.equipmentCells[invItem.index] !== "" && cellText.text !== "")) {
                    entityInv.equipmentCells[invItem.index] = cellText.text
                    localMeta = entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index]
                    entityInv.metadataCells[entityInv.inventoryCells.length + invItem.index] = entityInv.metadataCells[currentIndex]
                }
                else if (!invItem.isEquipment) {
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
