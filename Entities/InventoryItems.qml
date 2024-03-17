import QtQuick 2.15

QtObject {

    property var inventoryCells: ['', '', '', '', '']
    property var previousInventory: ['', '', '', '', '']
    property var equipmentCells: ['', '', '', '', '', '', '']
    property var previousEquipment: ['', '', '', '', '', '', '']
    property var activatedWeapon: [false, false, false]
    property bool twoHands: false

    property var metadataCells: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}] //inventoryCells + equipmentCells
    property var previousMetadata: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}]

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

    function activeArmor() {
        let index = -1
        for (let i = 0; i < 4; i++) {
            const effectIsApplied = (equipmentCells[i] !== '' && previousEquipment[i] === '')
            const effectIsTaken = (equipmentCells[i] === '' && previousEquipment[i] !== '')
            if (effectIsApplied) giveEffect(index, i)
            else if (effectIsTaken) takeEffect(index, i)
            previousEquipment[i] = equipmentCells[i].slice()
        }
        activeWeapon()
    }

    function activeWeapon() {
        let index = -1
        const armorCellsQ = itemList.equipments.length
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
                if ((twoHands && itemList.equipments[i] === "One Hand" && activatedWeapon[j])
                        || (!twoHands && itemList.equipments[i] === "Two Hands" && activatedWeapon[j])) {
                    takeEffect(index, i, true)
                    activatedWeapon[j] = false
                }
            }
        }
        for (i = 4; i < armorCellsQ; i++) {
            j = i - 4
            if (equipmentCells[i] !== '') {
                if ((twoHands && itemList.equipments[i] === "Two Hands" && !activatedWeapon[j])
                        || (!twoHands && itemList.equipments[i] === "One Hand"  && !activatedWeapon[j])) {
                    giveEffect(index, i)
                    activatedWeapon[j] = true
                }
            }
            previousEquipment[i] = equipmentCells[i].slice()
        }
    }

    function takeEffect(index, i, isWeapon = false) {
        const index2 = equipmentCells.indexOf(previousEquipment[i])
        const index3 = inventoryCells.indexOf(previousEquipment[i])
        if (index2 !== -1) {
            if (itemList.equipments.includes(metadataCells[index2 + inventoryCells.length].type)) {
                const cell = metadataCells[index2 + inventoryCells.length]
                cell.usedByEntity = entity
                cell.action = "remove"
                cell.permanent = true
                cell.reversible = true
                itemList.customItem.pool.push(cell)
                itemList.customItem.modelUpdate()
            }
        }
        else if (index3 !== -1) {
            if (itemList.equipments.includes(metadataCells[index3].type)) {
                const cell = metadataCells[index3]
                cell.usedByEntity = entity
                cell.action = "remove"
                cell.permanent = true
                cell.reversible = true
                itemList.customItem.pool.push(cell)
                itemList.customItem.modelUpdate()
            }
        }
    }

    function giveEffect(index, i) {
        const cell = metadataCells[inventoryCells.length + i]
        if (itemList.equipments.includes(cell.type)) {
            cell.usedByEntity = entity
            cell.action = "use"
            cell.permanent = true
            itemList.customItem.pool.push(cell)
            itemList.customItem.modelUpdate()
        }
    }
}
