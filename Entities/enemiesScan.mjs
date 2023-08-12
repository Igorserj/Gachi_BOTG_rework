WorkerScript.onMessage = function (message) {

    let index = message.index
    let objects = message.objects

    let type = message.objects[index][0]
    let enemyIdsPool = []
    for (let i = 0; i < objects.length; i++) {
            enemyIdsPool.push(i)
    }

    WorkerScript.sendMessage({
                                 "ids": enemyIdsPool,
                                 "index": index
                             })

}
