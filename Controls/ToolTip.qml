import QtQuick 2.15

Rectangle {
    id: toolTip
    property string mainText: ""
    property string addText: ""
    color: style.blackGlass
    width: 0.15 * window.recalculatedWidth
    height: childrenRect.height + width * 0.05
    opacity: 0
    radius: width / 8
    onHeightChanged: borderVDetect()
    onWidthChanged: borderHDetect()
    onYChanged: borderVDetect()
    onXChanged: borderHDetect()
    Rectangle {
        id: mainTextRect
        clip: true
        color: "transparent"
        width: parent.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        height: 0.2 * parent.width
        Text {
            id: mainTextText
            text: mainText
            height: parent.height
            width: parent.width
            fontSizeMode: Text.VerticalFit
            font.pointSize: 72
            font.family: comfortaaName
            color: "white"
            font.bold: true
            horizontalAlignment: contentWidth > mainTextRect.width ? Text.AlignLeft : Text.AlignHCenter
            SequentialAnimation {
                id: mainTextTextAnimation
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
        color: style.blackGlass//"#22000000"
        radius: parent.width / 16
        Text {
            id: addTextText
            text: addText
            x: (parent.width - contentWidth) / 2
            width: parent.width
            font.pixelSize: mainTextText.contentHeight * 0.5
            font.family: comfortaaName
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
            ScriptAction {
                script: opacity === 0 ? [x = 0, y = 0, mainText = "", addText = ""] : {}
            }
        }
    }

    Styles {
        id: style
    }

    function borderVDetect() {
        if (y + height > loader.y + loader.height) {
            y = loader.y + loader.height - height - 1
        }
        else if (y < loader.y) {
            y = loader.y + 1
        }
    }

    function borderHDetect() {
        if (x + width > loader.x + recalculatedWidth) {
            x = loader.x + recalculatedWidth - width - 1
        }
        else if (x < loader.x) {
            x = loader.x + 1
        }
    }

    function show(x1 = 0, y1 = 0) {
        toolTip.x = x1
        toolTip.y = y1
        opacity = 1
        if (mainTextTextAnimation.running) mainTextTextAnimation.complete()
        mainTextTextAnimation.running = mainTextText.contentWidth > mainTextRect.width
    }

    function hide() {
        if (mainTextTextAnimation.running) mainTextTextAnimation.complete()
        opacity = 0
    }
}
