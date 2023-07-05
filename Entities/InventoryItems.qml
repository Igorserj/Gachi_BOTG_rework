import QtQuick 2.15

QtObject {

    property var inventoryCells: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
    property var equipmentCells: ['', '', '', '', '', '']
    property var previousEquipment: ['', '', '', '', '', '']
    property var activatedWeapon: [false, false, false]
    property bool twoHands: false

    property var metadataCells: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
        {}, {}, {}, {}, {}, {}] //inventoryCells + equipmentCells

    Component.onCompleted: { activeArmor(); activeWeapon() }

    function activeArmor() {
        var index = -1

        for (let i = 0; i < 3; i++) {
            const effectIsApplied = (equipmentCells[i] !== '' && previousEquipment[i] === '')
            const effectIsTaken = (equipmentCells[i] === '' && previousEquipment[i] !== '')
            if (effectIsApplied) giveEffect(index, i)
            else if (effectIsTaken) takeEffect(index, i)
            previousEquipment[i] = equipmentCells[i].slice()
        }
        activeWeapon()
    }

    function activeWeapon() {
        var index = -1
        const armorCellsQ = itemList.equipmnets.length
        for (let i = 3; i < armorCellsQ; i++) {
            let j = i - 3
            if (equipmentCells[i] !== '') {
                if (twoHands && itemList.equipmnets[i] === "Two Hands" && !activatedWeapon[j]) {
                    giveEffect(index, i)
                    activatedWeapon[j] = true
                }
                else if (twoHands && itemList.equipmnets[i] === "One Hand" && activatedWeapon[j]) {
                    takeEffect(index, i, true)
                    activatedWeapon[j] = false
                }
                if (!twoHands && itemList.equipmnets[i] === "One Hand"  && !activatedWeapon[j]) {
                    giveEffect(index, i)
                    activatedWeapon[j] = true
                }
                else if (!twoHands && itemList.equipmnets[i] === "Two Hands" && activatedWeapon[j]) {
                    takeEffect(index, i, true)
                    activatedWeapon[j] = false
                }
            }
            else if (equipmentCells[i] === '' && equipmentCells[i] !== previousEquipment[i]) {
                takeEffect(index, i)
                activatedWeapon[j] = false
            }
            previousEquipment[i] = equipmentCells[i].slice()
        }
    }

    function takeEffect(index, i, isWeapon = false) {
        index = itemList.itemNames.indexOf(previousEquipment[i])
        if (index !== -1) {
            if (itemList.items[index].isEquipment) {
                itemList.items[index].usedByEntity = entity
                itemList.items[index].removeEffect(true)
            }
        }
        else if (isWeapon) {
            index = equipmentCells.indexOf(previousEquipment[i])
            if (metadataCells[index + inventoryCells.length].isEquipment) {
//                itemList.customItem.usedByEntity = entity
//                itemList.customItem.buffName = metadataCells[index + inventoryCells.length].buffName
//                itemList.customItem.removeEffect(true)
//                itemList.customItem.buffName = ""
                console.log("act1")
//                let items = itemList.customItem.model
//                items.push({buffName: metadataCells[index + inventoryCells.length].buffName, usedByEntity: entity, action: "remove", permanent: true})
//                itemList.customItem.model = items
                itemList.customItem.pool.push({buffName: metadataCells[index + inventoryCells.length].buffName, usedByEntity: entity, action: "remove", permanent: true})
                itemList.customItem.modelUpdate()
                //[{type: "", name: "", additionalInfo: "", buffName: "", points: 0, usedByEntity: undefined, action = "use", permanent = false}]
            }
        }
        else {
            index = inventoryCells.indexOf(previousEquipment[i])
            if (metadataCells[index].isEquipment) {
//                itemList.customItem.usedByEntity = entity
//                itemList.customItem.buffName = metadataCells[index].buffName
//                itemList.customItem.removeEffect(true)
                console.log("act2")
//                let items = itemList.customItem.model
//                items.push({buffName: metadataCells[index].buffName, usedByEntity: entity, action: "remove", permanent: true})
//                itemList.customItem.model = items
                itemList.customItem.pool.push({buffName: metadataCells[index].buffName, usedByEntity: entity, action: "remove", permanent: true})
                itemList.customItem.modelUpdate()
//                itemList.customItem.buffName = ""
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
//                itemList.customItem.usedByEntity = entity
//                itemList.customItem.buffName = metadataCells[inventoryCells.length + i].buffName
//                itemList.customItem.use(true)
                console.log("act3")
//                let items = itemList.customItem.model
//                items.push({buffName: metadataCells[inventoryCells.length + i].buffName, usedByEntity: entity, action: "use", permanent: true})
//                itemList.customItem.model = items
                itemList.customItem.pool.push({buffName: metadataCells[inventoryCells.length + i].buffName, usedByEntity: entity, action: "use", permanent: true})
                itemList.customItem.modelUpdate()
            }
        }
    }
}
