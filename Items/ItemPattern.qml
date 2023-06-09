import QtQuick 2.15

QtObject {
    property string type: ""
    property string name: ""
    property string additionalInfo: ""
    property string buffName: ""
    property var usedByEntity

    function use() {
        usedByEntity.buffList.currentBuffs.push(buffName)
        usedByEntity.buffList.repeater.model = usedByEntity.buffList.currentBuffs
    }
}
