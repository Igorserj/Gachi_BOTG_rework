import QtQuick 2.15
import "Indicators"

Item {
    property var entGen: levelLoader.item.entGen
    Column {
        spacing: parent.height * 0.03
        Repeater {
            id: heroesRepeater
            Column {
                HealthBar {}
                StaminaBar {}
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
                items.push(entities.itemAt(i).item.health, entities.itemAt(i).item.maxHealth, entities.itemAt(i).item.stamina, entities.itemAt(i).item.maxStamina)
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
    Component.onCompleted: heroes()
}
