import QtQuick 2.15

Item {
    property string type: ""
    property string name: ""
    property string additionalInfo: ""
    property string buffName: ""
    property int points: 0
    property int hp: 0
    property int defense: 0
    property bool isEquipment: equipments.includes(type)

    function use(permanent = false, usedByEntity) {
        if (buffName !== "") {
            usedByEntity.buffList.updateBuffs(buffName, -1, permanent, points, false, 0)
        }
        if (hp > 0) {
            usedByEntity.buffList.updateBuffs("HealthHeal", -1, true, hp, false, 0)
        }
        if (defense > 0) {
            usedByEntity.buffList.updateBuffs("DefenseUp", -1, true, defense, false, 0)
        }
    }
    function removeEffect(permanent = false, reversible = false, usedByEntity) {
        let buffList = usedByEntity.buffList.currentBuffs
        for (let i = 0; i < buffList.length; i++) {
            if (buffName === buffList[i][0] && permanent === buffList[i][2]) {
                usedByEntity.buffList.updateBuffs(buffName, i, permanent, points, reversible)
            }
        }
        if (permanent && reversible) {
            usedByEntity.buffList.updateBuffs(buffName, -1, true, points, true)
            if (hp > 0) {
                usedByEntity.buffList.updateBuffs("HealthHeal", -1, true, hp, true)
            }
            if (defense > 0) {
                usedByEntity.buffList.updateBuffs("DefenseUp", -1, true, defense, true)
            }
        }
        console.log(usedByEntity.buffList.currentBuffs)
    }
}
