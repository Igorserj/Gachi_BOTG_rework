import QtQuick 2.15
import "Indicators"
import "../Controls"
import "Inventory"

Item {
    id: ui
    property var entGen: levelLoader.item.roomLoader.item.entGen
    property alias contextMenu: contextMenu
    property alias inventoryLoader: inventoryLoader
    property var usedByEntity
    property var heroEntity

    function openInventory(entity1, entity2) {
        usedByEntity = entity1
        heroEntity = entity2
        inventoryLoader.sourceComponent = inventory
    }
    function closeInventory() {
        inventoryLoader.sourceComponent = undefined
    }
    Loader {
        id: inventoryLoader
        anchors.fill: parent
        asynchronous: true
        onStatusChanged: status === Loader.Null ? toolTip.hide() : {}
    }
    Component {
        id: inventory
        Inventory {
            inventoryCells: entGen.repeater.itemAt(0).item.inventory.inventoryCells
            equipmentCells: entGen.repeater.itemAt(0).item.inventory.equipmentCells
        }
    }

    Column {
        spacing: ui.height * 0.03
        Repeater {
            id: heroesRepeater
            Column {
                NameFrame {
                    name: entGen.repeater.itemAt(index).item.name
                }
                HealthBar {}
                StaminaBar {}
                Row {
                    spacing: ui.width * 0.003
                    Repeater {
                        model: modelData[4]
                        Buffs {}
                    }
                }
            }
        }
    }
    Column {
        spacing: parent.height * 0.03
        anchors.right: parent.right
        Repeater {
            id: hostilesRepeater
            Column {
                NameFrame {
                    name: entGen.metadata[index + 1].name
                }
                HealthBar {
                    hpColor: "#AA3333"
                    leftAlign: false
                }
                StaminaBar {}
                Row {
                    spacing: ui.width * 0.003
                    Repeater {
                        model: modelData[4]
                        Buffs {}
                    }
                }
            }
        }
    }

    ContextMenu {
        id: contextMenu
        opacity: 0

        Connections {
            target: entGen.repeater.itemAt(0)
            function onXChanged() {contextMenu.hide()}
            function onYChanged() {contextMenu.hide()}
        }

        function actionSet(index = -1) {
            if (set === 0) {
                actionSet1(index)
            }
        }

        function actionSet1(index) {
            if (entGen.objects[obj[index]][0] === "hostile") {
                inventoryOpen(obj, index)
            }
            else if (entGen.objects[obj[index]][0] === "npc") {
                dialogueOpen(obj, index)
            }
            else if (entGen.objects[obj[index]][0] === "interact") {
                entGen.repeater.itemAt([obj[index]][0]).item.interactLoader.item.interaction(entGen.repeater.itemAt(0))
            }
        }
    }

    function inventoryOpen(obj, index) {
        interfaceLoader.item.openInventory(entGen.repeater.itemAt(obj[index]).item, entGen.repeater.itemAt(0).item)
    }

    function dialogueOpen(index = 0, index2) {
        iface.state = "dialogue"
        ifaceLoader.item.interfaceLoader.item.entity1 = entGen.repeater.itemAt(index).item
        if (!!index2) ifaceLoader.item.interfaceLoader.item.entity2 = entGen.repeater.itemAt(index2).item
    }

    function heroes() {
        const entityList = entGen.objects
        const entities = entGen.repeater
        let entitiesProperties = []
        let entitiesProperties2 = []
        let items = []
        let buffs = []
        let buff = []
        let buffRep
        let j = 0
        for (let i = 0; i < entityList.length; i++) {
            if (entityList[i][0] === "hero") {
                items = []
                buffs = []
                buffRep = entities.itemAt(i).item.buffList.repeater
                for (j = 0; j < entities.itemAt(i).item.buffList.currentBuffs.length; j++) {
                    if (buffRep.itemAt(j) !== null) {
                        buff = []
                        buff.push(buffRep.itemAt(j).item.timeLeft, buffRep.itemAt(j).item.name, buffRep.itemAt(j).item.description)
                        buffs.push(buff)
                    }
                }
                items.push(entities.itemAt(i).item.health, entities.itemAt(i).item.maxHealth, entities.itemAt(i).item.stamina, entities.itemAt(i).item.maxStamina, buffs)
                entitiesProperties.push(items)
            } else if (entityList[i][0] === "hostile") {
                items = []
                buffs = []
                buffRep = entities.itemAt(i).item.buffList.repeater
                for (j = 0; j < entities.itemAt(i).item.buffList.currentBuffs.length; j++) {
                    buff = []
                    buff.push(buffRep.itemAt(j).item.timeLeft, buffRep.itemAt(j).item.name, buffRep.itemAt(j).item.description)
                    buffs.push(buff)
                }
                items.push(entities.itemAt(i).item.health, entities.itemAt(i).item.maxHealth, entities.itemAt(i).item.stamina, entities.itemAt(i).item.maxStamina, buffs)
                entitiesProperties2.push(items)
            }
        }
        heroesRepeater.model = entitiesProperties
        hostilesRepeater.model = entitiesProperties2
    }
    Timer {
        running: true
        repeat: true
        interval: 250
        onTriggered: heroes()
    }
    Component.onCompleted: heroes()
}
