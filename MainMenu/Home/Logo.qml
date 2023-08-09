import QtQuick 2.15

Rectangle {
    width: height * 2
    color: "transparent"
    Text {
        id: gachi
//        anchors.top: parent.top
        font.family: "Monoton"
        height: parent.height / 2.4
        anchors.left: parent.left
        anchors.right: parent.right
        fontSizeMode: Text.Fit
        text: "Gachimuchi"
        font.pointSize: 100
        color: "white"
        y: (parent.height - (height+boss.height))/2
    }

    Text {
        id: boss
        anchors.top: gachi.bottom
        anchors.leftMargin: gachi.width*0.237//228
        anchors.topMargin: -gachi.height*0.35//-77
        font.family: "Monoton"
        height: parent.height / 3.1
        width: parent.width / 3.1
        anchors.left: parent.left
        fontSizeMode: Text.Fit
        text: "Boss"
        font.pointSize: 100
        color: "white"
    }

    Text {
        id: of
        anchors.left: boss.right
        anchors.bottom: boss.bottom
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignTop
        lineHeight: 0.65
        font.family: "Monoton"
        height: parent.height / 3.3
        width: parent.width / 7
        fontSizeMode: Text.Fit
        text: "Of\nThis"
        font.pointSize: 100
        color: "white"
    }

    Text {
        anchors.top: boss.top
        font.family: "Monoton"
        height: parent.height / 3.1
        width: parent.width / 3.1
        anchors.left: of.right
        fontSizeMode: Text.Fit
        text: "Gym"
        font.pointSize: 100
        color: "white"
    }
}
