import QtQuick 2.15

Rectangle {
    id: contextMenu
    property var objects: []
    height: childrenRect.height + childrenRect.width * 0.05
    width: childrenRect.width * 1.05
    color: "#DD363436"
    radius: width / 8
    opacity: 0
    Column {
        x: (childrenRect.width * 0.05) / 2
        y: x
        Repeater {
            model: contextMenu.objects
            Column {
                Rectangle {
                    id: option
                    width: 0.15 * window.width
                    height: window.height * 0.05
                    color: "transparent"
                    clip: true
                    Text {
                        id: optionText
                        height: parent.height
                        width: parent.width
                        text: modelData
                        font.pointSize: 72
                        font.family: "Comfortaa"
                        color: "white"
                        fontSizeMode: Text.VerticalFit
                        horizontalAlignment: contentWidth > option.width ? Text.AlignLeft : Text.AlignHCenter
                        SequentialAnimation {
                            running: (optionText.contentWidth > option.width) && contextMenu.opacity === 1
                            loops: Animation.Infinite
                            PauseAnimation {
                                duration: 1000
                            }
                            PropertyAnimation {
                                target: optionText
                                property: "x"
                                from: 0
                                to: - optionText.contentWidth + option.width
                                duration: optionText.contentWidth / option.width * 1000
                            }
                            PauseAnimation {
                                duration: 1000
                            }
                            PropertyAnimation {
                                target: optionText
                                property: "x"
                                from: - optionText.contentWidth + option.width
                                to: 0
                                duration: optionText.contentWidth / option.width * 500
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            actionSet(index)
                            contextMenu.hide()
                        }
                    }
                }
                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: index === objects.length - 1 ? 0 : option.height * 0.05
                    color: "white"
                }
            }
        }
    }
    function actionSet(index) {}
    function show(x1 = 0, y1 = 0) {
        contextMenu.x = x1
        contextMenu.y = y1
        contextMenu.opacity = 1
    }

    function hide() {
        contextMenu.x = 0
        contextMenu.y = 0
        contextMenu.opacity = 0
    }
}
