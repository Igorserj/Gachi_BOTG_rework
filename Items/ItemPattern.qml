import QtQuick 2.15

QtObject {
    property string type: ""
    property string name: ""
    property string additionalInfo: ""
    property string buffName: ""
    property bool isEquipment: equipmnets.includes(type)
    property var usedByEntity

    function use(permanent = false) {
//        console.log(buffName)
        if (buffName !== "") {
            usedByEntity.buffList.updateBuffs(buffName, -1, permanent)
        }
    }
    function removeEffect(permanent = false) {
        let buffList = usedByEntity.buffList.currentBuffs
        for (let i = 0; i < buffList.length; i++) {
            if (buffName === buffList[i][0] && permanent === buffList[i][2]) {
                usedByEntity.buffList.updateBuffs(buffName, i, permanent)
            }
        }
    }
}
