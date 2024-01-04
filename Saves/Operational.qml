import QtQuick 2.15

Item {
    property alias level: level
    property alias settings: settings
    QtObject {
        id: settings
        property string currentLanguage: "English"
        property var screenProps: ({width: screen.width * 0.75, height: screen.height * 0.75,
                                       visibility: 2})
    }
    QtObject {
        id: level
        property var hero: ({
                                x: (loader.width - (50 * scaleCoeff)) / 2,
                                y: loader.height - (50 * scaleCoeff),

                                health: 100,
                                maxHealth: 100,
                                stamina: 30,
                                maxStamina: 30,
                                speedCoeff: 20,
                                damage: 10,
                                defense: 0, //20 max
                                money: 0,
                                facingRight: true,
                                rot: 0,
                                name: "",

                                inventoryCells: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
                                previousInventory: ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
                                equipmentCells: ['', '', '', '', '', '', ''],
                                previousEquipment: ['', '', '', '', '', '', ''],
                                activatedWeapon: [false, false, false],
                                twoHands: false,
                                metadataCells: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                    {}, {}, {}, {}, {}, {}, {}],
                                previousMetadata: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                    {}, {}, {}, {}, {}, {}, {}],

                                // buffs: []
                            })
    }

}
