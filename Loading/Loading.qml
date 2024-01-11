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
}
