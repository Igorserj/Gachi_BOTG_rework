WorkerScript.onMessage = function (message) {

    const hX = message.hX
    const hY = message.hY
    const hW = message.hW
    const hH = message.hH

//    const speed = message.speed
    const objects = message.objects

    const x = message.x
    const y = message.y
    const height = message.height
    const width = message.width

    let isPicked = false
    let index = -1

    const horizontalEdge = hX + hW > x && hX < x + width
    const verticalEdge = hY + hH > y && hY < y + height

    if (verticalEdge && horizontalEdge) {
        isPicked = true
        index = message.index
    }

    WorkerScript.sendMessage({
                                 "isPicked": isPicked,
                                 "i": message.i,
                                 "index": index
                             })
}
