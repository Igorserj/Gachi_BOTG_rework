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
//    radius: width / 8
//    clip: true
//    color: "#9E9E9E"
//    Rectangle {
//        id: frontRect
//        width: parent.width * 0.9
//        height: parent.height * 0.9
//        anchors.centerIn: parent
//        radius: width / 8
//        visible: false
//        color: style.darkGlass
//    }
//    FastBlur {
//        anchors.fill: frontRect
//        source: frontRect
//        radius: 32
//        transparentBorder: true
//    }

//    Text {
//        id: cellText
//        anchors.fill: parent
//        verticalAlignment: Text.AlignVCenter
//        horizontalAlignment: Text.AlignHCenter
//        color: "white"
//        text: cl.itemName()
//    }
//    MouseArea {
//        anchors.fill: parent
//        hoverEnabled: !invItem.visible
//        acceptedButtons: Qt.LeftButton | Qt.RightButton
//        onEntered: cl.showToolTip()
//        onExited: toolTip.hide()
//        onClicked: cl.showContextMenu(mouseX, mouseY, mouse.button)
//        onHoverEnabledChanged: if (!hoverEnabled) toolTip.hide()
//    }
    InventoryCellView {
        id: cellView
        type: cell.type
        cellText: cl.itemName()
        cellArea.onEntered: cl.showToolTip()
        cellArea.onExited: toolTip.hide()
        cellArea.onClicked: cl.showContextMenu(cellArea.mouseX, cellArea.mouseY, mouse.button)
        cellArea.onHoverEnabledChanged: if (!cellArea.hoverEnabled) toolTip.hide()
    }

    CellLogic {
        id: cl
    }
}
