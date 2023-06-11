import QtQuick 2.15

QtObject {

    property var inventoryCells: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
    property var equipmentCells: ['', '', '', '', '']
    property var previousEquipment: ['', '', '', '', '']

    Component.onCompleted: {
        activeItems()
    }

    function activeItems() {
        for (let i = 0; i < equipmentCells.length; i++) {
            if (equipmentCells[i] !== '' && previousEquipment[i] === '') {
                let index = itemList.itemNames.indexOf(equipmentCells[i])
                if (index !== -1) {
                    if (itemList.items[index].isEquipment) {
                        itemList.items[index].usedByEntity = entity
                        itemList.items[index].use(true)
                    }
                }
            }
            else if (equipmentCells[i] === previousEquipment[i]) {
            }
            else if (equipmentCells[i] === '' && previousEquipment[i] !== '') {
                let index = itemList.itemNames.indexOf(previousEquipment[i])
                if (index !== -1) {
                    if (itemList.items[index].isEquipment) {
                        itemList.items[index].usedByEntity = entity
                        itemList.items[index].removeEffect(true)
                    }
                }
            }

        }
        previousEquipment = equipmentCells.slice()
    }
}
