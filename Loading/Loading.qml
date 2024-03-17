import QtQuick 2.15
import "Stairs"
import "Passes"
import "Doors"

Item {
    id: loading
    property string source: ""
    property var objects: []
    visible: false
    onSourceChanged: {
        if (source === "downstairs") { load.sourceComponent = downstairs }
        else if (source === "upstairs") { load.sourceComponent = upstairs }
        else if (source === "leftpass") { load.sourceComponent = leftpass }
        else if (source === "rightpass") { load.sourceComponent = rightpass }
        else if (source === "frontdoor" || source === "backdoor") { load.sourceComponent = doors }
        else if (source === "instant") { load.sourceComponent = instant }
        else if (source === "") { load.sourceComponent = undefined }
    }

    Loader {
        id: load
        width: loader.width
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

    Component {
        id: doors
        Doors {}
    }

    Component {
        id: instant
        Item {
            Component.onCompleted: {
                loader.item.levelLoader.item.currentRoom = ""
                loader.item.levelLoader.item.currentRoom = loader.item.inRoom ? loader.item.levelLoader.item.allocation[loader.item.floor][loader.item.position] : loader.item.levelLoader.item.corridorsLayout[loader.item.floor][loader.item.position]
                loading.source = ""
            }
        }
    }
}
