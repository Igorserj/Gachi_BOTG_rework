import QtQuick 2.15

Item {
    property string type: ""
    property string name: ""
    property string additionalInfo: ""
    property string buffName: ""
    property int points: 0
    property bool isEquipment: equipmnets.includes(type)
    property var usedByEntity

    function use(permanent = false) {
//        console.log("use")
        if (buffName !== "") {
            usedByEntity.buffList.updateBuffs(buffName, -1, permanent, points)
        }
    }
    function removeEffect(permanent = false) {
//        console.log("remove")
        let buffList = usedByEntity.buffList.currentBuffs
        for (let i = 0; i < buffList.length; i++) {
            if (buffName === buffList[i][0] && permanent === buffList[i][2]) {
                usedByEntity.buffList.updateBuffs(buffName, i, permanent, 0)
            }
        }
    }
}
