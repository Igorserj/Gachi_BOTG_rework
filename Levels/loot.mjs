WorkerScript.onMessage = function (message) {

    const x = message.x
    const y = message.y
    const width = message.width
    const height = message.height

    const hX = message.hX
    const hY = message.hY
    const hW = message.hW
    const hH = message.hH
    const ids = message.ids
    const state = message.state
    const type = message.type

    let index1 = []

    for (let i = 0; i < ids.length; i++) {
        if (Math.abs((x + width / 2) - (hX[i] + hW[i] / 2)) <= (width + hW[i] / 2) && Math.abs((y + height / 2) - (hY[i] + hH[i] / 2)) <= (height + hH[i] / 2) && (state[i] === "dead" || type[i] === "npc")) {
            index1.push(ids[i])
        }
    }
//    console.log(index1)
//    console.log(type)

    WorkerScript.sendMessage({
                                 "index1": index1,
                                 "type" : type
                             })
}
