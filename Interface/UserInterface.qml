import QtQuick 2.15
import "Indicators"
import "../Controls"

Item {
    id: ui
    property var entGen: levelLoader.item.entGen
    property alias contextMenu: contextMenu
    Column {
        spacing: ui.height * 0.03
        Repeater {
            id: heroesRepeater
            Column {
                NameFrame {
                    name: entGen.metadata[index].name
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
                    hpColor: "#AA3333"//"red"
                }
            }
        }
    }
    ContextMenu {
        id: contextMenu
        opacity: 0
        property var variable
        function actionSet(index = -1) {
            if (set === 0) {
                actionSet1(index)
            }
        }

        function actionSet1(index) {
            iface.state = "inventory"
            interfaceLoader.item.usedByEntity = entGen.repeater.itemAt(variable[index]).item
            interfaceLoader.item.heroEntity = entGen.repeater.itemAt(0).item
        }
    }

    function heroes() {
        const entityList = entGen.objects
        const entities = entGen.repeater
        let entitiesProperties = []
        let entitiesProperties2 = []
        for (let i = 0; i < entityList.length; i++) {
            if (entityList[i][0] === "hero") {
                let items = []
                let buffs = []
                var buffRep = entities.itemAt(i).item.buffList.repeater
                for (let j = 0; j < entities.itemAt(i).item.buffList.currentBuffs.length; j++) {
                    let buff = []
                    buff.push(buffRep.itemAt(j).item.timeLeft, buffRep.itemAt(j).item.name, buffRep.itemAt(j).item.description)
                    buffs.push(buff)
                }
                items.push(entities.itemAt(i).item.health, entities.itemAt(i).item.maxHealth, entities.itemAt(i).item.stamina, entities.itemAt(i).item.maxStamina, buffs)
                entitiesProperties.push(items)
            } else if (entityList[i][0] === "hostile") {
                let items = []
                items.push(entities.itemAt(i).item.health, entities.itemAt(i).item.maxHealth)
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
