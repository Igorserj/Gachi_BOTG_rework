import QtQuick 2.15

Repeater {
    model: entGen.objects
    Item {
        WorkerScript {
            id: colliderScript
            source: "collision.mjs"
            onMessage: {
                const walkLeft = messageObject.walkLeft
                const walkRight = messageObject.walkRight
                const walkUp = messageObject.walkUp
                const walkDown = messageObject.walkDown
                const hor = messageObject.hor
                const dir = messageObject.dir
                const edge = messageObject.edge
                const entity = entGen.repeater.itemAt(messageObject.i).item

                if (hor === 1 && dir === 0) entity.animations.moveLeftRun = walkLeft === 1
                else if (hor === 1 && dir === 1) entity.animations.moveRightRun = walkRight === 1
                else if (hor === 0 && dir === 0) entity.animations.moveUpRun = walkUp === 1
                else if (hor === 0 && dir === 1) entity.animations.moveDownRun = walkDown === 1

                if ((walkLeft === 0 && (hor === 1 && dir === 0)) || (walkRight === 0 && (hor === 1 && dir === 1))) {
                    entity.animations.comeCloser(hor, edge)
                }
                else if ((walkUp === 0 && (hor === 0 && dir === 0)) || (walkDown === 0 && (hor === 0 && dir === 1))) {
                    entity.animations.comeCloser(hor, edge)
                }
            }
        }
        WorkerScript {
            id: punchScript
            source: "punch.mjs"
            onMessage: {
                const entities = entityList(messageObject.ids)
                entGen.repeater.itemAt(messageObject.index1).item.animations.dealDamage(entities, messageObject.hHealth)
            }
        }
        WorkerScript {
            id: interactScript
            source: "loot.mjs"
            onMessage: {
                const index = messageObject.index1
                const type = messageObject.type
                if (index.length !== 0) {
                    if (index.length > 1) {
                        let names = []
                        for (let i = 0; i < index.length; i++) {
                            if (type[index[i]] === "hostile") {
                                names.push("Loot " + entGen.metadata[index[i]].name)
                            }
                            else if (type[index[i]] === "npc") {
                                names.push("Talk to " + entGen.metadata[index[i]].name)
                            }
                            else if (type[index[i]] === "interact") {
                                if (entGen.metadata[index[i]].name === "upstairs")
                                    names.push("Go up")
                                else if (entGen.metadata[index[i]].name === "downstairs")
                                    names.push("Go down")
                                else if (entGen.metadata[index[i]].name === "leftpass")
                                    names.push("Go left")
                                else if (entGen.metadata[index[i]].name === "rightpass")
                                    names.push("Go right")
                                else names.push("Interact with " + entGen.metadata[index[i]].name)
                            }
                        }
                        ifaceLoader.item.interfaceLoader.item.contextMenu.obj = index
                        ifaceLoader.item.interfaceLoader.item.contextMenu.objects = names
                        ifaceLoader.item.interfaceLoader.item.contextMenu.set = 0
                        ifaceLoader.item.interfaceLoader.item.contextMenu.show(entGen.repeater.itemAt(0).x, entGen.repeater.itemAt(0).y)
                    }
                    else {
                        if (type[index[0]] === "hostile") {
                            ifaceLoader.item.interfaceLoader.item.inventoryOpen(index, 0)
                        }
                        else if (type[index[0]] === "npc") {
                            entGen.repeater.itemAt(index[0]).item.interaction(entGen.repeater.itemAt(messageObject.index))
                        }
                        else if (type[index[0]] === "interact") {
                            entGen.repeater.itemAt(index[0]).item.interactLoader.item.interaction(entGen.repeater.itemAt(messageObject.index))
                        }
                    }
                }
            }
        }
        WorkerScript {
            id: collisionItemScript
            source: "collisionItem.mjs"
            onMessage: {
                let entity = entGen.repeater.itemAt(messageObject.i).item
                let i = entity.inventory.inventoryCells.indexOf('')
                let index = messageObject.index
                function removing() {
                    itmGen.objects.splice(index, 1)
                    itmGen.metadata.splice(index, 1)
                    itmGen.repeater.model = itmGen.objects
                }
                if (itmGen.metadata[index] !== undefined) {
                    if (itmGen.metadata[index].name === "money" && messageObject.isPicked) {
                        entity.money += itmGen.metadata[index].pcs
                        removing()
                    }
                    else if (itmGen.metadata[index].name !== "money" && i !== -1 && messageObject.isPicked) {
                        entity.inventory.inventoryCells[i] = itmGen.metadata[index].name
                        entity.inventory.metadataCells[i] = itmGen.metadata[index]
                        removing()
                        entity.inventory.invCellsChanged()
                        if (!!ifaceLoader.item.interfaceLoader.item && !!ifaceLoader.item.interfaceLoader.item.inventoryLoader.item) {
                            ifaceLoader.item.interfaceLoader.item.inventoryLoader.item.invInterface.update()
                        }
                    }
                }
                entity.canPickUp = true
            }
        }

        function collision(hor, dir, index, i) {
            const entity = entGen.repeater.itemAt(i)
            colliderScript.sendMessage({
                                           "hX": entity.x,
                                           "hY": entity.y,
                                           "hW": entity.item.width,
                                           "hH": entity.item.height,
                                           "hor": hor,
                                           "dir": dir,
                                           "objects": objGen.objects,
                                           "index": index,
                                           "i": i,
                                           "speed": entity.item.animations.speed
                                       })
        }
        function punch(entity1, index1, ids) {
            const entity2 = entitiesObjects(ids)
            punchScript.sendMessage({
                                        "x": entity1.x,
                                        "y": entity1.y,
                                        "width": entity1.item.width,
                                        "height": entity1.item.height,
                                        "damage": entity1.item.damage,
                                        "type": entGen.objects[index1][0],
                                        "hX": entity2[0],
                                        "hY": entity2[1],
                                        "hW": entity2[2],
                                        "hH": entity2[3],
                                        "hHealth": entity2[4],
                                        "hDef": entity2[5],
                                        "types": entity2[7],
                                        "ids": ids,
                                        "index1": index1
                                    })
        }
        function interaction(entity1, ids) {
            const entity2 = entitiesObjects(ids)
            interactScript.sendMessage({
                                       "x": entity1.x,
                                       "y": entity1.y,
                                       "width": entity1.item.width,
                                       "height": entity1.item.height,
                                       "damage": entity1.item.damage,
                                       "index": entity1.entityIndex,
                                       "hX": entity2[0],
                                       "hY": entity2[1],
                                       "hW": entity2[2],
                                       "hH": entity2[3],
                                       "state": entity2[6],
                                       "type": entity2[7],
                                       "ids": ids
                                   })
        }
        function collisionItem(index, i) {
            const entity = entGen.repeater.itemAt(i)
            if (itmGen.objects[index] !== undefined) {
                collisionItemScript.sendMessage({
                                                    "hX": entity.x,
                                                    "hY": entity.y,
                                                    "hW": entity.item.width,
                                                    "hH": entity.item.height,
                                                    "x": itmGen.objects[index][0],
                                                    "y": itmGen.objects[index][1],
                                                    "width": itmGen.objects[index][2],
                                                    "height": itmGen.objects[index][3],
                                                    "index": index,
                                                    "i": i
                                                })
            }
        }
    }

    function entitiesObjects(ids) {
        let x = []
        let y = []
        let width = []
        let height = []
        let health = []
        let defense = []
        let state = []
        let type = []
        for (let i = 0; i < ids.length; i++) {
            x.push(entGen.repeater.itemAt(ids[i]).x)
            y.push(entGen.repeater.itemAt(ids[i]).y)
            width.push(entGen.repeater.itemAt(ids[i]).item.width)
            height.push(entGen.repeater.itemAt(ids[i]).item.height)
            health.push(entGen.repeater.itemAt(ids[i]).item.health)
            defense.push(entGen.repeater.itemAt(ids[i]).item.defense)
            state.push(entGen.repeater.itemAt(ids[i]).item.state)
            type.push(entGen.objects[ids[i]][0])
        }
        return [x, y, width, height, health, defense, state, type]
    }

    function entityList(ids) {
        let entities = []
        for (let i = 0; i < ids.length; i++) {
            entities.push(entGen.repeater.itemAt(ids[i]).item)
        }
        return entities
    }
}
