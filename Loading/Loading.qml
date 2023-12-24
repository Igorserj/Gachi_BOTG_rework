import QtQuick 2.15
import "Stairs"
import "Passes"

Item {
    id: loading
    property string source: ""
    property var objects: []
    property alias load: load
    visible: false
//    visible: !!loader.item.levelLoader ? loader.item.levelLoader.item ? !loader.item.levelLoader.item.roomLoader.visible : false : false
    onSourceChanged: {
        if (source === "downstairs") { load.sourceComponent = downstairs }
        else if (source === "upstairs") { load.sourceComponent = upstairs }
        else if (source === "leftpass") { load.sourceComponent = leftpass }
        else if (source === "rightpass") { load.sourceComponent = rightpass }
        else if (source === "") { load.sourceComponent = undefined }
    }
    Loader {
        id: load
        width: window.width
    }

    Component {
        id: upstairs
        Upstairs {}
    }
    Component {
        id: downstairs
        Downstairs {}
    }

    Component {
        id: leftpass
        Leftpass {}
    }
    Component {
        id: rightpass
        Rightpass {}
    }
}
