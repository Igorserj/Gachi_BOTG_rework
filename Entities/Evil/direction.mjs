WorkerScript.onMessage = function (message) {

    let objects = message.objects
    let indexH = -1
    let indexHValue = 10
    let indexV = -1
    let indexVValue = 10
    let x = message.x
    let width = message.width
    let y = message.y
    let height = message.height
    let idle = false

    const hX = message.hX
    const hW = message.hW
    const hY = message.hY
    const hH = message.hH
    const states = message.states

    let horizontalDirection = -1
    let verticalDirection = -1

    function simpleHorMove(toX, toWidth = 0) {
        if (toX + toWidth <= x)
            horizontalDirection = 0
        else if (toX >= x + width)
            horizontalDirection = 1
        else
            horizontalDirection = -1
    }

    function simpleVertMove(toY, toHeight = 0) {
        if (toY + toHeight <= y)
            verticalDirection = 0
        else if (toY >= y + height)
            verticalDirection = 1
        else
            verticalDirection = -1
    }
    let value
    let i = 0
    for (i = 0; i < objects.length; i++) {
        value = (Math.min(Math.abs(objects[i][0] - (x + width)),
                              Math.abs(objects[i][0] + objects[i][2] - x)))
        if (value < indexHValue) {
            indexHValue = value
            indexH = i
        }
    }
    for (i = 3; i < objects.length; i++) {
        value = Math.min(Math.abs(objects[i][1] - (y + height)),
                             Math.abs(objects[i][1] + objects[i][3] - y))
        if (value < indexVValue) {
            indexVValue = value
            indexV = i
        }
    }

    let closestHero = -1
    let closestDistance = 9999
    for (i = 0; i < hX.length; i++) {
        const distance = Math.pow(Math.pow((x + width / 2) - (hX[i] + hW[i] / 2), 2) + Math.pow((y + height / 2) - (hY[i] + hH[i] / 2), 2), 1 / 2)
        if (closestDistance > distance && states[i] !== "dead") {
            closestDistance = distance
            closestHero = i
        }
    }

    if (closestHero === -1) {
        horizontalDirection = -1
        verticalDirection = -1
        idle = true
    }
    else {
        simpleHorMove(hX[closestHero], hW[closestHero])
        simpleVertMove(hY[closestHero], hH[closestHero])
    }
    WorkerScript.sendMessage({
                                 "hd": horizontalDirection,
                                 "vd": verticalDirection,
                                 "idle": idle
                             })
}
