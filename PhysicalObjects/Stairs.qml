import QtQuick 2.15

Item {
    id: stairs
    property real progress: 0
    property string type: parent.type
    property var objects: []
    property int index: parent.curIndex
    onProgressChanged: {
        if (progress === 1) {
            stairs.x = -parent.width / 2
            if (type === "up") {
                ups()
            }
            else if (type === "down") {
                downs()
            }
            else {
                ups()
            }
        }
    }
    function ups() {
        stairs.y = -stairBuilder.height
        metaCache.push( {name: "upstairs", objects: objects} )
        const point = [parent.x - parent.width / 2, parent.y]
        objCache.push( ["interact", point[0], point[1], parent.width, 10] )
        spawnCache.push(point)
    }
    function downs() {
        metaCache.push( {name: "downstairs", objects: objects} )
        const point = [parent.x - parent.width / 2, parent.y]
        objCache.push( ["interact", point[0], point[1], parent.width, 10] )
        spawnCache.push(point)
    }

    Repeater {
        id: stairBuilder
        model: objects
        Image {
            source: modelData
            property real scaling: 1 / 1.14636
            y: index > 0 ? stairBuilder.itemAt(index - 1).y + stairBuilder.itemAt(index - 1).height * 0.19 : 0
            width: index > 0 ? stairBuilder.itemAt(index - 1).width / scaling : stairs.width
            height: index > 0 ? stairBuilder.itemAt(index - 1).height / scaling : stairs.height
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            Component.onCompleted: {
                if (width > stairBuilder.width) stairBuilder.width = width
                if (index === stairBuilder.model.length - 1) stairBuilder.height = y + height
            }
        }
        onItemAdded: { progress += 1 / model.length }
    }
}
