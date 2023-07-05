import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {//not used
    property var sizes
    property var source

    Glow {
        width: sizes !== undefined ? sizes.width : 0
        height: sizes !== undefined ? sizes.height : 0
        x: sizes !== undefined ? sizes.x : 0
        y: sizes !== undefined ? sizes.y : 0
        radius: 8
        samples: 17
        color: "white"
        source: parent.source
    }
}
