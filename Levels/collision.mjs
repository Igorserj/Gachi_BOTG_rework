WorkerScript.onMessage = function (message) {

    const hX = message.hX
    const hY = message.hY
    const hW = message.hW
    const hH = message.hH
    const hor = message.hor
    const dir = message.dir
    const speed = message.speed

    const indices = message.index
    const objects = message.objects

    let walkLeft = 1
    let walkRight = 1
    let walkUp = 1
    let walkDown = 1

    let lefts = []
    let rights = []
    let ups = []
    let downs = []

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

    function horOrVer(x, y, width, height) {
        if (hor === 1) {
            const leftBoundry = hX + hW > x
            const rightBoundry = hX < x + width
            const verticalBoundry = hY + hH > y && hY < y + height
            horizontalCol(leftBoundry, rightBoundry, verticalBoundry)

        } else if (hor === 0) {
            const lowerBoundry = hY < y + height
            const upperBoundry = hY + hH > y
            const horizontalBoundry = hX + hW > x && hX < x + width
            verticalCol(lowerBoundry, upperBoundry, horizontalBoundry)
        }
    }

    function canWalk(x, y, width, height) {
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
    }

    for (let j = 0; j < indices.length; j++) {
        const x = objects[indices[j]][0]
        const y = objects[indices[j]][1]
        const width = objects[indices[j]][2]
        const height = objects[indices[j]][3]
        horOrVer(x, y, width, height)
        canWalk(x, y, width, height)
        lefts.push(walkLeft)
        rights.push(walkRight)
        ups.push(walkUp)
        downs.push(walkDown)
    }

    walkLeft = lefts.includes(0) ? 0 : 1
    walkRight = rights.includes(0) ? 0 : 1
    walkUp = ups.includes(0) ? 0 : 1
    walkDown = downs.includes(0) ? 0 : 1

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
