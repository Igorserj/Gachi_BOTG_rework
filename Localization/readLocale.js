WorkerScript.onMessage = function(message) {
    let localeFile
    let success = false
    let request = new XMLHttpRequest();
    request.open("GET", message.fileUrl, false);
    request.onreadystatechange = function () {
        if(request.readyState === XMLHttpRequest.DONE){
            const response = request.responseText;
            if (response !== "") {
                localeFile = JSON.parse(response);
                success = true
            }
        }
    }
    request.send();
    if (success) {
        WorkerScript.sendMessage({
                                     'success': success,
                                     'languages': localeFile.languages,
                                     'exitDialogText': localeFile.exitDialogText,
                                     'exitDialogOptions': localeFile.exitDialogOptions,
                                     'homeButtonNames': localeFile.homeButtonNames,
                                     'settingsFullScreenTrue': localeFile.settingsFullScreenTrue,
                                     'settingsFullScreenFalse': localeFile.settingsFullScreenFalse,
                                     'settingsSave': localeFile.settingsSave,
                                     'settingsFPSon': localeFile.settingsFPSon,
                                     'settingsFPSoff': localeFile.settingsFPSoff,
                                     'menuButtonNames': localeFile.menuButtonNames,
                                     'inventoryCellOptions': localeFile.inventoryCellOptions,
                                     'itemNames': localeFile.itemNames,
                                     'itemAddInfo': localeFile.itemAddInfo
                                 })
    }
    else {
        WorkerScript.sendMessage({
                                     'success': success
                                 })
    }


}
