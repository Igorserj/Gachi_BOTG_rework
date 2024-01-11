import QtQuick 2.15

QtObject {
    function finish() {
        loader.item.levelLoader.item.currentRoom = ""
        loader.item.levelLoader.item.currentRoom = loader.item.inRoom ? loader.item.levelLoader.item.allocation[loader.item.floor][loader.item.position] : loader.item.levelLoader.item.corridorsLayout[loader.item.floor][loader.item.position]
    }
}
