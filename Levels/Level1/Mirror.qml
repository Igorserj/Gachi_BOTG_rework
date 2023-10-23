import QtQuick 2.15
import QtGraphicalEffects 1.15

Image {
    width: loader.width / 7.4
    source: "Assets/Mirrors/Mirror.png"
    fillMode: Image.PreserveAspectFit
    clip: true
    Image {
        id: mirror
        y: - parent.y - parent.height
        x: - parent.x
        fillMode: Image.PreserveAspectCrop
        visible: false

        Connections {
            target: window
            function onFrameSwapped() {
                if (window.visible) wc.grabToImage(function(result) {
                    mirror.source = result.url;
                },
                Qt.size(loader.width, loader.height))
            }
        }
    }
    FastBlur {
        source: mirror
        anchors.fill: mirror
        radius: 32
        z: parent.z - 1
    }
}
