WorkerScript.onMessage = function (message) {

    const inventory = message.inventory
    const metadata = message.metadata

    let indexes = []
    let metas = []
    let items = []

    for (let i = 0; i < inventory.length; i++) {
        if (inventory[i] !== "" && !metadata[i].isEquipment) {
            metas.push(metadata[i])
            items.push(inventory[i])
            indexes.push(i)
        }
    }

    WorkerScript.sendMessage({
                                 "indexes": indexes,
                                 "metas": metas,
                                 "items": items
                             })
}
