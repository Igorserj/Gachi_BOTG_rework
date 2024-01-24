WorkerScript.onMessage = function(message) {

    /*-----------------------------------------------------*/
    /*Room allocation*/
    const staircaseLayout = ["entrance", "stairs", "stairs", "roof"]
    let corridorsLayout = [
                ["corridor", "corridor", "corridor", "corridor", "corridor"],
                ["corridor", "corridor", "corridor", "corridor", "corridor"],
                ["corridor", "corridor", "corridor", "corridor", "corridor"],
                ["corridor", "corridor", "corridor", "corridor", "corridor"]]

    function twoCombs(value, action = "+") {
        let values = []
        for (let i = 0; i < value.length - 1; i++) {
            if (action === "+") values.push(value[i] + value[i + 1])
            else if (action === "-") values.push(Math.abs(value[i] - value[i + 1]))
        }
        return values
    }
    function threeCombs(value) {
        let values = []
        for (let i = 0; i < value.length - 2; i++) {
            values.push(value[i] + value[i + 1] + value[i + 2])
        }
        return values
    }
    function evenOddsSwap(value) {
        let values = []
        for (let i = 0; i < value.length / 2; i++) {
            values.push(value[i * 2 + 1], value[i * 2])
        }
        return values
    }
    function fromMinToMax(value) {
        let indexes = []
        let index
        let min
        let j
        for (let i = 0; i < value.length; i++) {
            index = i
            min = 19
            for (j = 0; j < value.length; j++) {
                if ( value[j] < min ) {
                    min = value[j]
                    index = j
                }
            }
            indexes[index] = i + 1
            value[index] = 19
        }
        return indexes
    }

    function fromMaxToMin(value) {
        let indexes = []
        let index
        let max
        let j
        let length = value.length

        for (let i = 0; i < length; i++) {
            max = -1
            index = i
            for (j = 0; j < length; j++) {
                if (max < value[j]) {
                    max = value[j]
                    index = j
                }
            }
            indexes[index] = i + 1
            value[index] = -1
        }
        return indexes
    }

    function shifts(values, n) {
        let leftage
        if (n >= values.length) {
            n -= values.length
        }
        leftage = values.slice(values.length - n)
        values.splice(values.length - n, values.length - 1)
        return leftage.concat(values)
    }

    function sortFromMinToMax(value) {
        let values = []
        let length = value.length
        for (let i = 0; i < length; i++) {
            if (i === length - 1) {
                values.push(value[0])
            }
            else {
                if (value[0] <= value[1]) {
                    values.push(value[0])
                    value.splice(0, 1)
                }
                else {
                    values.push(value[1])
                    value.splice(1, 1)
                }
            }
        }
        return values
    }

    function sortFromMaxToMin(value) {
        let values = []
        let length = value.length
        for (let i = 0; i < length; i++) {
            if (i === length - 1) {
                values.push(value[0])
            }
            else {
                if (value[0] >= value[1]) {
                    values.push(value[0])
                    value.splice(0, 1)
                }
                else {
                    values.push(value[1])
                    value.splice(1, 1)
                }
            }
        }
        return values
    }

    function corridorsShift() {
        const values = twoCombs(seed)
        let values2 = []
        for (let i = 0; i < 4; i++) {
            values2.push(Math.round(values[i] / 6))
        }
        return values2
    }

    function decorsShift() {
        let values = threeCombs(seed)
        let min = 19
        let index = 0
        let decors = decorativesLayout.slice()
        for (let i = 0; i < 4; i++) {
            if (min > values[i]) {
                min = values[i]
                index = i
            }
        }
        decors[index] = decorativesLayout[0]
        decors[0] = decorativesLayout[index]
        return decors
    }

    function roomsShift() {
        let values = fromMinToMax( twoCombs( evenOddsSwap(seed) ) )
        // let rooms = [...roomsLayout]
        let values2 = []
        for (let i = 0; i < values.length; i++) {
            values2[values[i] - 1] = roomsLayout[i]
        }
        return values2
    }
    function roomsShuffle() {
        let values = seed.slice()
        let floors = [0, 0, 0, 0]
        let value = []
        let values2 = []
        for (let i = 1; i < seed.length; i++) {
            value = fromMaxToMin( threeCombs( evenOddsSwap( shifts(values.slice(), i) ) ))
            if (floors[value.indexOf(1)] + 1 <= 3) {
                floors[value.indexOf(1)] += 1
                values2.push(value.indexOf(1) + 1)
            }
            else {
                floors[value.indexOf(2)] += 1
                values2.push(value.indexOf(2) + 1)
            }
        }
        return values2
    }

    function roomsAlloc() {
        let values = []
        let value = []
        for (let i = 0; i < seed.length - 1; i++) {
            if (i % 2 === 0) {
                value = fromMinToMax( twoCombs(sortFromMinToMax(shifts(seed.slice(), i)), "-") )
            }
            else {
                value = fromMinToMax( twoCombs(sortFromMaxToMin(shifts(seed.slice(), i)), "-") )
            }
            values.push(value.indexOf(1) + 1)
        }
        return values
    }

    function decorsAlloc() {
        let values = []
        let value = []
        for (let i = 0; i < seed.length - 2; i++) {
            if (i % 2 === 0) {
                value = fromMaxToMin( twoCombs(sortFromMinToMax(shifts(seed.slice(), i)), "+") )
            }
            else {
                value = fromMaxToMin( twoCombs(sortFromMaxToMin(shifts(seed.slice(), i)), "+") )
            }
            values.push([value.indexOf(1) + 1, value.indexOf(2) + 1, value.indexOf(3) + 1, value.indexOf(4) + 1, value.indexOf(5) + 1])
        }
        return values
    }

    let seed = [7,3,5,1,4,6]//message.seed // Default [7,8,1,6,2,9] //
    const decorativesLayout = [["library", "canteen"],
                               ["wc1", "wc2"],
                               ["wc1", "wc2"],
                               ["wc1", "wc2"]]
    const roomsLayout = [ "04", "02", "key", "room", "room"]

    let i = 0
    let j = 0
    let k = 0

    function fullFill(value) {
        let length = value.length
        for (let i = 0; i < 6 - length; i++) {
            value.unshift(0)
        }
        return value
    }
    const csh = corridorsShift()
    const rs = roomsShift()
    const rsh = roomsShuffle()
    const ra = roomsAlloc()
    const dsh = decorsShift()
    const da = decorsAlloc()
    const allocation = [
                         ["","","","",""],
                         ["","","","",""],
                         ["","","","",""],
                         ["","","","",""]
                     ]
    for (i = 0; i < rs.length; i++) {
        allocation[rsh[i] - 1][ra[i] - 1] = rs[i]
    }

    for (i = 0; i < dsh.length; i++) {
        for (j = 0; j < dsh[i].length; j++) {
            for (k = 0; k < da[i].length; k++) {
                if (allocation[i][da[i][k] - 1] === "") {
                    allocation[i][da[i][k] - 1] = dsh[i][j]
                    k = da[i].length
                }
            }
        }
    }

    for (i = 0; i < corridorsLayout.length; i++) {
        corridorsLayout[i].splice(csh[i] + 1, 0, staircaseLayout[i])
        allocation[i].splice(csh[i] + 1, 0, "")
    }
    console.log(corridorsLayout)

    /*-----------------------------------------------------*/
    /*Enemy allocation*/
    let treassureRoomIds = []
    let identifier = -1
    for (i = 0; i < allocation.length; i++ ) {
        identifier = allocation[i].indexOf("room")
        if (identifier !== -1) {
            treassureRoomIds.push([i, identifier])
            identifier = allocation[i].indexOf("room", identifier + 1)
            if (identifier !== -1) {
                treassureRoomIds.push([i, identifier])
            }
        }
    }

    let enemyList = ["slave", "slave", "slave", "slave", "slave", "slave", "slave", "slave",
                     "slave", "slave", "slave", "slave", "slave", "slave", "slave", "slave",
                     "slave", "slave", "slave", "slave", "slave",
                     "man", "man", "man", "man", "man", "man", "man", "man",
                     "man", "man", "man"
        ]

    const firstKey = [seed[0], seed[2], seed[4]]
    const secondKey = [seed[1], seed[3], seed[5]]
    let keys = []
    if (treassureRoomIds.length >= 1) {
        keys.push([[], []])
        keys[0][0] = [firstKey[0] + firstKey[1], firstKey[0] + firstKey[2], firstKey[1] + firstKey[2]]
        keys[0][1] = [Math.abs(firstKey[0] - firstKey[1]), Math.abs(firstKey[0] - firstKey[2]), Math.abs(firstKey[1] - firstKey[2])]
        if (treassureRoomIds.length == 2) {
            keys.push([[], []])
            keys[1][0] = [secondKey[0] + secondKey[1], secondKey[0] + secondKey[2], secondKey[1] + secondKey[2]]
            keys[1][1] = [Math.abs(secondKey[0] - secondKey[1]), Math.abs(secondKey[0] - secondKey[2]), Math.abs(secondKey[1] - secondKey[2])]
        }
    }

    const randomNumbers = [[[2, -7, 4], [-3, 5, -8]], [[-6, 2, 5], [9, -4, 2]]]

    if (treassureRoomIds.length >= 1) {
        keys[0][0] = keys[0][0].map(function (num, idx) {
            return num + randomNumbers[0][0][idx]
        })
        keys[0][1] = keys[0][1].map(function (num, idx) {
            return Math.abs(num - randomNumbers[0][1][idx])
        })
        keys[0] = keys[0][0].map(function (num, idx) {
            return num + keys[0][1][idx]
        })

        if (treassureRoomIds.length == 2) {
            keys[1][0] = keys[1][0].map(function (num, idx) {
                return num + randomNumbers[1][0][idx]
            })
            keys[1][1] = keys[1][1].map(function (num, idx) {
                return Math.abs(num - randomNumbers[1][1][idx])
            })
            keys[1] = keys[1][0].map(function (num, idx) {
                return num + keys[1][1][idx]
            })
        }
    }

    const medians = [[18, 4, 25], [7, 19, 17]]

    let treassureRoomAlloc = keys.map(function (num, idx) {
        return num.map(function (_num, _idx) {return _idx % 2 === 0 ? _num <= medians[idx][_idx] ? "slave" : "man" : _num >= medians[idx][_idx] ? "slave" : "man"})
    }) //false = man, true = slave

    treassureRoomAlloc.map(function (elem, idx) { elem.map(function (_elem, _idx) { return _elem ? enemyList.shift() : enemyList.pop() })})

    let listLength = enemyList.length
    function dot(a,b) {
        return a[0] * b[0] + a[1] * b[1]
    }

    function pseudoRandom(st, q) {
        return Math.round( q/2 + ((Math.sin(dot(st, [12.9898, 78.233])) * 43758.5453123) % q/2) )
    }

    let enemyAlloc = []
    enemyList.map(function () { enemyAlloc.push([]) })

    i = 0
    let number = -1
    while (enemyList.length > 0) {
        number = pseudoRandom([i , seed.join('')], listLength - 1)
        if (enemyAlloc[number].length < 2) {
            enemyAlloc[number].push(enemyList.shift())
        }
        i++
    }
    let corridorEnemy = []
    corridorsLayout.map(function (elem, idx) { corridorEnemy.push([enemyAlloc.shift(), enemyAlloc.shift(), enemyAlloc.shift(), enemyAlloc.shift(), enemyAlloc.shift()]) })

    for (i = 0; i < corridorEnemy.length; i++) {
        corridorEnemy[i].splice(csh[i] + 1, 0, [])
    }
    let corridorEnemyMeta = corridorEnemy.map( function (elem) {return elem.map( function (_elem) {return _elem.map((__elem) => {return { type: __elem, name: "Steve" }})} )} )

    let roomEnemy = []
    allocation.map( function (elem, idx) { roomEnemy.push( elem.map( (_elem, _idx) => (_elem === "wc1" || _elem === "wc2") ? enemyAlloc.shift() : _elem === "room" ? treassureRoomAlloc.shift() : [] )) } )
    let roomEnemyMeta = roomEnemy.map( function (elem) {return elem.map( function (_elem) {return _elem.map((__elem) => {return { type: __elem, name: "Alex" }})} )} )

    corridorEnemy = corridorEnemy.map( function (elem) {return elem.map( function (_elem) {return _elem.map(() => { return ["hostile"] })} )} )
    roomEnemy = roomEnemy.map( function (elem) {return elem.map( function (_elem) {return _elem.map(() => { return ["hostile"] })} )} )

    WorkerScript.sendMessage({
                                 'allocation' : allocation,
                                 'corShift' : csh,
                                 'corridorsLayout' : corridorsLayout,
                                 'type' : message.type,
                                 'corNmy' : corridorEnemy,
                                 'roomNmy' : roomEnemy,
                                 'corNmyM' : corridorEnemyMeta,
                                 'roomNmyM' : roomEnemyMeta
                             })
}
