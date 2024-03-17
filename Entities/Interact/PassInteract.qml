import QtQuick 2.15

InteractPattern {
    property var objects: []
    function interaction(entity) {
        loadingScreen.objects = objects
        loadingScreen.source = interact.name
        if (interact.name === "leftpass") {
            heroDataSaving()
            hostileDataSaving()
            itemsSaving()
            opSave.level.hero.x += loader.width
            loader.item.position--
        }
        else if (interact.name === "rightpass") {
            heroDataSaving()
            hostileDataSaving()
            itemsSaving()
            opSave.level.hero.x -= loader.width
            loader.item.position++
        }
        builderDataSaving()
    }
}
