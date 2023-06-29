WorkerScript.onMessage = function (message) {

    let x = message.x
    let y = message.y
    let width = message.width
    let height = message.height

    let hX = message.hX
    let hY = message.hY
    let hW = message.hW
    let hH = message.hH
    let ids = message.ids

    let index1 = -1

    for (let i = 0; i < ids.length; i++) {
        if (Math.abs((x + width / 2) - (hX[i] + hW[i] / 2)) <= (width + hW[i] / 2) && Math.abs((y + height / 2) - (hY[i] + hH[i] / 2)) <= (height + hH[i] / 2)) {
            index1 = ids[i]
        }
    }

    WorkerScript.sendMessage({
                                 "index1": index1
                             })
}
