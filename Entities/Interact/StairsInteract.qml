import QtQuick 2.15

InteractPattern {
    property var objects: []
    function interaction(entity) {
        loadingScreen.objects = objects
        loadingScreen.source = interact.name
        loader.sourceComponent = undefined
    }
    function roomLoad() {

    }
}
