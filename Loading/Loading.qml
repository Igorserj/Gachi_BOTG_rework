import QtQuick 2.15
import "Stairs"

Item {
    id: loading
    property string source: ""
    property var objects: []
    visible: loader.status !== Loader.Ready
    onSourceChanged: {
        if (source === "downstairs") { load.sourceComponent = downstairs }
        else if (source === "upstairs") { load.sourceComponent = upstairs }
    }
    Loader {
        id: load
        width: window.width
//        height: window.height
    }

    Component {
        id: upstairs
        Upstairs {}
    }
    Component {
        id: downstairs
        Downstairs {}
    }
}
