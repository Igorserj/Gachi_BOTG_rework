import QtQuick 2.15
import "Indicators"

Item {
    id: ui
    property var entGen: levelLoader.item.entGen
    Column {
        spacing: ui.height * 0.03
        Repeater {
            id: heroesRepeater
            Column {
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
            HealthBar {
                hpColor: "red"
            }
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
