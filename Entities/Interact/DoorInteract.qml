import QtQuick 2.15

InteractPattern {
    property var objects: []
    function interaction(entity) {
        loadingScreen.objects = objects
        loadingScreen.source = interact.name
        if (interact.name === "frontdoor") {
            heroDataSaving()
            opSave.level.hero.x = loader.width / 2
            opSave.level.hero.y += loader.height
            loader.item.inRoom = true
        }
        else if (interact.name === "backdoor") {
            heroDataSaving()
            opSave.level.hero.x = loader.width / 2
            opSave.level.hero.y -= loader.height
            loader.item.inRoom = false
        }
        builderDataSaving()
    }
}
