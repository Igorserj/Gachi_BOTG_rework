import QtQuick 2.15
import ".."

Entity {
    id: mainHero
    damage: 20
    defense: 0
    money: 300
    inventory.inventoryCells: ['Baseball bat', "Penis ball", '', '', '', '', '', '', 'Bat', '', '', '', '', '', '', '', '', '', '', '']
    inventory.equipmentCells: ['', '', '', '', '', '']
    inventory.metadataCells:  [{name: "Baseball bat", type: "One Hand", isEquipment: true, additionalInfo: "Beat this bitches", buffName: "StrengthUp"},
                                {name: "Penis ball", type: "One Hand", isEquipment: true, additionalInfo: "Beat this balls", buffName: "StaminaUp"}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                              {}, {}, {}, {}, {}, {}]
    ControlModule {}
}
