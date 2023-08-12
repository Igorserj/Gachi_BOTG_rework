WorkerScript.onMessage = function (message) {

    const x = message.x
    const y = message.y
    const width = message.width
    const height = message.height
    const damage = message.damage
    const type = message.type

    const hX = message.hX
    const hY = message.hY
    const hW = message.hW
    const hH = message.hH
    const hD = message.hDef
    const ids = message.ids
    const hHealth = message.hHealth
    const types = message.types

    let healthList = []
    let idList = []
    let dealtDamage = 0
    let hp = 0

    for (let i = 0; i < ids.length; i++) {
        if (Math.abs((x + width / 2) - (hX[i] + hW[i] / 2)) <= (width + hW[i] / 2) && Math.abs((y + height / 2) - (hY[i] + hH[i] / 2)) <= (height + hH[i] / 2) && types[ids[i]] !== type) {
            dealtDamage = damage - hD[i] <= 0 ? 1 : damage - hD[i]
            hp = hHealth[i] - dealtDamage < 0 ? 0 : hHealth[i] - dealtDamage
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
