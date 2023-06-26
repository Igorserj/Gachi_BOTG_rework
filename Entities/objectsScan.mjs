WorkerScript.onMessage = function (message) {

    let x = message.x
    let y = message.y
    let width = message.width
    let height = message.height

    let hor = message.hor
    let speed = message.speed

    let objects = message.objects

    let index = []
    for (var i = 0; i < objects.length; i++) {
        if (hor === 1) {
            if (Math.abs(objects[i][0] - (x + width)) <= speed || Math.abs(
                        objects[i][0] + objects[i][2] - x) <= speed) {
                index.push(i)
//                i = objects.length - 1
            }
        }
        else if (hor === 0) {
            if (Math.abs(objects[i][1] - (y + height)) <= speed || Math.abs(
                        objects[i][1] + objects[i][3] - y) <= speed) {
                index.push(i)
//                i = objects.length - 1
            }
        }
    }

    WorkerScript.sendMessage({
                                 "index": index,
                                 "hor": hor,
                                 "dir": message.dir
                             })
}
