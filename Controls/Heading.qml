import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    property alias head: head
    height: head.height
    width: head.width
    y: window.visibility === 2 ? 0 : -height
    Rectangle {
        id: head
        width: window.width
        height: 0.05 * window.height
        color: style.grayGlass

        MouseArea {
            id: headArea
            property point clickPos: "1,1"
            width: parent.width
            height: parent.height
            onPressed: {
                clickPos  = Qt.point(mouseX,mouseY)
            }

            onPositionChanged: {
                let delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                window.x += delta.x
                window.y += delta.y
            }
        }
    }

    Rectangle {
        color: "transparent"
        anchors.fill: parent
        Row {
            x: (parent.width - width) / 2
            anchors.verticalCenter: parent.verticalCenter
            Text {
                height: head.height * 0.95
                width: contentWidth
                text: "Gachimuchi: Boss of this gym"
                font.pointSize: 100
                color: "white"
                fontSizeMode: Text.VerticalFit
            }
        }
        Row {
            id: windowControl
            anchors.verticalCenter: parent.verticalCenter
            spacing: head.height * 0.3
            x: parent.width - width - spacing
            Repeater {
                model: ["⎼", "□", "⨯"]
                Button1 {
                    height: head.height * 0.7
                    width: height
                    text: modelData
                    buttonArea.onClicked: {
                        if (index === 0) {
                            window.showMinimized()
                        }
                        else if (index === 1) {
                            changeVisibility()
                        }
                        else if (index === 2) {
                            window.close()
                        }
                    }
                }
            }
        }
    }

    function changeVisibility() {
        if (opSave.settings.screenProps.visibility === 2) {
            opSave.settings.screenProps.visibility = 5
            window.showFullScreen()
        }
        else if (opSave.settings.screenProps.visibility !== 2) {
            opSave.settings.screenProps.visibility = 2
            window.showNormal()
        }
        if (loader.item.state === "settings") {
            loader.item.composeLoader.item.visibilittyCheck()
        }
    }

    Styles {
        id: style
    }
}
