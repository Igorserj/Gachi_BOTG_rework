import QtQuick 2.15

Rectangle {
    id: cell
    property string type: ""
    height: invInterface.height / 7
    width: height
    radius: width / 8
    clip: true
    Text {
        id: cellText
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: if (itemList.types.includes(type)) equipmentCells[index]; else inventoryCells[(row.colIndex * 5 + index)]
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: {
            if (itemList.types.includes(type)) {
                var cells = equipmentCells[index]
                if (cells !== "") {
                    const i = itemList.itemNames.indexOf(cells)
                    toolTip.mainText = itemList.items[i].name
                    toolTip.addText = itemList.items[i].additionalInfo
                    toolTip.show(cell.x + cell.width + equipRow.x, equipRow.y)
                }
            }
            else {
                var cells = inventoryCells[(parent.parent.colIndex * 5 + index)]
                if (cells !== "") {
                    const i = itemList.itemNames.indexOf(cells)
                    toolTip.mainText = itemList.items[i].name
                    toolTip.addText = itemList.items[i].additionalInfo
                    toolTip.show(cell.x + cell.width + col.x, row.y + col.y)
                }
            }
        }
        onExited: toolTip.hide()
        onClicked: {
            if (mouse.button === Qt.RightButton && contextMenu.opacity === 0 && cellText.text !== "") {
                contextMenu.objects = options
//                contextMenu.actionSet()
                if (itemList.types.includes(type)) contextMenu.show(cell.x + mouseX + equipRow.x, mouseY + equipRow.y)
                else contextMenu.show(col.x + cell.x + mouseX, row.y + col.y + mouseY)
            }
            else contextMenu.hide()
        }
    }

    function actionSet() {
        if (index === 0) moveItem()
        else if (index === 1) dropItem()
    }
    function moveItem() {
        inventoryArea.enabled = true
    }
    function dropItem() {

    }
}
