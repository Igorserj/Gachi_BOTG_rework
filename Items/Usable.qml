import QtQuick 2.15
import "Usable"

Item {
    Loader {
        sourceComponent: ingridients
        onLoaded: {
            loaderAction(item)
            generator.ingredients1 = item.group1Items
        }
    }
    Loader {
        sourceComponent: dishes
        onLoaded: {
            loaderAction(item)
            generator.dishes1 = item.group1Items
        }
    }
    Component {
        id: ingridients
        Ingridients {}
    }

    Component {
        id: dishes
        DishesDrinksOthers {}
    }
}
