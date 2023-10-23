import QtQuick 2.15

Column {
    property int rows: 0
    property int columns: 0
    Repeater {
        model: rows
        Row {
            id: row
            property int rowIndex: index
            Repeater {
                model: columns
                Image {
                    source: walls[(seed[(((row.rowIndex + 1) * (index + 1))) % seed.length] * (index + 1) * (row.rowIndex + 1)) % walls.length]
                    rotation: 90 * ((((row.rowIndex + 1) * (index + 1))) % 4)
                    width: loader.width / 36
                    height: width
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
}
