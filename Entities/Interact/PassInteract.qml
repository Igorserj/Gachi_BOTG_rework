import QtQuick 2.15

InteractPattern {
    property var objects: []
    function interaction(entity) {
        loadingScreen.objects = objects
        loadingScreen.source = interact.name
        if (interact.name === "leftpass") loader.item.position--
        else if (interact.name === "rightpass") loader.item.position++
//        roomLoad()
    }
//    function roomLoad() {

//    }
}
