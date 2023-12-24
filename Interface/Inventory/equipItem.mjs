WorkerScript.onMessage = function(message) {

    let isSwappable = false
    let name = ""
    const type = message.type
    const metadata = message.metadata //entityInv.metadataCells
    const equipment = message.equipment //entityInv.metadataCells
    const inventory = message.inventory //entityInv.inventoryCells
    const equipments = message.equipments //itemList.equipmnets

    let index = 0
    let isEquipment = false
    let itemName = ""//message.itemName
    let meta = []


    for (let i = 0; i < equipment.length; i++) {
        if (type === equipments[i] && equipment[i] === "") {
            index = i
            isEquipment = true
            itemName = equipment[i]
            meta = metadata[inventory.length + i]
            isSwappable = true
        }
        else if (type === equipments[i] && equipment[i] !== "") {
            name = equipment[i]
        }
    }

    WorkerScript.sendMessage({
                                 "index" : index,
                                 "isEquipment" : isEquipment,
                                 "itemName" : itemName,
                                 "metadata" : meta,
                                 "isSwappable" : isSwappable,
                                 "type" : type,
                                 "name" : name
                             })

}
