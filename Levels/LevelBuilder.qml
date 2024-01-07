import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../Interface"
import "../Items"
import "../Shaders"

Item {
    readonly property int blurDuration: 500
    property var seed: opSave.level.builder.seed // "000000"
    property int floor: opSave.level.builder.floor
    property int position: opSave.level.builder.position//  levelLoader.item.corridorShift[floor]
    property alias levelLoader: levelLoader
    Loader {
        id: levelLoader
        anchors.fill: parent
        focus: true
        activeFocusOnTab: true
    }
    FastBlur {
        id: blur
        width: levelLoader.width
        height: levelLoader.height
        source: levelLoader//blend
        opacity: 0
        radius: 0
        Behavior on radius {
            PropertyAnimation {
                target: blur
                property: "radius"
                duration: blurDuration
            }
        }
        Behavior on opacity {
            PropertyAnimation {
                target: blur
                property: "opacity"
                duration: blurDuration
            }
        }
    }

    Loader {
        id: ifaceLoader
        anchors.fill: parent
        asynchronous: true
        sourceComponent: !!levelLoader.item ?  levelLoader.item.roomLoader.status === Loader.Ready ? levelLoader.item.roomLoader.item.entGen.ready ? iface : undefined : undefined : undefined
    }

    ItemList {
        id: itemList
    }

    Component {
        id: levelPattern
        LevelPattern {}
    }

    Component {
        id: iface
        Interface {}
    }

    Component {
        id: spot
        SpotLight {
            colorR: 1.0
            colorG: 1.0
            colorB: 1.0
            hideControls: true
            image: levelLoader.item
        }
    }

    function levelChooser(type) {
        levelLoader.sourceComponent = levelPattern
        levelLoader.item.alloc(type)
//        position = levelLoader.item.corridorShift[floor]
    }
}
