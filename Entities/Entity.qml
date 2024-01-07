import QtQuick 2.15
import "../Buffs"

Rectangle {
    id: entity
    property int run: 0
    property int walkLeft: 0
    property int walkRight: 0
    property int walkUp: 0
    property int walkDown: 0

    property double health: opSave.level.hero.health
    property double maxHealth: opSave.level.hero.maxHealth

    property double stamina: opSave.level.hero.stamina
    property double maxStamina: opSave.level.hero.maxStamina

    property int speedCoeff: opSave.level.hero.speedCoeff
    property double speed: speedCoeff * scaleCoeff
    property double damage: opSave.level.hero.damage
    property double defense: opSave.level.hero.defense //20 max
    property int money: opSave.level.hero.money

    property bool movementBlocked: false
    property bool interactionBlocked: false
    property bool canPickUp: true

    property alias animations: animations
    property alias inventory: inventory
    property alias buffList: buffList
    property bool facingRight: opSave.level.hero.facingRight
    property int rot: opSave.level.hero.rot
    property string name: opSave.level.hero.name

    property bool recovery: false
    property bool anotherRoom: false

    state: "alive"
    width: 50 * scaleCoeff
    height: 50 * scaleCoeff
    border.width: 2
    transform: [
        Rotation { origin.x: width / 2; origin.y: height / 2; axis { x: 0; y: 1; z: 0 } angle: rot }
    ]

    states: [
        State {
            name: "alive"
            when: entity.health > 0
            PropertyChanges {
                target: entity
                movementBlocked: false
                interactionBlocked: false
                canPickUp: true
            }
        },
        State {
            name: "paused"
            PropertyChanges {
                target: entity
                movementBlocked: true
                interactionBlocked: true
            }
        },
        State {
            name: "dead"
            when: entity.health <= 0
            PropertyChanges {
                target: entity
                movementBlocked: true
                interactionBlocked: true
                canPickUp: false
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
        onMessage: scannedObjects(messageObject)
    }
    WorkerScript {
        id: itemsScanScript
        source: "objectsScan.mjs"
        onMessage: scannedItems(messageObject)
    }
    WorkerScript {
        id: enemiesPunchScript
        source: "enemiesScan.mjs"
        onMessage: scannedEnemies(messageObject)
    }

    WorkerScript {
        id: deadEnemiesScanScript
        source: "enemiesScan.mjs"
        onMessage: scannedDeadEnemies(messageObject)
    }

    function scannedObjects(messageObject) {
        let index = messageObject.index
        let dir = messageObject.dir
        let hor = messageObject.hor
        if (index.length > 0) {
            eventHandler.itemAt(entity.parent.entityIndex).collision(hor, dir, index, entity.parent.entityIndex)
        }
        else {
            if (hor === 1 && dir === 0) animations.moveLeftRun = true
            else if (hor === 1 && dir === 1) animations.moveRightRun = true
            else if (hor === 0 && dir === 0) animations.moveUpRun = true
            else if (hor === 0 && dir === 1) animations.moveDownRun = true
        }
    }

    function scannedItems(messageObject) {
        let index = messageObject.index
        if (index.length > 0) {
            for (let i = 0; i < index.length; i++) {
                eventHandler.itemAt(entity.parent.entityIndex).collisionItem(index[i], entity.parent.entityIndex)
            }
        }
        else canPickUp = true
    }

    function scannedEnemies(messageObject) {
        eventHandler.itemAt(entity.parent.entityIndex).punch(entity.parent, messageObject.index, messageObject.ids)
    }

    function scannedDeadEnemies(messageObject) {
        eventHandler.itemAt(entity.parent.entityIndex).interaction(entity.parent, messageObject.ids)
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
        if (!movementBlocked && canPickUp) {
            canPickUp = false
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
            enemiesPunchScript.sendMessage({
                                              "objects": entGen.objects,
                                              "index": entity.parent.entityIndex
                                          })
        }
    }

    function interaction() {
        if (!interactionBlocked) {
            deadEnemiesScanScript.sendMessage({
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
