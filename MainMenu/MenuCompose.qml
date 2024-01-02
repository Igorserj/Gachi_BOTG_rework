import QtQuick 2.15
import "Home"
import "Settings"

Item {
    id: composer
    property alias composeLoader: composeLoader
    state: "home"
//    onStateChanged: {
//        controlModule.createdComponents = 0
//        controlModule.currentIndex = -1
//    }
    states: [
        State {
            name: "home"
            PropertyChanges {
                target: composeLoader
                sourceComponent: home
            }
            PropertyChanges {
                target: vignetteLoader
                sourceComponent: vignette
            }
        },
        State {
            name: "start"
            PropertyChanges {
                target: composeLoader.item
                buttonsModel: composeLoader.item.buttonNames[1]
                actionSet: 1
            }
            PropertyChanges {
                target: vignetteLoader
                sourceComponent: vignette
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: composeLoader
                sourceComponent: settings
            }
            PropertyChanges {
                target: vignetteLoader
                sourceComponent: vignette
            }
        }
    ]
    Background {id: bg}
    Loader {
        id: composeLoader
        sourceComponent: home
        height: composer.height
        width: composer.width
//        Behavior on opacity {
//            PropertyAnimation {
//                target: composeLoader
//                property: "opacity"
//                duration: 250
//            }
//        }
//        onSourceComponentChanged: opacity = 0
//        onLoaded: opacity = 1
    }
    Component {
        id: home
        Home {
            width: composer.width
            height: composeLoader.height
        }
    }
    Component {
        id: settings
        Settings {
            width: composer.width
            height: composeLoader.height
        }
    }
}
