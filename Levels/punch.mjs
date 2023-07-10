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
    let hD = message.hDef
    let ids = message.ids
    let hHealth = message.hHealth

    let healthList = []
    let idList = []
// 100
// damage = damage * (1 - def)
// damage = damage * ((20 - def) / 40 + 0.5)
    for (let i = 0; i < ids.length; i++) {
        if (Math.abs((x + width / 2) - (hX[i] + hW[i] / 2)) <= (width + hW[i] / 2) && Math.abs((y + height / 2) - (hY[i] + hH[i] / 2)) <= (height + hH[i] / 2)) {
            let dealtDamage = damage * ((20 - hD[i]) / 40 + 0.5) < 1 ? 1 : damage * ((20 - hD[i]) / 40 + 0.5)
            let hp = hHealth[i] - dealtDamage < 0 ? 0 : hHealth[i] - dealtDamage
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
