import QtQuick 2.15
import "../../Controls"

Rectangle {
    id: invItem
    property string itemName: ""
    property int index: -1
    property bool isEquipment: false
    property var metadata
    property string itemName2: ""
    visible: inventoryArea.enabled && itemName !== ""
    height: invInterface.height / 7
    width: height
    radius: width / 8
    color: style.blackGlass
    x: inventoryArea.mouseX - width / 2
    y: inventoryArea.mouseY - height / 2

    Styles {
        id: style
    }
}
