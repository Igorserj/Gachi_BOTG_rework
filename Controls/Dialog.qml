import QtQuick 2.15

Rectangle {
    id: dialog
    property string mainText: ""
    property var objects: []
    color: style.blackGlass
    width: buttonRow.width * 1.05
    height: childrenRect.height + width * 0.05
    opacity: 0
    radius: width / 8

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle {
            id: mainTextRect
            clip: true
            color: "transparent"
            width: buttonRow.width
            anchors.margins: buttonRow.width * 0.05
            height: 0.2 * parent.width
            Text {
                id: mainTextText
                text: mainText
                height: parent.height
                width: parent.width
                fontSizeMode: Text.VerticalFit
                font.pointSize: 72
                font.family: fontName
                color: "white"
                font.bold: true
                horizontalAlignment: contentWidth > mainTextRect.width ? Text.AlignLeft : Text.AlignHCenter
                SequentialAnimation {
                    running: (mainTextText.contentWidth > mainTextRect.width) && opacity === 1
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

        Row {
            id: buttonRow
            spacing: width * 0.05
            Repeater {
                model: objects
                Button1 {
                    text: modelData
                    buttonArea.onClicked: actionSet(index)
                }
            }
        }
    }

    Styles {
        id: style
    }

    function show() {
        opacity = 1
        enabled = true
    }
    function hide() {
        opacity = 0
        enabled = false
    }
    function actionSet(index) {}
}
