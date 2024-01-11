import QtQuick 2.15

Item {
    id: door
    property string type: parent.type
    property var objects: []
    property int index: parent.curIndex
    width: 10 * scaleCoeff
    height: 10 * scaleCoeff
    Component.onCompleted: {
        if (progress === 1) {
            if (type === "forward") {
                goFront()
            }
            else if (type === "backward") {
                goBack()
            }
            else {
                goBack()
            }
        }
    }
    function goFront() {
        metaCache.push( {name: "frontdoor", objects: objects} )
        const point = [parent.x, parent.y]
        objCache.push( ["interact", point[0], point[1], parent.width, parent.height] )
        spawnCache.push([point[0] + parent.width / 2, point[1] + parent.height / 2])
    }
    function goBack() {
        metaCache.push( {name: "backdoor", objects: objects} )
        const point = [parent.x, parent.y]
        objCache.push( ["interact", point[0], point[1], parent.width, parent.height] )
        spawnCache.push([point[0] + parent.width / 2, point[1] + parent.height / 2])
    }
}
