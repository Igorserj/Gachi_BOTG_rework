import QtQuick 2.15
import "../../Controls" as Controls
import "../../Entities/Interact"
import QtQuick.Controls 2.15

Rectangle {
    property var pool: []
    property int index2
    height: loader.height
    width: 0.3 * loader.width
    color: style.darkGlass
    ScrollView {
        width: parent.width * 0.985
        height: parent.height * 0.985
        anchors.centerIn: parent
        clip: true
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0.05 * parent.height
            Repeater {
                model: ["Teleport", "Heal"]
                Controls.Button1 {
                    text: modelData
                    function clickFunction() {
                        index === 0 ? teleport() :
                                      healthHeal()
                    }
                }
            }
        }
    }

    function functionalSet(index) {
        if (index2 === 0) {
            if (index === 0) pool[0] = "corridor"
            else if (index === 1) pool[0] = "room"
            dialogLoader.sourceComponent = undefined
            teleport(1)
        }
        else if (index2 === 1) {
            pool[1] = index
            dialogLoader.sourceComponent = undefined
            teleport(2)
        }
        else if (index2 === 2) {
            pool[2] = index
            if (dialogLoader.item.objects[index]!==0) {
                dialogLoader.sourceComponent = undefined
                teleport(3)
            }
        }
    }

    function teleport(stage = 0) {
        if (stage === 0) {
            index2 = 0
            dialogLoader.sourceComponent = dialog
            dialogLoader.item.mainText = "Where to go?"
            dialogLoader.item.objects = ["Corridor", "Room"]
        }
        else if (stage === 1) {
            index2 = 1
            dialogLoader.sourceComponent = dialog
            dialogLoader.item.mainText = "Which floor?"
            dialogLoader.item.objects = [1, 2, 3, 4]
        }
        else if (stage === 2) {
            index2 = 2
            dialogLoader.sourceComponent = dialog
            dialogLoader.item.mainText = "Which position?"
            dialogLoader.item.objects = pool[0] === "corridor" ? [1, 2, 3, 4, 5, 6] :
                                                                 loader.item.levelLoader.item.allocation[pool[1]].map((a, i)=>
                                                                                                                      a==="room"? "R" :
                                                                                                                                  a==="library" ? "L" :
                                                                                                                                                  a==="canteen" ? "C" :
                                                                                                                                                                  a!==""? i+1:0)
        }
        else if (stage === 3) {
            index2 = -1
            interact.heroDataSaving()
            interact.hostileDataSaving()
            interact.itemsSaving()
            loader.item.inRoom = pool[0] === "room"
            loader.item.floor = pool[1]
            loader.item.position = pool[2]
            pool = []
            interact.builderDataSaving()
            loadingScreen.source = "instant"
        }
    }

    function healthHeal() {
        loader.item.levelLoader.item.roomLoader.item.entGen.repeater.itemAt(0).item.health+=50
    }

    InteractPattern {
        id: interact
        property var entGen: loader.item.levelLoader.item.roomLoader.item.entGen
        property var itmGen: loader.item.levelLoader.item.roomLoader.item.itmGen
        health: 0
        maxHealth: 0
        canPickUp: false
        width: 0
        height: 0
    }

    Loader {
        id: dialogLoader
        onLoaded: item.show()
    }

    Component {
        id: dialog
        Controls.Dialog {
            mainText: ""
            objects: []
            function actionSet(index) {functionalSet(index)}
        }
    }

    Controls.Styles {
        id: style
    }
}
