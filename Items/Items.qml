import QtQuick 2.15

Item {
    property var itemsList: []
    Loader {
        sourceComponent: usable
    }
    Loader {
        sourceComponent: wearable
    }
    Loader {
        sourceComponent: weapon
    }
    Component {
        id: usable
        Usable {}
    }
    Component {
        id: weapon
        Weapon {}
    }
    Component {
        id: wearable
        Wearable {}
    }

    function loaderAction(item) {
        itemsList.push(item.itemList)
    }
}
