import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../../Controls"

Rectangle {
    property string type: ""
    property alias cellText: cellText.text
    property alias cellArea: cellArea
    readonly property int currentIndex: parent.currentIndex//parent.colIndex * 5 + index
    property bool isEquipment: itemList.equipmnets.includes(type)
    height: invInterface.height / 7
    width: height
    radius: width / 8
    clip: true
    color: "#9E9E9E"
    Rectangle {
        id: frontRect
        width: parent.width * 0.9
        height: parent.height * 0.9
        anchors.centerIn: parent
        radius: width / 8
        visible: false
        color: style.darkGlass
    }
    FastBlur {
        anchors.fill: frontRect
        source: frontRect
        radius: 32
        transparentBorder: true
    }

    Text {
        id: cellText
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
    }
    MouseArea {
        id: cellArea
        anchors.fill: parent
        hoverEnabled: !invItem.visible
        acceptedButtons: Qt.LeftButton | Qt.RightButton
    }

    Styles {
        id: style
    }
}
