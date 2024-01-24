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
        property var builder: ({
                                   seed: [],
                                   position: -1,
                                   inRoom: false,
                                   floor: 0
                               })

        property var hero: ({
                                x: (loader.width - (50 * scaleCoeff)) / 2,
                                y: loader.height - (50 * scaleCoeff),

                                health: 100,
                                maxHealth: 100,
                                stamina: 30,
                                maxStamina: 30,
                                speedCoeff: 20,
                                damage: 10,
                                defense: 0,
                                money: 0,
                                facingRight: true,
                                rot: 0,
                                name: "",
                                state: "alive",

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

                                buffs: []
                            })

        property var hostile: ({
                                   corridorEnemy: [],
                                   corridorEnemyMeta: [],
                                   roomEnemy: [],
                                   roomEnemyMeta: []
                               })

        function heroClear() {
            hero.x = (loader.width - (50 * scaleCoeff)) / 2
            hero.y = loader.height - (50 * scaleCoeff)

            hero.health = 100
            hero.maxHealth = 100
            hero.stamina = 30
            hero.maxStamina = 30
            hero.speedCoeff = 20
            hero.damage = 10
            hero.defense = 0
            hero.money = 0
            hero.facingRight = true
            hero.rot = 0
            hero.name = "Semen"
            hero.state = "alive"

            hero.inventoryCells = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
            hero.previousInventory = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']
            hero.equipmentCells = ['', '', '', '', '', '', '']
            hero.previousEquipment = ['', '', '', '', '', '', '']
            hero.activatedWeapon = [false, false, false]
            hero.twoHands = false
            hero.metadataCells = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                  {}, {}, {}, {}, {}, {}, {}]
            hero.previousMetadata = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                                     {}, {}, {}, {}, {}, {}, {}]

            hero.buffs = []
        }

        function levelBuilderClear() {
            builder.seed = []
            builder.position = -1
            builder.inRoom = false
            builder.floor = 0
        }

        function hostileClear() {
            hostile.corridorEnemy = []
            hostile.corridorEnemyMeta = []
            hostile.roomEnemy = []
            hostile.roomEnemyMeta = []
        }
    }
}
