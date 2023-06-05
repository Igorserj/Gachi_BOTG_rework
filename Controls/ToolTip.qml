import QtQuick 2.15

Rectangle {
    id: toolTip
    property string mainText: ""
    property string addText: ""
    color: "#DD363436"
    width: 0.15 * window.width
    height: childrenRect.height + width * 0.05
    opacity: 0
    radius: width / 8
    Rectangle {
        id: mainTextRect
        clip: true
        color: "transparent"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: parent.width * 0.05
        height: 0.2 * parent.width
        Text {
            id: mainTextText
            text: mainText
            height: parent.height
            width: parent.width
            fontSizeMode: Text.VerticalFit
            font.pointSize: 72
            font.family: "Comfortaa"
            color: "white"
            font.bold: true
            horizontalAlignment: contentWidth > mainTextRect.width ? Text.AlignLeft : Text.AlignHCenter
            SequentialAnimation {
                running: mainTextText.contentWidth > mainTextRect.width
                loops: Animation.Infinite
                PauseAnimation {
                    duration: 1000
                }
                PropertyAnimation {
                    target: mainTextText
                    property: "x"
                    from: 0
                    to: - mainTextText.contentWidth + mainTextRect.width
                    duration: mainTextText.contentWidth / mainTextRect.width * 1000
                }
                PauseAnimation {
                    duration: 1000
                }
                PropertyAnimation {
                    target: mainTextText
                    property: "x"
                    from: - mainTextText.contentWidth + mainTextRect.width
                    to: 0
                    duration: mainTextText.contentWidth / mainTextRect.width * 500
                }
            }
        }
    }
    Rectangle {
        color: "white"
        height: mainTextRect.height * 0.05
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: mainTextRect.bottom
    }
    Rectangle {
        clip: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: mainTextRect.bottom
        height: addTextText.contentHeight
        anchors.margins: parent.width * 0.05
        color: "#22000000"
        radius: parent.width / 16
        Text {
            id: addTextText
            text: addText
            x: (parent.width - contentWidth) / 2
            width: parent.width
            font.pixelSize: mainTextText.contentHeight * 0.5
            font.family: "Comfortaa"
            color: "white"
            wrapMode: Text.WordWrap
        }
    }

    Behavior on opacity {
        SequentialAnimation {
            PropertyAnimation {
                target: toolTip
                property: "opacity"
                duration: 250
            }
            ScriptAction {script: opacity === 0 ? [x = 0, y = 0, mainText = "", addText = ""] : {}}
        }
    }

    function show(x1 = 0, y1 = 0) {
        toolTip.x = x1
        toolTip.y = y1
        opacity = 1
    }

    function hide() {
        opacity = 0
    }

}
