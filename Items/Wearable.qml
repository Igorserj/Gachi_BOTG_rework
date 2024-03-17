import QtQuick 2.15
import "Wearable"

Item {
    Loader {
        sourceComponent: head
        onLoaded: {
            loaderAction(item)
            generator.head1 = item.group1Items
        }
    }
    Loader {
        sourceComponent: torso
        onLoaded: {
            loaderAction(item)
            generator.torso1 = item.group1Items
        }
    }
    Loader {
        sourceComponent: legs
        onLoaded: {
            loaderAction(item)
            generator.legs1 = item.group1Items
        }
    }
    Loader {
        sourceComponent: feet
        onLoaded: {
            loaderAction(item)
            generator.feet1 = item.group1Items
        }
    }
    Component {
        id: head
        Head {
        }
    }

    Component {
        id: torso
        Torso {
        }
    }

    Component {
        id: legs
        Legs {
        }
    }

    Component {
        id: feet
        Feet {
        }
    }
}
