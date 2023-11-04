WorkerScript.onMessage = function(message) {

    const staircaseLayout = ["entrance", "stairs", "stairs", "roof"]
    var corridorsLayout = [
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
//        console.log(values, values2)
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
        let rooms = roomsLayout.slice()
        let values2 = []
        for (let i = 0; i < values.length; i++) {
            values2[values[i] - 1] = rooms[i]
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

    let seed = message.seed
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
    }
    console.log(corridorsLayout)

    WorkerScript.sendMessage({
                                 'allocation' : allocation,
                                 'corShift' : csh,
                                 'corridorsLayout' : corridorsLayout
                             })
}
