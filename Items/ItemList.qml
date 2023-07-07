import QtQuick 2.15

Item {
    readonly property var itemNames: ["Vodka", "Bat", "Hat"]
    readonly property var items: [vodka, bat, hat]
    readonly property var types: ["Head", "Body", "Legs", "One Hand", "Two Hands", "Consumable"]
    readonly property var equipmnets: ["Head", "Body", "Legs", "One Hand", "One Hand", "Two Hands"]
    property alias customItem: customItem
    visible: false

    Repeater {
        id: customItem
        property var pool: []
        model: []
//        onPoolChanged: modelUpdate()
//      properties = [{type: "", name: "", additionalInfo: "", buffName: "", points: 0, usedByEntity: undefined, action = "use", permanent = false}]

        ItemPattern {
            type: modelData.type !== undefined ? modelData.type : ""
            name: modelData.name !== undefined ? modelData.name : ""
            additionalInfo: modelData.additionalInfo !== undefined ? modelData.additionalInfo : ""
            buffName: modelData.buffName !== undefined ? modelData.buffName : ""
            points: modelData.points !== undefined ? modelData.points : 0
            hp: modelData.hp !== undefined ? modelData.hp : 0
            defense: modelData.defense !== undefined ? modelData.defense : 0
            usedByEntity: modelData.usedByEntity !== undefined ? modelData.usedByEntity : undefined
            Component.onCompleted: {
                let permanent
                let reversible
                if (modelData.permanent === undefined) permanent = false
                else permanent = modelData.permanent

                if (modelData.reversible === undefined) reversible = false
                else reversible = modelData.reversible

                if (modelData.action === "use") {
                    use(permanent)
                }
                else if (modelData.action === "remove") {
                    removeEffect(permanent, reversible)
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
        name: "Hat"
        additionalInfo: "Just a normal hat"
        buffName: "HealthUp"
    }

    ItemPattern {
        id: vodka
        type: types[5]
        name: "Vodka"
        additionalInfo: "Vodka don't need to be presented"
        buffName: "StrengthUp"
    }

    ItemPattern {
        id: bat
        type: types[4]
        name: "Bat"
        additionalInfo: "Beat them up!"
        buffName: "SpeedUp"
    }
}
