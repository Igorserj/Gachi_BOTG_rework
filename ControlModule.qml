import QtQuick 2.15

Item {
    property int createdComponents: 0
    property int currentIndex: -1
    property bool activate: false
    focus: true
    Keys.onTabPressed: if (currentIndex + 1 >= createdComponents) currentIndex = 0; else currentIndex++
    Keys.onBacktabPressed: if (currentIndex - 1 < 0) currentIndex = createdComponents; else currentIndex--
    Keys.onReleased: {
        if (event.key === Qt.Key_Space) {
            activate = false
        }
    }
    Keys.onPressed: {
        if (event.key === Qt.Key_Space) {
            activate = true
        }
        if (loader.sourceComponent === menuCompose) {
            if (event.key === Qt.Key_Escape) {
                if (loader.item.state === "home") exitDialogLoader.sourceComponent = exitDialog
                else loader.item.state = "home"
            }
        }
    }
}
