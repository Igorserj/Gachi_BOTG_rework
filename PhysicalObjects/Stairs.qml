import QtQuick 2.15

Item {
    id: stairs
    property real progress: 0
    property string type: parent.type
    property var objects: []
    onProgressChanged: {
        if (progress === 1) {
            if (type === "upstairs") {
                ups()
            }
            else if (type === "downstairs") {
                downs()
            }
            else {
                ups()
                downs()
            }
            repeater.numberOfCreatedObjects++
        }
    }
    function ups() {
        entGen.metadata.push( {name: "upstairs", objects: objects} )
        entGen.objects.push( ["interact", parent.x, parent.y + stairBuilder.height] )
        spawnPoints.push([parent.x, parent.y + stairBuilder.height])
    }
    function downs() {
        entGen.metadata.push( {name: "downstairs", objects: objects} )
        entGen.objects.push( ["interact", parent.x, parent.y] )
        spawnPoints.push([parent.x, parent.y])
    }
    Repeater {
        id: stairBuilder
        width: 0
        height: 0
        model: objects
        Image {
            source: modelData
            property real scaling: 1 / 1.14636
            y: index > 0 ? stairBuilder.itemAt(index - 1).y + stairBuilder.itemAt(index - 1).height * 0.19 : 0
            width: index > 0 ? stairBuilder.itemAt(index - 1).width / scaling : stairs.width
            height: index > 0 ? stairBuilder.itemAt(index - 1).height / scaling : stairs.height
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            Component.onCompleted: { if (width > stairBuilder.width) stairBuilder.width = width; if (index === stairBuilder.model.length - 1) {stairBuilder.height = y + height} }
        }
        onItemAdded: { progress += 1 / model.length }
    }
}
