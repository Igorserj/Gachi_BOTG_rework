import QtQuick 2.15
import QtGraphicalEffects 1.15
import "Level1"
import "../Interface"
import "../Items"
import "../Shaders"

Item {
    property int blurDuration: 500
    Loader {
        id: levelLoader
        anchors.fill: parent
        focus: true
        activeFocusOnTab: true
        Component.onCompleted: levelChooser()
        onLoaded: lightingLoader.sourceComponent = spot
    }
    Component {
        id: level1Compose
        Level1Compose {}
    }

    FastBlur {
        id: blur
        width: levelLoader.width
        height: levelLoader.height
        source: levelLoader
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
        id: lightingLoader
        anchors.fill: parent
    }
    Loader {
        id: ifaceLoader
        anchors.fill: parent
        asynchronous: true
        sourceComponent: levelLoader.item.entGen.ready? iface : undefined
    }

    Component {
        id: iface
        Interface {}
    }

    Component {
        id: spot
        SpotLight {
            image: levelLoader.item
        }
    }

    ItemList {
        id: itemList
    }

    function levelChooser() {
        levelLoader.sourceComponent = level1Compose
    }
}
