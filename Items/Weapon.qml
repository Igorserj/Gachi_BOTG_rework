import QtQuick 2.15
import "Weapon"

Item {
    Loader {
        sourceComponent: oneHanded
        onLoaded: {
            loaderAction(item)
            generator.oneHanded1 = item.group1Items
        }
    }
    Loader {
        sourceComponent: twoHanded
        onLoaded: {
            loaderAction(item)
            generator.twoHanded1 = item.group1Items
        }
    }

    Component {
        id: oneHanded
        OneHanded {
        }
    }

    Component {
        id: twoHanded
        TwoHanded {
        }
    }
}
