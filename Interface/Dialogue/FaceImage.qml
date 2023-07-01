import QtQuick 2.15

Image {
    id: image
    property var entity

    SequentialAnimation {
        running: entity !== undefined
        loops: Animation.Infinite
        ScriptAction {
            script: entity.grabToImage(function(result) {image.source = result.url})
        }
    }
}
