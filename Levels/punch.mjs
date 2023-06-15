WorkerScript.onMessage = function (message) {

    let x = message.x
    let y = message.y
    let width = message.width
    let height = message.height
    let damage = message.damage

    let hX = message.hX
    let hY = message.hY
    let hW = message.hW
    let hH = message.hH
    let ids = message.ids
    let hHealth = message.hHealth

    let healthList = []
    let idList = []

    for (let i = 0; i < ids.length; i++) {
        if (Math.abs((x + width / 2) - (hX[i] + hW[i] / 2)) <= (width + hW[i] / 2) && Math.abs((y + height / 2) - (hY[i] + hH[i] / 2)) <= (height + hH[i] / 2)) {
            let hp = hHealth[i] - damage < 0 ? 0 : hHealth[i] - damage
            healthList.push(hp)
            idList.push(ids[i])
        }
    }

    WorkerScript.sendMessage({
                                 "hHealth": healthList,
                                 "ids": idList,
                                 "index1": message.index1
                             })
}