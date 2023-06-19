import QtQuick 2.15
import ".."

Entity {
    id: mainHero
    damage: 20
    inventory.inventoryCells: ['Baseball bat', 'Super Vodka', '', '', '', '', '', '', 'Bat', '', '', '', '', '', '', '', '', '', 'Hat', '']
    inventory.equipmentCells: ['Hat', '', '', '', '']
    inventory.metadataCells:  [{name: "Baseball bat", type: "One Hand", isEquipment: true, additionalInfo: "Beat this bitches", buffName: "StrengthUp"},
                                {name: "Super Vodka", type: "Consumable", isEquipment: false, additionalInfo: "This is super Vodka!", buffName: "SpeedUp"}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                              {}, {}, {}, {}, {}]
    ControlModule {}
}
