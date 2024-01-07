import QtQuick 2.15

InteractPattern {
    property var objects: []
    function interaction(entity) {
        loadingScreen.objects = objects
        loadingScreen.source = interact.name
        levelLoader.item.roomLoader.visible = false
        if (interact.name === "upstairs") {
            heroDataSaving()
            opSave.level.hero.y += loader.height
            loader.item.floor++
        }
        else if (interact.name === "downstairs") {
            heroDataSaving()
            opSave.level.hero.y -= loader.height
            loader.item.floor--
        }
        loader.item.position = corridorShift[loader.item.floor] + 1
        builderDataSaving()
        roomLoad()
    }
    function roomLoad() {
        currentRoom = ""
        currentRoom = staircaseLayout[loader.item.floor]
    }
}
