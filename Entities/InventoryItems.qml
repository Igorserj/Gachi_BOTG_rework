import QtQuick 2.15

QtObject {

    property var inventoryCells: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
    property var equipmentCells: ['', '', '', '', '', '']
    property var previousEquipment: ['', '', '', '', '', '']
    property bool twoHands: false

    property var metadataCells: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                {}, {}, {}, {}, {}, {}] //inventoryCells + equipmentCells

    Component.onCompleted: {
        activeArmor()
    }

    function activeArmor() {
        var index = -1
        const armorCellsQ = equipmentCells.length
        for (let i = 0; i < armorCellsQ; i++) {

            if (equipmentCells[i] !== '' && previousEquipment[i] === '') {
                giveEffect(index, i)
            }
            else if (equipmentCells[i] === previousEquipment[i]) {
            }
            else if (equipmentCells[i] === '' && previousEquipment[i] !== '') {
                takeEffect(index, i)
            }

        }
        previousEquipment = equipmentCells.slice()
    }

    function takeEffect(index, i) {
        index = itemList.itemNames.indexOf(previousEquipment[i])
        if (index !== -1) {
            if (itemList.items[index].isEquipment) {
                itemList.items[index].usedByEntity = entity
                itemList.items[index].removeEffect(true)
            }
        }
        else {
            index = inventoryCells.indexOf(previousEquipment[i])
            if (metadataCells[index].isEquipment) {
                itemList.customItem.usedByEntity = entity
                itemList.customItem.buffName = metadataCells[index].buffName
                itemList.customItem.removeEffect(true)
                itemList.customItem.buffName = ""
            }
        }
    }

    function giveEffect(index, i) {
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
                itemList.customItem.buffName = metadataCells[inventoryCells.length + i].buffName
                itemList.customItem.use(true)
            }
        }
    }
}
