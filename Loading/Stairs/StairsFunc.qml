import QtQuick 2.15

QtObject {
    function heightCalc() {
        let fullHeight = 0
        let height = 0
        let y = 0
        let width = loader.width / 6
        for (let i = 1; i < objects.length; i++) {
            width *= 1.14636
            height = width / (358 / 220)
            y += height * 0.19
            if (fullHeight < y + height) { fullHeight = y + height }
        }
        stairs.scale = 358 / width
        repeater.height = fullHeight
        repeater.width = width
        return (loader.height - fullHeight) / 2
    }
    function finish() {
        ++repeat
        if (repeat < objects.length) anim.running = true
        else {
            loading.source = ""
            loader.item.levelLoader.item.roomLoader.visible = Qt.binding(function() {return loader.item.levelLoader.item.roomLoader.status === Loader.Ready})
        }
    }
}
