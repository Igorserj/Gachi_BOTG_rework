WorkerScript.onMessage = function (message) {

    const hX = message.hX
    const hY = message.hY
    const hW = message.hW
    const hH = message.hH
    const hor = message.hor
    const dir = message.dir
    const speed = message.speed
    const objects = message.objects

    const x = message.x
    const y = message.y
    const height = message.height
    const width = message.width

    let isPicked = false
    const leftEdge = hX - speed <= x + width && hX + speed >= x
    const rightEdge = hX + hW + speed >= x && hX + hW - speed <= x + width
    const verticalEdge = hY + hH + 1 > y && hY - 1 < y + height

    const topEdge = hY - speed <= y + height && hY + speed >= y
    const bottomEdge = hY + hH + speed >= y && hY + hH - speed <= y + height
    const horizontalEdge = hX - 1 < x + width && hX + hW + 1 > x



//    console.log("Vert", verticalEdge, "Hor", horizontalEdge, "Left", leftEdge, "Right", rightEdge, "Up", topEdge, "Bot", bottomEdge)

    function boundries(/*bottomEdge, horizontalEdge, rightEdge, verticalEdge, leftEdge*/) {
        if (hor === 0 && dir === 0) {//up
            if (bottomEdge && horizontalEdge) isPicked = true
        }
        else if (hor === 0 && dir === 1) {//down
            if (topEdge && horizontalEdge) isPicked = true
        }
        else if (hor === 1 && dir === 0) {//left
            if (rightEdge && verticalEdge) isPicked = true
        }
        else if (hor === 1 && dir === 1) {//right
            if (leftEdge && verticalEdge) isPicked = true
        }
    }

//    function horEdge(hX, hW, x, width) {
//        return hX + hW > x && hX < x + width
//    }
//    function verEdge(hY, hH, y, height) {
//        return hY + hH > y && hY < y + height
//    }
//    function botEdge(hY, y, height) {
//        return hY < y + height
//    }
//    function topEdge(hY, hH, y) {
//        return hY + hH > y
//    }
//    function lEdge(hX, hW, x) {
//        return hX + hW > x
//    }
//    function rEdge(hX, x, width) {
//        return hX < x + width
//    }

//    for (let j = 0; j < index.length; j++) {
//        const x = objects[j][0]
//        const y = objects[j][1]
//        const width = objects[j][2]
//        const height = objects[j][3]

//        const horizontalEdge = horEdge(hX, hW, x, width)
//        const verticalEdge = verEdge(hY, hH, y, height)

//        const bottomEdge = botEdge(hY, y, height)
//        const upEdge = topEdge(hY, hH, y)

//        const leftEdge = lEdge(hX, hW, x)
//        const rightEdge = rEdge(hX, x, width)

        boundries()
//        boundries(botEdge(hY, y, height), horEdge(hX, hW, x, width), rEdge(hX, x, width), verEdge(hY, hH, y, height), lEdge(hX, hW, x))
//    }


    WorkerScript.sendMessage({
                                 "isPicked": isPicked,
                                 "i": message.i,
                                 "index": message.index
                             })
}
