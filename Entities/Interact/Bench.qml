import QtQuick 2.15

InteractPattern {
    width: 120
    height: 20
    function interaction(entity) {
        if (interact.health > 0) {
            entity.x = entGen.objects[currentIndex][1] + (width - entity.item.width) / 2
            entity.y = entGen.objects[currentIndex][2] - entity.item.height
        }
        else {
            ifaceLoader.item.interfaceLoader.item.dialogueOpen()
            let name1 = ifaceLoader.item.interfaceLoader.item.name1
            ifaceLoader.item.interfaceLoader.item.text = [[name1, "I can't sit"], [name1, 'The bench is broken']]
        }
    }
}
