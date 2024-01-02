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
        objCache.push( ["interact", point[0], point[1], parent.width, (10 * scaleCoeff)] )
        spawnCache.push([point[0] + parent.width / 2, point[1] + (5 * scaleCoeff)])
    }
    function downs() {
        metaCache.push( {name: "downstairs", objects: objects} )
        const point = [parent.x - parent.width / 2, parent.y]
        objCache.push( ["interact", point[0], point[1], parent.width, (10 * scaleCoeff)] )
        spawnCache.push([point[0] + parent.width / 2, point[1] + (5 * scaleCoeff)])
    }

    Repeater {
        id: stairBuilder
        model: objects
        Image {
            source: modelData
            property real scaling: 1 / 1.14636
            y: index > 0 ? stairBuilder.itemAt(index - 1).y + stairBuilder.itemAt(index - 1).height * 0.19 : 0
//            width: type === "up" ? stairs.width / Math.pow(scaling, index) : stairs.width / Math.pow(scaling, model.length - (index + 1))
            height: type === "up" ? stairs.height / Math.pow(scaling, index) : stairs.height / Math.pow(scaling, model.length - (index + 1))
//            rotation: type === "up" ? 0 : 180
            width: height / (sourceSize.height / sourceSize.width)
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
