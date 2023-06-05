WorkerScript.onMessage = function (message) {

    let index = message.index
    let objects = message.objects

    let type = message.objects[index][0]
    let enemyIdsPool = []
    for (let i = 0; i < objects.length; i++) {
        if (message.objects[i][0] !== type) {
            enemyIdsPool.push(i)
        }
    }

    WorkerScript.sendMessage({
                                 "ids": enemyIdsPool,
                                 "index": index
                             })

}
