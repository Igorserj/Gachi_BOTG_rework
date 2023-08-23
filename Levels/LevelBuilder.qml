import QtQuick 2.15
import QtGraphicalEffects 1.15
import "Level1"
import "../Interface"
import "../Items"
import "../Shaders"

Item {
    property int blurDuration: 500
    property alias lightingLoader: lightingLoader
    property alias lightingLoader2: lightingLoader2
    property string seed: "000000"
    Loader {
        id: levelLoader
        anchors.fill: parent
        focus: true
        activeFocusOnTab: true
        Component.onCompleted: levelChooser()
        onLoaded: {
            lightingLoader.sourceComponent = spot
            lightingLoader2.sourceComponent = spot
        }
    }

    Loader {
        id: lightingLoader
        visible: false
        anchors.fill: parent
    }
    Loader {
        id: lightingLoader2
        visible: false
        anchors.fill: parent
    }
    LightBlend {
        id: blend
        anchors.fill: parent
        image: lightingLoader.item
        image2: lightingLoader2.item
    }
    FastBlur {
        id: blur
        width: levelLoader.width
        height: levelLoader.height
        source: blend
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
        sourceComponent: levelLoader.item.entGen.ready? iface : undefined
    }

    ItemList {
        id: itemList
    }

    Component {
        id: level1View
        Level1View {}
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

    function levelChooser() {
        levelLoader.sourceComponent = level1View
    }
}
