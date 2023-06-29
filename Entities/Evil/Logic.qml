import QtQuick 2.15

Item {

    SequentialAnimation {
        running: entGen.repeater.numberOfCreatedObjects / entGen.objects.length === 1
        paused: ifaceLoader.item.state === "menu"
        loops: Animation.Infinite
        ScriptAction {
            script: dir()//hostile.state !== "idle" ? dir() : idle()
        }

        PauseAnimation {
            duration: 200
        }
    }
    WorkerScript {
        id: directionScript
        source: "direction.mjs"
        onMessage: {
            if (!messageObject.idle) {
                controls(messageObject.hd, messageObject.vd)
            }
            else {
                hostile.state = "idle"
            }
        }
    }

    function dir() {
        if (!movementBlocked) {
            let enemies = heroScan()
            directionScript.sendMessage({
                                            "objects": objGen.objects,
                                            "x": hostile.parent.x,
                                            "width": hostile.width,
                                            "y": hostile.parent.y,
                                            "height": hostile.height,
                                            "hX": enemies[0],
                                            "hY": enemies[1],
                                            "hW": enemies[2],
                                            "hH": enemies[3],
                                            "states": enemies[4]
                                        })
        }
    }

    function heroScan() {
        var xPool = []
        var yPool = []
        var wPool = []
        var hPool = []
        var statesPool = []
        for (let i = 0; i < entGen.objects.length; i++) {
            if (entGen.objects[i][0] === "hero") {
                xPool.push(entGen.repeater.itemAt(i).x)
                yPool.push(entGen.repeater.itemAt(i).y)
                wPool.push(entGen.repeater.itemAt(i).item.width)
                hPool.push(entGen.repeater.itemAt(i).item.height)
                statesPool.push(entGen.repeater.itemAt(i).item.state)
            }
        }
        return [xPool, yPool, wPool, hPool, statesPool]
    }

    function controls(horizontalDirection, verticalDirection) {
            if (stamina > 5 && !recovery) {runActive()}
            else hostile.run = 0
            if (horizontalDirection === 0) {
                facingRight === false ? toTheLeft() : facingRight = false
            }
            else if (horizontalDirection === 1) {
                facingRight === true ? toTheRight() : facingRight = true
            }
            else if (horizontalDirection === -1) {
                walkLeft = false
                animations.moveLeftRun = false
                walkRight = false
                animations.moveRightRun = false
            }

            if (verticalDirection === 0) {
                toTheTop()
            }
            else if (verticalDirection === 1) {
                toTheBot()
            }
            else if (verticalDirection === -1) {
                walkUp = false
                animations.moveUpRun = false
                walkDown = false
                animations.moveDownRun = false
            }
        if (animations.attackReady) nmyScan()
    }
}
