WorkerScript.onMessage = function(message) {

    let canBePlaced = true
    let i = 0
    const facingRight = message.facingRight
    const objects = message.objects
    const entityX = message.entityX
    const entityY = message.entityY
    const entityW = message.entityW
    const entityH = message.entityH
    let item = [0, 0, 0, 0]

    if (facingRight) {
        for (i = 0; i < objects.length; i++) {
            if ( (entityX + entityW + 30 > objects[i][0] &&
                  entityX + entityW + 20 < objects[i][0] + objects[i][2] )
                    &&
                    (entityY + entityH > objects[i][1] &&
                     entityY < objects[i][1] + objects[i][3]) ) { canBePlaced = false; i = objects.length }
            else {}
        }
        if (canBePlaced) {
            item = [entityX + entityW + 20, entityY + entityH - 10, 10, 10]
        }
    }
    else {
        for (i = 0; i < objects.length; i++) {
            if ( (entityX - 20 > objects[i][0] &&
                  entityX - 30 < objects[i][0] + objects[i][2] )
                    &&
                    (entityY + entityH > objects[i][1] &&
                     entityY < objects[i][1] + objects[i][3]) ) { canBePlaced = false; i = objects.length }
            else {}
        }
        if (canBePlaced) {
            item = [entityX - 30, entityY + entityH - 10, 10, 10]
        }
    }
    WorkerScript.sendMessage({ 'canBePlaced': canBePlaced,
                                'item': item
                             })
}
