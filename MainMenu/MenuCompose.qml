import QtQuick 2.15
import "Home"
import "Settings"

Item {
    id: composer
    state: "home"
    states: [
        State {
            name: "home"
            PropertyChanges {
                target: composeLoader
                sourceComponent: home
            }
        },
        State {
            name: "start"
            PropertyChanges {
                target: composeLoader.item
                buttonsModel: composeLoader.item.buttonNames[1]
                actionSet: 1
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: composeLoader
                sourceComponent: settings
            }
        }
    ]
    Background {}
    Loader {
        id: composeLoader
        sourceComponent: home
        height: composer.height
        width: composer.width
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
