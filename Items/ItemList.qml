import QtQuick 2.15

Item {
    readonly property var itemNames: ["Vodka", "Bat", "Hat", "Jacket", "Jeans", "Sneakers"]
    readonly property var items: [vodka, bat, hat, jacket, jeans, sneakers]
    readonly property var types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var equipmnets: ["Head", "Body", "Legs", "Feet", "One Hand", "One Hand", "Two Hands"]
    property alias customItem: customItem
    visible: false

    Repeater {
        id: customItem
        property var pool: []
        model: []
//      properties = [{type: "", name: "", additionalInfo: "", buffName: "", points: 0, usedByEntity: undefined, action = "use", permanent = false}]

        ItemPattern {
            type: modelData.type !== undefined ? modelData.type : ""
            name: modelData.name !== undefined ? modelData.name : ""
            additionalInfo: modelData.additionalInfo !== undefined ? modelData.additionalInfo : ""
            buffName: modelData.buffName !== undefined ? modelData.buffName : ""
            points: modelData.points !== undefined ? modelData.points : 0
            hp: modelData.hp !== undefined ? modelData.hp : 0
            defense: modelData.defense !== undefined ? modelData.defense : 0
            // usedByEntity: modelData.usedByEntity !== undefined ? modelData.usedByEntity : undefined
            Component.onCompleted: {
                let permanent
                let reversible
                if (modelData.permanent === undefined) permanent = false
                else permanent = modelData.permanent

                if (modelData.reversible === undefined) reversible = false
                else reversible = modelData.reversible

                if (modelData.action === "use") {
                    use(permanent, modelData.usedByEntity)
                }
                else if (modelData.action === "remove") {
                    removeEffect(permanent, reversible, modelData.usedByEntity)
                }
                customItem.pool.shift()
                customItem.modelUpdate()
            }
        }

        function modelUpdate() {
            if (pool.length > 0) {
                customItem.model = [pool[0]]
            }
        }
    }

    ItemPattern {
        id: hat
        type: types[0]
        name: locale.itemNames[0]
        additionalInfo: locale.itemAddInfo[0]
        defense: 5
    }

    ItemPattern {
        id: vodka
        type: types[6]
        name: locale.itemNames[1]
        additionalInfo: locale.itemAddInfo[1]
        buffName: "SpeedUp"
    }

    ItemPattern {
        id: bat
        type: types[5]
        name: locale.itemNames[2]
        additionalInfo: locale.itemAddInfo[2]
        buffName: "StrengthUp"
    }

    ItemPattern {
        id: jacket
        type: types[1]
        name: locale.itemNames[3]
        additionalInfo: locale.itemAddInfo[3]
        defense: 1
    }

    ItemPattern {
        id: jeans
        type: types[2]
        name: locale.itemNames[4]
        additionalInfo: locale.itemAddInfo[4]
        defense: 1
    }

    ItemPattern {
        id: sneakers
        type: types[3]
        name: locale.itemNames[5]
        additionalInfo: locale.itemAddInfo[5]
        defense: 1
    }
}
