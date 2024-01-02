import QtQuick 2.15

Item {
    id: pass
    property string type: parent.type
    property var objects: []
    property int index: parent.curIndex
    Component.onCompleted: {
        if (progress === 1) {
            if (type === "left") {
                goLeft()
            }
            else if (type === "right") {
                goRight()
            }
            else {
                goRight()
            }
        }
    }
    function goLeft() {
        metaCache.push( {name: "leftpass", objects: objects} )
        const point = [parent.x, parent.y]
        objCache.push( ["interact", point[0], point[1], 10 * scaleCoeff, parent.height] )
        spawnCache.push([point[0] + 5 * scaleCoeff, point[1] + parent.height / 2])
    }
    function goRight() {
        metaCache.push( {name: "rightpass", objects: objects} )
        const point = [parent.x, parent.y]
        objCache.push( ["interact", point[0], point[1], 10 * scaleCoeff, parent.height] )
        spawnCache.push([point[0] + 5 * scaleCoeff, point[1] + parent.height / 2])
    }
}
