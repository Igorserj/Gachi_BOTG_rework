import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: cell
    property string type: ""
    readonly property int currentIndex: parent.colIndex * 5 + index
    property bool isEquipment: itemList.equipmnets.includes(type)
    property alias cl: cl
    height: invInterface.height / 7
    width: height

    InventoryCellView {
        id: cellView
        type: cell.type
        cellText: cl.itemName()
        cellArea.onEntered: cl.showToolTip()
        cellArea.onExited: toolTip.hide()
        cellArea.onClicked: cl.showContextMenu(inventoryArea.mouseX, inventoryArea.mouseY, mouse.button)
        cellArea.onHoverEnabledChanged: if (!cellArea.hoverEnabled) toolTip.hide()
    }

    CellLogic {
        id: cl
    }
    WorkerScript {
        id: ws
        source: "dropItem.mjs"
        onMessage: if (messageObject.canBePlaced) cl.dropping(messageObject.item)
    }
    WorkerScript {
        id: ws2
        source: "equipItem.mjs"
        onMessage: {
            invItem.itemName = messageObject.itemName
            invItem.index = messageObject.index
            invItem.isEquipment = messageObject.isEquipment
            invItem.metadata = messageObject.metadata
            cl.equiped(messageObject.isSwappable, messageObject.type, messageObject.name)
        }
    }
}
