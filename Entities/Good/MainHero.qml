import QtQuick 2.15
import ".."

Entity {
    id: mainHero
    damage: 20
    inventory.inventoryCells: ['', 'Vodka', '', '', '', '', '', '', 'Bat', '', '', '', '', '', '', '', '', '', 'Hat', '']
    inventory.equipmentCells: ['Hat', '', '', '', '']
    ControlModule {}
}
