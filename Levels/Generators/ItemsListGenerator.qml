import QtQuick 2.15

Item {
    property alias generator: generate
    // property var head0: []
    property var head1
    // property var torso0: []
    property var torso1
    // property var legs0: []
    property var legs1
    // property var feet0: []
    property var feet1

    // property var oneHanded0: []
    property var oneHanded1
    // property var twoHanded0: []
    property var twoHanded1

    // property var ingredients0: []
    property var ingredients1
    // property var dishes0: []
    property var dishes1

    property var enemiesAllocByName
    property var layouts

    property bool isReady: !!head1 &&
                           !!torso1 &&
                           !!legs1 &&
                           !!feet1 &&
                           !!oneHanded1 &&
                           !!twoHanded1 &&
                           !!ingredients1 &&
                           !!dishes1 &&
                           !!enemiesAllocByName &&
                           !!layouts

    onIsReadyChanged: {
        if (isReady) {
            generate.sendMessage({
                                     'head1' : head1,
                                     'torso1' : torso1,
                                     'legs1' : legs1,
                                     'feet1' : feet1,

                                     'oneHanded1' : oneHanded1,
                                     'twoHanded1' : twoHanded1,

                                     'ingredients1' : ingredients1,
                                     'dishes1' : dishes1,
                                     'seed': seed,
                                     'enemiesAllocByName' : enemiesAllocByName,
                                     'layouts' : layouts
                                 })
        }
    }

    WorkerScript {
        id: generate
        property var treassuresSpawn
        property var corridorsLayout
        property var roomsLayout
        property var enemiesTreassure
        property var enemiesCorridor
        property var enemiesRoom
        source: "itemsListGenerator.js"
        onMessage: {
           treassuresSpawn = messageObject.treassuresSpawn
           corridorsLayout = messageObject.corridorsLayout
           roomsLayout = messageObject.roomsLayout
           enemiesTreassure = messageObject.enemiesTreassure
           enemiesCorridor = messageObject.enemiesCorridor
           enemiesRoom = messageObject.enemiesRoom

            opSave.level.items.treassuresSpawn = treassuresSpawn
            opSave.level.items.corridorsLayout = corridorsLayout
            opSave.level.items.roomsLayout = roomsLayout
            opSave.level.items.enemiesTreassure = enemiesTreassure
            opSave.level.items.enemiesCorridor = enemiesCorridor
            opSave.level.items.enemiesRoom = enemiesRoom

            opSave.level.hostile.corridorEnemyMeta.map((a, index)=>a.map((b, ind)=>b.map(function (c, i) {
                // metadataCells = [[],[],[],[],[],[],[],[],[],[],[],[]]
                // equipmentCells = ["","","","","","",""]
                enemiesCorridor[index][ind][i].map(function (d) {
                    inventoryUpdate(index, ind, i, d, false)
                })
                // types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
                // equipments: ["Head", "Body", "Legs", "Feet", "One Hand", "One Hand", "Two Hands"]
            }
            )))

            opSave.level.hostile.roomEnemyMeta.map((a, index)=>a.map((b, ind)=>b.map(function (c, i) {
                enemiesRoom[index][ind][i].map(function (d) {
                    inventoryUpdate(index, ind, i, d, true)
                })
            })))
            currentRoom = inRoom ? allocation[floor][position] : lvlPattern.corridorsLayout[floor][position]
        }
        function inventoryUpdate(index, ind, i, d, inRoom) {
            const meta = inRoom ? opSave.level.hostile.roomEnemyMeta[index][ind][i].metadataCells : opSave.level.hostile.corridorEnemyMeta[index][ind][i].metadataCells
            if (d.type === "Head") {
                (inRoom ? opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[0] = d.name :
                          opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[0] = d.name)
                meta[meta.length - 7] = d
            }
            else if (d.type === "Body") {
                (inRoom ? opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[1] = d.name :
                          opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[1] = d.name)
                meta[meta.length - 6] = d
            }
            else if (d.type === "Legs") {
                (inRoom ? opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[2] = d.name :
                          opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[2] = d.name)
                meta[meta.length - 5] = d
            }
            else if (d.type === "Feet") {
                (inRoom ? opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[3] = d.name :
                          opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[3] = d.name)
                meta[meta.length - 4] = d
            }
            else if (d.type === "One Hand") {
                if (inRoom) {
                    if (opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[4] === "") {
                        opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[4] = d.name
                        meta[meta.length - 3] = d
                    }
                    else {
                        opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[5] = d.name
                        meta[meta.length - 2] = d
                    }
                }
                else {
                    if (opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[4] === "") {
                        opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[4] = d.name
                        meta[meta.length - 3] = d
                    }
                    else {
                        opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[5] = d.name
                        meta[meta.length - 2] = d
                    }
                }
            }
            else if (d.type === "Two Hands") {
                (inRoom ? opSave.level.hostile.roomEnemyMeta[index][ind][i].equipmentCells[6] = d.name :
                          opSave.level.hostile.corridorEnemyMeta[index][ind][i].equipmentCells[6] = d.name)
                meta[meta.length - 1] = d
            }
            else if (d.type === "Consumable") {
                const j = inRoom ? opSave.level.hostile.roomEnemyMeta[index][ind][i].inventoryCells.indexOf('') :
                                   opSave.level.hostile.corridorEnemyMeta[index][ind][i].inventoryCells.indexOf('')
                if (inRoom) {opSave.level.hostile.roomEnemyMeta[index][ind][i].inventoryCells[j] = d.name
                // console.log("Consumable:", j, opSave.level.hostile.roomEnemyMeta[index][ind][i].inventoryCells[j], opSave.level.hostile.roomEnemyMeta[index][ind][i].inventoryCells)
                }else opSave.level.hostile.corridorEnemyMeta[index][ind][i].inventoryCells[j] = d.name
                meta[j] = d
            }

        }
    }
}
