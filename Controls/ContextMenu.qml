import QtQuick 2.15

Rectangle {
    id: contextMenu
    property var objects: []
    property var obj
    property int set: -1
    property var activeCells: []
    color: style.blackGlass
    height: 0
    width: 0
    radius: width / 8
    opacity: 0
    Column {
        x: (childrenRect.width * 0.05) / 2
        y: x
        Repeater {
            id: rep
            Column {
                Rectangle {
                    id: option
                    width: 0.15 * loader.width
                    height: loader.height * 0.05
                    color: enabled ? "transparent" : "#38000000"
                    enabled: typeof(activeCells[index]) !== "undefined" ? activeCells[index] : true
                    radius: width / 10
                    clip: true
                    Component.onCompleted: {
                        contextMenu.height += height
                        contextMenu.width = width
                        if (index === rep.model.length - 1) show2()
                    }

                    Text {
                        id: optionText
                        height: parent.height
                        width: parent.width
                        text: modelData
                        font.pointSize: 72
                        font.family: comfortaaName
                        color: option.enabled ? "white" : "#FFCCCCCC"
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
                        enabled: option.enabled
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
        if (x + width > loader.x + loader.width) {
            x = loader.x + loader.width - width - 1
        }
        else if (x < loader.x) {
            x = loader.x + 1
        }
    }

    function actionSet(index) {}
    function show(x1 = 0, y1 = 0) {
        x = x1
        y = y1
        rep.model = objects
    }
    function show2() {
        height += width * 0.05
        width *= 1.05
        borderHDetect()
        borderVDetect()
        opacity = 1
        toolTip.hide()
    }

    function hide() {
        opacity = 0
        x = 0
        y = 0
        height = 0
        width = 0
        rep.model = []
        activeCells = []
        set = -1
    }

}
