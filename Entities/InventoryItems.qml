import QtQuick 2.15

QtObject {

    property var inventoryCells: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
    property var equipmentCells: ['', '', '', '', '']
    property var previousEquipment: ['', '', '', '', '']

    property var metadataCells: [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [],
                                [], [], [], [], []] //inventoryCells + equipmentCells

    Component.onCompleted: {
        activeItems()
    }

    function activeItems() {
        let index = -1
        for (let i = 0; i < equipmentCells.length; i++) {
            if (equipmentCells[i] !== '' && previousEquipment[i] === '') {
                index = itemList.itemNames.indexOf(equipmentCells[i])
                if (index !== -1) {
                    if (itemList.items[index].isEquipment) {
                        itemList.items[index].usedByEntity = entity
                        itemList.items[index].use(true)
                    }
                }
                else {
                    if (metadataCells[inventoryCells.length + i].isEquipment) {
                        itemList.customItem.usedByEntity = entity
                        itemList.customItem.use(true)
                    }
                }
            }
            else if (equipmentCells[i] === previousEquipment[i]) {
            }
            else if (equipmentCells[i] === '' && previousEquipment[i] !== '') {
                index = itemList.itemNames.indexOf(previousEquipment[i])
                if (index !== -1) {
                    if (itemList.items[index].isEquipment) {
                        itemList.items[index].usedByEntity = entity
                        itemList.items[index].removeEffect(true)
                    }
                }
                else {
                    if (metadataCells[inventoryCells.length + i].isEquipment) {
                        itemList.customItem.usedByEntity = entity
                        itemList.customItem.removeEffect(true)
                    }
                }
            }

        }
        previousEquipment = equipmentCells.slice()
    }
}
