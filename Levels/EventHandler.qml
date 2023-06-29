import QtQuick 2.15

Repeater {
    model: entGen.objects
    Item {
        WorkerScript {
            id: colliderScript
            source: "collision.mjs"
            onMessage: {
                let walkLeft = messageObject.walkLeft
                let walkRight = messageObject.walkRight
                let walkUp = messageObject.walkUp
                let walkDown = messageObject.walkDown
                let hor = messageObject.hor
                let dir = messageObject.dir
                let edge = messageObject.edge
                let entity = entGen.repeater.itemAt(messageObject.i).item
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
            id: lootScript
            source: "loot.mjs"
            onMessage: {
                let index = messageObject.index1
                if (index !== -1) {
                    ifaceLoader.item.state = "inventory"
                    ifaceLoader.item.interfaceLoader.item.usedByEntity = entGen.repeater.itemAt(index).item
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
                        if (ifaceLoader.item.state === "inventory") {
                            ifaceLoader.item.state = "ui"
                            ifaceLoader.item.state = "inventory"
                            ifaceLoader.item.interfaceLoader.item.usedByEntity = entity
                        }
                    }
                    else if (itmGen.metadata[index].name !== "money" && i !== -1 && messageObject.isPicked) {
                        entity.inventory.inventoryCells[i] = itmGen.metadata[index].name
                        entity.inventory.metadataCells[i] = itmGen.metadata[index]
                        removing()
                        if (ifaceLoader.item.state === "inventory") {
                            ifaceLoader.item.state = "ui"
                            ifaceLoader.item.state = "inventory"
                            ifaceLoader.item.interfaceLoader.item.usedByEntity = entity
                        }
                    }
                }
                entity.canPickUp = true
            }
        }

        function collision(hor, dir, index, i) {
            var entity = entGen.repeater.itemAt(i)
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
                                        "hX": entity2[0],
                                        "hY": entity2[1],
                                        "hW": entity2[2],
                                        "hH": entity2[3],
                                        "hHealth": entity2[4],
                                        "hDef": entity2[5],
                                        "ids": ids,
                                        "index1": index1
                                    })
        }
        function loot(entity1, ids) {
            const entity2 = entitiesObjects(ids)
            lootScript.sendMessage({
                                        "x": entity1.x,
                                        "y": entity1.y,
                                        "width": entity1.item.width,
                                        "height": entity1.item.height,
                                        "damage": entity1.item.damage,
                                        "hX": entity2[0],
                                        "hY": entity2[1],
                                        "hW": entity2[2],
                                        "hH": entity2[3],
                                        "ids": ids
                                    })
        }
        function collisionItem(index, i) {
            var entity = entGen.repeater.itemAt(i)
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
//                                                    "speed": entity.item.animations.speed
                                                })
            }
        }
    }

    function entitiesObjects(ids) {
        var x = []
        var y = []
        var width = []
        var height = []
        var health = []
        var defense = []
        for (var i = 0; i < ids.length; i++) {
            x.push(entGen.repeater.itemAt(ids[i]).x)
            y.push(entGen.repeater.itemAt(ids[i]).y)
            width.push(entGen.repeater.itemAt(ids[i]).item.width)
            height.push(entGen.repeater.itemAt(ids[i]).item.height)
            health.push(entGen.repeater.itemAt(ids[i]).item.health)
            defense.push(entGen.repeater.itemAt(ids[i]).item.defense)
        }
        return [x, y, width, height, health, defense]
    }

    function entityList(ids) {
        let entities = []
        for (let i = 0; i < ids.length; i++) {
            entities.push(entGen.repeater.itemAt(ids[i]).item)
        }
        return entities
    }
}
