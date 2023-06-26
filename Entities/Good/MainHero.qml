import QtQuick 2.15
import ".."

Entity {
    id: mainHero
    damage: 20
    defense: 0
    money: 300
    inventory.inventoryCells: ['Baseball bat', '', '', '', '', '', '', '', 'Bat', '', '', '', '', '', '', '', '', '', '', '']
    inventory.equipmentCells: ['', '', '', '', '']
    inventory.metadataCells:  [{name: "Baseball bat", type: "One Hand", isEquipment: true, additionalInfo: "Beat this bitches", buffName: "StrengthUp"},
                                {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                              {}, {}, {}, {}, {}]
    ControlModule {}
}
