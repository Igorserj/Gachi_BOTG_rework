import QtQuick 2.15
import "../Buffs"

Rectangle {
    id: entity
    property int run: 0
    property int walkLeft: 0
    property int walkRight: 0
    property int walkUp: 0
    property int walkDown: 0
    property double health: maxHealth
    property double maxHealth: 100

    property double stamina: maxStamina
    property double maxStamina: 30

    property double speed: 20
    property double damage: 10
    property double defense: 0 //20 max
    property int money: 0

    property bool movementBlocked: false
    property bool interactionBlocked: false

    property alias animations: animations
    property alias inventory: inventory
    property alias buffList: buffList

    property bool recovery: false

    state: "alive"
    width: 50
    height: 50
    border.width: 2

    states: [
        State {
            name: "alive"
            when: entity.health > 0
            PropertyChanges {
                target: entity
                movementBlocked: false
                interactionBlocked: false
            }
        },
        State {
            name: "paused"
            PropertyChanges {
                target: entity
            }
        },
        State {
            name: "dead"
            when: entity.health <= 0
            PropertyChanges {
                target: entity
                movementBlocked: true
                interactionBlocked: true
            }
        },
        State {
            name: "idle"
        }
    ]
    InventoryItems {
        id: inventory
    }
    BuffList {
        id: buffList
    }

    Animations {
        id: animations
    }

    WorkerScript {
        id: objectsScanScript
        source: "objectsScan.mjs"
        onMessage: (messageObject)=> {
            let index = messageObject.index
            let dir = messageObject.dir
            let hor = messageObject.hor
            if (index.length > 0) {
                eventHandler.itemAt(entity.parent.entityIndex).collision(hor, dir, index, entity.parent.entityIndex)
//                for (let i = 0; i < index.length; i++) {
//                }
            }
            else {
                if (hor === 1 && dir === 0) animations.moveLeftRun = true
                else if (hor === 1 && dir === 1) animations.moveRightRun = true
                else if (hor === 0 && dir === 0) animations.moveUpRun = true
                else if (hor === 0 && dir === 1) animations.moveDownRun = true
            }
        }
    }
    WorkerScript {
        id: itemsScanScript
        source: "objectsScan.mjs"
        onMessage: (messageObject)=> {
            let index = messageObject.index
            let dir = messageObject.dir
            let hor = messageObject.hor
            if (index.length > 0) {
                for (let i = 0; i < index.length; i++) {
                    eventHandler.itemAt(entity.parent.entityIndex).collisionItem(hor, dir, index[i], entity.parent.entityIndex)
                }
            }
        }
    }
    WorkerScript {
        id: enemiesScanScript
        source: "enemiesScan.mjs"
        onMessage: (messageObject)=> {
            const ids = messageObject.ids
            eventHandler.itemAt(entity.parent.entityIndex).punch(entity.parent, messageObject.index, ids)
        }
    }

    function objScan(hor, dir) {
        if (!movementBlocked) {
            objectsScanScript.sendMessage({
                                              "hor": hor,
                                              "dir": dir,
                                              "objects": objGen.objects,
                                              "x": parent.x,
                                              "y": parent.y,
                                              "width": width,
                                              "height": height,
                                              "speed": animations.speed
                                          })
        }
    }
    function itmScan(hor, dir) {
        if (!movementBlocked) {
            itemsScanScript.sendMessage({
                                              "hor": hor,
                                              "dir": dir,
                                              "objects": itmGen.objects,
                                              "x": parent.x,
                                              "y": parent.y,
                                              "width": width,
                                              "height": height,
                                              "speed": animations.speed
                                          })
        }
    }

    function nmyScan() {
        if (!interactionBlocked) {
            animations.attackReady = false
            enemiesScanScript.sendMessage({
                                              "objects": entGen.objects,
                                              "index": entity.parent.entityIndex
                                          })
        }
    }

    function toTheLeft() {
        walkLeft = true
        objScan(1, 0)
        itmScan(1, 0)
    }
    function toTheRight() {
        walkRight = true
        objScan(1, 1)
        itmScan(1, 1)
    }
    function toTheTop() {
        walkUp = true
        objScan(0, 0)
        itmScan(0, 0)
    }
    function toTheBot() {
        walkDown = true
        objScan(0, 1)
        itmScan(0, 1)
    }
    function runActive() {
        if (stamina > 2) run = 1
        else run = 0
    }
}
