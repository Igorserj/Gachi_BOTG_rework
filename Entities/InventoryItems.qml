import QtQuick 2.15

QtObject {

    property var inventoryCells: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
    property var previousInventory: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
    property var equipmentCells: ['', '', '', '', '', '', '']
    property var previousEquipment: ['', '', '', '', '', '', '']
    property var activatedWeapon: [false, false, false]
    property bool twoHands: false

    property var metadataCells: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
        {}, {}, {}, {}, {}, {}, {}] //inventoryCells + equipmentCells
    property var previousMetadata: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
        {}, {}, {}, {}, {}, {}, {}]

    function invCellsChanged() {
        if (inventoryCells.length !== previousInventory.length) {
            for (let i = inventoryCells.length; i < previousInventory.length; i++) {
                inventoryCells.push(previousInventory[i])
                metadataCells[i] = previousMetadata[i]
            }
        }
        previousInventory = inventoryCells.slice()
        previousMetadata = metadataCells.slice()
    }

    function equipCellsChanged() {
        if (equipmentCells.length !== previousEquipment.length) {
            for (let i = equipmentCells.length; i < previousEquipment.length; i++) {
                equipmentCells.push(previousEquipment[i])
                metadataCells[i + previousInventory.length] = previousMetadata[i + previousInventory.length]
            }
        }
        previousMetadata = metadataCells.slice()
        activeArmor()
    }

    onInventoryCellsChanged: invCellsChanged()
    onEquipmentCellsChanged: equipCellsChanged()
    Component.onCompleted: activeArmor()

    function activeArmor() {
        if (equipmentCells.length === 7) {
            var index = -1
            for (let i = 0; i < 4; i++) {
                const effectIsApplied = (equipmentCells[i] !== '' && previousEquipment[i] === '')
                const effectIsTaken = (equipmentCells[i] === '' && previousEquipment[i] !== '')
                if (effectIsApplied) giveEffect(index, i)
                else if (effectIsTaken) takeEffect(index, i)
                previousEquipment[i] = equipmentCells[i].slice()
            }
            activeWeapon()
        }
    }

    function activeWeapon() {
        var index = -1
        const armorCellsQ = itemList.equipmnets.length
        let i = 4
        let j = 0
        for (i = 4; i < armorCellsQ; i++) {
            j = i - 4
            if (equipmentCells[i] === '' && equipmentCells[i] !== previousEquipment[i]) {
                if (activatedWeapon[j]) {
                    takeEffect(index, i)
                    activatedWeapon[j] = false
                }
            }
            if (equipmentCells[i] !== '') {
                if ((twoHands && itemList.equipmnets[i] === "One Hand" && activatedWeapon[j])
                        || (!twoHands && itemList.equipmnets[i] === "Two Hands" && activatedWeapon[j])) {
                    takeEffect(index, i, true)
                    activatedWeapon[j] = false
                }
            }
        }
        for (i = 4; i < armorCellsQ; i++) {
            j = i - 4
            if (equipmentCells[i] !== '') {
                if ((twoHands && itemList.equipmnets[i] === "Two Hands" && !activatedWeapon[j])
                        || (!twoHands && itemList.equipmnets[i] === "One Hand"  && !activatedWeapon[j])) {
                    giveEffect(index, i)
                    activatedWeapon[j] = true
                }
            }
            previousEquipment[i] = equipmentCells[i].slice()
        }
    }

    function takeEffect(index, i, isWeapon = false) {
        index = itemList.itemNames.indexOf(previousEquipment[i])
        let index2 = equipmentCells.indexOf(previousEquipment[i])
        let index3 = inventoryCells.indexOf(previousEquipment[i])
        if (index !== -1) {
            if (itemList.items[index].isEquipment) {
                itemList.items[index].usedByEntity = entity
                itemList.items[index].removeEffect(true, true)
            }
        }
        else if (index2 !== -1) {
            if (metadataCells[index2 + inventoryCells.length].isEquipment) {
                const cell = metadataCells[index2 + inventoryCells.length]
                itemList.customItem.pool.push({buffName: cell.buffName, usedByEntity: entity, action: "remove", permanent: true, points: cell.points, reversible: true, hp: cell.hp, defense: cell.defense})
                itemList.customItem.modelUpdate()
            }
        }
        else if (index3 !== -1) {
            if (metadataCells[index3].isEquipment) {
                const cell = metadataCells[index3]
                itemList.customItem.pool.push({buffName: cell.buffName, usedByEntity: entity, action: "remove", permanent: true, points: cell.points, reversible: true, hp: cell.hp, defense: cell.defense})
                itemList.customItem.modelUpdate()
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
                const cell = metadataCells[inventoryCells.length + i]
                itemList.customItem.pool.push({buffName: cell.buffName, usedByEntity: entity, action: "use", permanent: true, points: cell.points, hp: cell.hp, defense: cell.defense})
                itemList.customItem.modelUpdate()
            }
        }
    }
}
