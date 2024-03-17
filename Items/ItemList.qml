import QtQuick 2.15

Item {
    readonly property var itemNames: []
    readonly property var types: ["Head", "Body", "Legs", "Feet", "One Hand", "Two Hands", "Consumable"]
    readonly property var equipments: ["Head", "Body", "Legs", "Feet", "One Hand", "One Hand", "Two Hands"]
    property alias customItem: customItem
    visible: false

    Repeater {
        id: customItem
        property var pool: []
        model: [] // EXAMPLE [{type: "", name: "", additionalInfo: "", buffName: "", points: 0, usedByEntity: undefined, action = "use", permanent = false}]
            ItemPattern {
                type: modelData.type !== undefined ? modelData.type : ""
                name: modelData.name !== undefined ? modelData.name : ""
                additionalInfo: modelData.additionalInfo !== undefined ? modelData.additionalInfo : ""
                buffName: modelData.buffName !== undefined ? modelData.buffName : ""
                points: modelData.points !== undefined ? modelData.points : 0
                hp: modelData.hp !== undefined ? modelData.hp : 0
                defense: modelData.defense !== undefined ? modelData.defense : 0
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
}
