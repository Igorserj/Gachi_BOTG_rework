import QtQuick 2.15

Item {
    property string currentLanguage: opSave.settings.currentLanguage
    property var languages: ["English"]

    property string exitDialogText: "Quit game?"
    property var exitDialogOptions: ["Do not quit", "Quit"]

    property var homeButtonNames: [["Start game", "Settings", "Quit game"], ["New game", "Continue", "Back"]]

    property string settingsFullScreenTrue: "Go fullscreen"
    property string settingsFullScreenFalse: "Go windowed"
    property string settingsSave: "Save"
    property string settingsFPSon: "Show frames counter"
    property string settingsFPSoff: "Hide frames counter"

    property var menuButtonNames: ["Continue", "Main menu", "Quit"]

    property var inventoryCellOptions: [["Move", "Use", "Drop", "Destroy"], ["Move", "Equip", "Drop", "Destroy"], ["Move", "Unequip"], ["Loot", "Move", "Destroy"]]

    property var itemNames: ["Hat", "Vodka", "Bat", "Jacket", "Jeans", "Sneakers"]
    property var itemAddInfo: ["Just a normal hat", "Vodka don't need to be advertised", "Beat them up!", "Leather jacket", " ", "Put my sneakers on"]

    WorkerScript {
        id: localeScript
        source: "readLocale.js"
        onMessage: {
            if (messageObject.success) {
                const langs = messageObject.languages
                const edt = messageObject.exitDialogText
                const edo = messageObject.exitDialogOptions
                const hbn = messageObject.homeButtonNames
                const sfst = messageObject.settingsFullScreenTrue
                const sfsf = messageObject.settingsFullScreenFalse
                const ss = messageObject.settingsSave
                const sfpso = messageObject.settingsFPSon
                const sfpsof = messageObject.settingsFPSoff
                const mbn = messageObject.menuButtonNames
                const ico = messageObject.inventoryCellOptions
                const ins = messageObject.itemNames
                const iai = messageObject.itemAddInfo

                langs.unshift(languages[0])
                languages = langs

                edt.unshift(exitDialogText)
                exitDialogText = Qt.binding(function() {return edt[languages.indexOf(currentLanguage)]})

                edo.unshift(exitDialogOptions)
                exitDialogOptions = Qt.binding(function() {return edo[languages.indexOf(currentLanguage)]})

                hbn.unshift(homeButtonNames)
                homeButtonNames = Qt.binding(function() {return hbn[languages.indexOf(currentLanguage)]})

                sfst.unshift(settingsFullScreenTrue)
                settingsFullScreenTrue = Qt.binding(function() {return sfst[languages.indexOf(currentLanguage)]})

                sfsf.unshift(settingsFullScreenFalse)
                settingsFullScreenFalse = Qt.binding(function() {return sfsf[languages.indexOf(currentLanguage)]})

                ss.unshift(settingsSave)
                settingsSave = Qt.binding(function() {return ss[languages.indexOf(currentLanguage)]})

                sfpso.unshift(settingsFPSon)
                settingsFPSon = Qt.binding(function() {return sfpso[languages.indexOf(currentLanguage)]})

                sfpsof.unshift(settingsFPSoff)
                settingsFPSoff = Qt.binding(function() {return sfpsof[languages.indexOf(currentLanguage)]})

                mbn.unshift(menuButtonNames)
                menuButtonNames = Qt.binding(function() {return mbn[languages.indexOf(currentLanguage)]})

                ico.unshift(inventoryCellOptions)
                inventoryCellOptions = Qt.binding(function() {return ico[languages.indexOf(currentLanguage)]})

                ins.unshift(itemNames)
                itemNames = Qt.binding(function() {return ins[languages.indexOf(currentLanguage)]})

                iai.unshift(itemAddInfo)
                itemAddInfo = Qt.binding(function() {return iai[languages.indexOf(currentLanguage)]})
            }
        }
    }

    Component.onCompleted: {
        console.log("file:///" + applicationDirPath + "/locale.json")
        localeScript.sendMessage({
                                     "fileUrl" : "file:///" + applicationDirPath + "/locale.json"
                                 })
    }
}
