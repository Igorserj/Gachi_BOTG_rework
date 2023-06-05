WorkerScript.onMessage = function (message) {

    let hX = message.hX
    let hY = message.hY
    let hW = message.hW
    let hH = message.hH
    let hor = message.hor
    let dir = message.dir
    let speed = message.speed

    let x = message.x
    let y = message.y
    let height = message.height
    let width = message.width

    let walkLeft = 1
    let walkRight = 1
    let walkUp = 1
    let walkDown = 1

    let edge = -1

    function horizontalCol(leftBoundry, rightBoundry, verticalBoundry) {
        if (leftBoundry && verticalBoundry) {
            walkLeft = 0
        } else
            walkLeft = 1

        if (rightBoundry && verticalBoundry) {
            walkRight = 0
        } else
            walkRight = 1
    }

    function verticalCol(lowerBoundry, upperBoundry, horizontalBoundry) {
        if (lowerBoundry && horizontalBoundry) {
            walkDown = 0
        } else
            walkDown = 1

        if (upperBoundry && horizontalBoundry) {
            walkUp = 0
        } else
            walkUp = 1
    }
    if (hor === 1) {
        var leftBoundry = hX - speed <= x + width && hX + speed >= x
        var rightBoundry = hX + hW + speed >= x && hX + hW - speed <= x + width
        var verticalBoundry = hY + hH + 1 > y && hY - 1 < y + height
        horizontalCol(leftBoundry, rightBoundry, verticalBoundry)
    } else if (hor === 0) {
        var upperBoundry = hY - speed <= y + height && hY + speed >= y
        var lowerBoundry = hY + hH + speed >= y && hY + hH - speed <= y + height
        var horizontalBoundry = hX - 1 < x + width && hX + hW + 1 > x
        verticalCol(lowerBoundry, upperBoundry, horizontalBoundry)
    }

    if (hor === 0 && dir === 0 && walkUp === 0) {
        edge = y + height + 1
    }
    else if (hor === 0 && dir === 1 && walkDown === 0) {
        edge = y - hH - 1
    }
    else if (hor === 1 && dir === 0 && walkLeft === 0) {
        edge = x + width + 1
    }
    else if (hor === 1 && dir === 1 && walkRight === 0) {
        edge = x - hW - 1
    }


    WorkerScript.sendMessage({
                                 "walkLeft": walkLeft,
                                 "walkRight": walkRight,
                                 "walkUp": walkUp,
                                 "walkDown": walkDown,
                                 "edge": edge,
                                 "hor": hor,
                                 "dir": dir,
                                 "i": message.i
                             })
}
