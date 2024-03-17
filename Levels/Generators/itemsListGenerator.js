WorkerScript.onMessage = function(message) {

    /*-------------------------Wearable------------------------------*/
    const head1 = message.head1
    let commonHead1 = []
    let uncommonHead1 = []
    let rareHead1 = []

    const torso1 = message.torso1
    let commonTorso1 = []
    let uncommonTorso1 = []
    let rareTorso1 = []

    const legs1 = message.legs1
    let commonLegs1 = []
    let uncommonLegs1 = []
    let rareLegs1 = []

    const feet1 = message.feet1
    let commonFeet1 = []
    let uncommonFeet1 = []
    let rareFeet1 = []
    /*-------------------------------------------------------------*/

    /*-------------------------Weapon------------------------------*/
    const oneHanded1 = message.oneHanded1
    let commonOneHanded1 = []
    let uncommonOneHanded1 = []
    let rareOneHanded1 = []

    const twoHanded1 = message.twoHanded1
    let commonTwoHanded1 = []
    let uncommonTwoHanded1 = []
    let rareTwoHanded1 = []
    /*-------------------------------------------------------------*/

    /*-------------------------Usable------------------------------*/
    const ingredients1 = message.ingredients1
    let commonIngredients1 = []
    let uncommonIngredients1 = []
    let rareIngredients1 = []

    const dishes1 = message.dishes1
    let commonDishes1 = []
    let uncommonDishes1 = []
    let rareDishes1 = []
    /*-------------------------------------------------------------*/

    let treassuresSpawn = []
    const seed = message.seed
    const enemiesAllocByName = message.enemiesAllocByName
    let enemiesTreassure = []
    let enemiesCorridor = []
    let enemiesRoom = []

    const layouts = message.layouts

    let corridorsLayout = []
    let roomsLayout = []
    const ingredientsList = [...new Array(15)].map((a, i) => i)

    class Enemy {
        constructor(n) {
            //[0 Head, 1 Torso, 2 Legs, 3 Feet, 4 Nothing..., 5, 6, 7]
            this.equipments = [...new Array(8)].map((a, i) => i)
            //[0 Left, 1 Right, 2 Two]
            this.weapons = [...new Array(3)].map((a, i) => i)
            this.n = n
        }
        get equipment() {
            return this.calcEquipElement(this.n)
        }
        get weapon() {
            return this.calcWeaponElement(this.n)
        }
        get dish() {
            return this.calcDishElement(this.n)
        }
        calcEquipment(n) {
            this.m = pseudoRandomEquipment([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], this.equipments.length-1)
            this.k = this.equipments[this.m]
            this.equipments.splice(this.m, 1)
            this.equipments.pop(1)
            return this.k
        }
        calcEquipElement(n) {
            this.m = this.calcEquipment(n)
            this.rarity = 80
            if (this.m === 0) {
                if (rarityChooser([n, 4 - (this.equipments.length / 2)], this.rarity) === 0 || uncommonHead1.length === 0) return commonHead1[pseudoRandomHead([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonHead1.length-1)]
                else return uncommonHead1[pseudoRandomHead([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonHead1.length-1)]
            }
            else if (this.m === 1) {
                if (rarityChooser([n, 4 - (this.equipments.length / 2)], this.rarity) === 0 || uncommonTorso1.length === 0) return commonTorso1[pseudoRandomTorso([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonTorso1.length-1)]
                else return uncommonTorso1[pseudoRandomTorso([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonTorso1.length-1)]
            }
            else if (this.m === 2) {
                if (rarityChooser([n, 4 - (this.equipments.length / 2)], this.rarity) === 0 || uncommonLegs1.length === 0) return commonLegs1[pseudoRandomLegs([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonLegs1.length-1)]
                else return uncommonLegs1[pseudoRandomLegs([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonLegs1.length-1)]
            }
            else if (this.m === 3) {
                if (rarityChooser([n, 4 - (this.equipments.length / 2)], this.rarity) === 0 || uncommonFeet1.length === 0) return commonFeet1[pseudoRandomFeet([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonFeet1.length-1)]
                else return uncommonFeet1[pseudoRandomFeet([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonFeet1.length-1)]
            }
            else return {name: "", defense: "", rarity: "", desc: "", damage: "", range: "", hp: ""}
        }
        calcWeapon(n) {
            this.rarity = 50
            if (this.weapons.length > 1) {
                this.m = pseudoRandomWeapon([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], this.weapons.length-1)
            }
            else if (rarityChooser([100 + n, 100 - (this.weapons.length / 2)], this.rarity) === 0) this.m = -1
            else this.m = 0
            this.k = this.weapons[this.m]
            if (this.k === 2) this.weapons = []
            else {
                this.weapons.splice(this.m, 1)
                this.weapons.pop(1)
            }
            return this.k
        }
        calcWeaponElement(n) {
            this.m = this.calcWeapon(n)
            this.rarity = 80
            if (this.m === 0) {
                if (rarityChooser([n, 3 - (this.weapons.length / 2)], this.rarity) === 0 || uncommonOneHanded1.length === 0) return commonOneHanded1[pseudoRandomLeftHand([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonOneHanded1.length-1)]
                else return uncommonOneHanded1[pseudoRandomLeftHand([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonOneHanded1.length-1)]
            }
            else if (this.m === 1) {
                if (rarityChooser([n, 3 - (this.weapons.length / 2)], this.rarity) === 0 || uncommonOneHanded1.length === 0) return commonOneHanded1[pseudoRandomRightHand([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonOneHanded1.length-1)]
                else return uncommonOneHanded1[pseudoRandomRightHand([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonOneHanded1.length-1)]
            }
            else if (this.m === 2) {
                if (rarityChooser([n, 3 - (this.weapons.length / 2)], this.rarity) === 0 || uncommonTwoHanded1.length === 0) return commonTwoHanded1[pseudoRandomHands([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonTwoHanded1.length-1)]
                else return uncommonTwoHanded1[pseudoRandomHands([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonTwoHanded1.length-1)]
            }
            else return {name: "", defense: "", rarity: "", desc: "", damage: "", range: "", hp: ""}
        }

        calcDish(n) {
            if (rarityChooser([(n + 10) * 5, 50], this.rarity) === 0) return commonDishes1[pseudoRandomDish([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], commonDishes1.length-1)]
            else return uncommonDishes1[pseudoRandomDish([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], uncommonDishes1.length-1)]
        }

        calcDishElement(n) {
            this.rarity = 50
            this.m = rarityChooser([200 + n, 200], this.rarity)
            if (this.m === 1) {
                return this.calcDish(n)
            }
            else return {name: "", defense: "", rarity: "", desc: "", damage: "", range: "", hp: ""}
        }
    }

    class Man extends Enemy {}
    class Slave extends Enemy {
        calcEquipment(n) {
            if ((this.equipments.length / 2) - 1 > 0) this.m = pseudoRandomEquipment([seed.slice(0,3).join('') * (n + 1), seed.slice(3,6).join('') * (n + 1)], (this.equipments.length / 2) - 1)
            else this.m = 0
            this.k = this.equipments[this.m]
            this.equipments.splice(this.m, 1)
            this.equipments.pop(1)
            return this.k
        }
    }

    function dot(a,b) {
        return a[0] * b[0] + a[1] * b[1]
    }

    function pseudoRandomEquipment(st, q) {
        return Math.round( q/2 + ((Math.sin(dot(st, [19., 61.782])) * 65218.7) % q/2) )
    }

    function pseudoRandomHead(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [15.321, 40.51])) * 58758.54612) % q/2) )
        else return 0
    }
    function pseudoRandomTorso(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [321.15, 51.40])) * 54612.58758) % q/2) )
        else return 0
    }
    function pseudoRandomLegs(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [96.152, 91.68])) * 6301.9428) % q/2) )
        else return 0
    }
    function pseudoRandomFeet(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [152.96, 68.91])) * 9428.6301) % q/2) )
        else return 0
    }

    function pseudoRandomWeapon(st, q) {
        return Math.round( q/2 + ((Math.sin(dot(st, [432.19, 782.61])) * 7218.65) % q/2) )
    }

    function pseudoRandomOneHand(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [521.86, 68.73])) * 9084.63) % q/2) )
        else return 0
    }
    function pseudoRandomLeftHand(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [45.67, 89.934])) * 8345.51) % q/2) )
        else return 0
    }
    function pseudoRandomRightHand(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [67.45, 934.89])) * 51.8345) % q/2) )
        else return 0
    }
    function pseudoRandomHands(st, q) {
        if (q > 1) return Math.round( q/2 + ((Math.sin(dot(st, [86.521, 73.68])) * 63.9084) % q/2) )
        else return 0
    }

    function pseudoRandomDish(st, q) {
        return Math.round( q/2 + ((Math.sin(dot(st, [8.951, 97.235])) * 32454.258) % q/2) )
    }

    function pseudoRandomIngredient(st, q) {
        return Math.round( q/2 + ((Math.sin(dot(st, [951.8, 235.97])) * 258.32454) % q/2) )
    }

    function ingredientAllocation(st , floor, q) {
        return [
                    Math.round( floor/2 + ((Math.sin(dot(st, [786.452, 674.73])) * 654.47) % floor/2) ),
                    Math.round( q/2 + ((Math.sin(dot(st, [452.786, 73.674])) * 47.654) % q/2) )
                ]
    }

    function pseudoRandomWearable(st, q) {
        return Math.round( q/2 + ((Math.sin(dot(st, [987.34, 576.8423])) * 9827.345) % q/2) )
    }

    function rarityDecompose(item, common, uncommon, rare) {
        item.map(function (elem) {
            if (elem.rarity === "common") common.push(elem)
            else if (elem.rarity === "uncommon") uncommon.push(elem)
            else if (elem.rarity === "rare") rare.push(elem)
            else console.log("unknown rarity:", elem.rarity)}
        )
    }
    function rarityChooser(st, rarity1) {
        const rarity = Math.round( 50 + ((Math.sin(dot(st, [864., 932.])) * 3457.896) % 50) )
        if (rarity < rarity1) {
            return 0 //common
        }
        else return 1 //uncommon
    }

    const allItems = [
                       [head1, commonHead1, uncommonHead1, rareHead1],
                       [torso1, commonTorso1, uncommonTorso1, rareTorso1],
                       [legs1, commonLegs1, uncommonLegs1, rareLegs1],
                       [feet1, commonFeet1, uncommonFeet1, rareFeet1],
                       [oneHanded1, commonOneHanded1, uncommonOneHanded1, rareOneHanded1],
                       [twoHanded1, commonTwoHanded1, uncommonTwoHanded1, rareTwoHanded1],
                       [ingredients1, commonIngredients1, uncommonIngredients1, rareIngredients1],
                       [dishes1, commonDishes1, uncommonDishes1, rareDishes1]
                   ]
    allItems.map((item) => rarityDecompose(...item))

    function manItems(man) {
        return [man.equipment, man.equipment, man.dish]
    }
    function slaveItems(slave) {
        return [slave.equipment, slave.equipment, slave.equipment, slave.equipment, slave.weapon, slave.weapon, slave.dish]
    }

    enemiesTreassure = enemiesAllocByName.treassure.map(function (item, index) { return item.map(function (enemy, i) {
        if (enemy === "man") {
            const man = new Man(index * 3 + i)
            return manItems(man)
        }
        else if (enemy === "slave") {
            const slave = new Slave(index * 3 + i)
            return slaveItems(slave)
        }
        else {
            console.log("unknown enemy")
            return [[""]]
        }
    }) })

    enemiesCorridor = enemiesAllocByName.corridor.map(function (floor, index) { return floor.map(function (item, ind) {
        return item.map(function (enemy, i) {
            if (enemy === "man") {
                const man = new Man(6 + index * 20 + ind * 2 + i)
                return manItems(man)
            }
            else if (enemy === "slave") {
                const slave = new Slave(6 + index * 20 + ind * 2 + i)
                return slaveItems(slave)
            }
            else {
                console.log("unknown enemy")
                return [[""]]
            }
        })
    }) })

    enemiesRoom = enemiesAllocByName.room.map(function (floor, index) { return floor.map(function (item, ind) {
        return item.map(function (enemy, i) {
            if (enemy === "man") {
                const man = new Man(6 + 4 * 20 + index * 4 + ind * 2 + i)
                return manItems(man)
            }
            else if (enemy === "slave") {
                const slave = new Slave(6 + 4 * 20 + index * 4 + ind * 2 + i)
                return slaveItems(slave)
            }
            else {
                console.log("unknown enemy")
                return [[""]]
            }
        })
    }) })

    corridorsLayout = layouts.corridorsLayout.map(function (floor) { return floor.map(function (item) { if (item === "corridor") return []; else return 0 }) })
    roomsLayout = layouts.allocation.map(function (floor) { return floor.map(function (item) { if (item === "room" || item === "02" || item === "04" || item === "canteen" || item === "library") return []; else return 0 }) })
    corridorsLayout = [...corridorsLayout, ...roomsLayout]
    let i = 0
    ingredientsList.map(function (item) {
        let random
        do {
            random = ingredientAllocation([seed.slice(0,3).join('') * (i + 1), seed.slice(3,6).join('') * (i + 1)], 7, 4)
            i++
        }
        while (corridorsLayout[random[0]][random[1]] === 0 || corridorsLayout[random[0]][random[1]].length === 5)
        corridorsLayout[random[0]][random[1]].push(
                    rarityChooser([seed.slice(0,3).join('') * (i + 1), seed.slice(3,6).join('') * (i + 1)], 80) === 0 ?
                        commonIngredients1[pseudoRandomIngredient([seed.slice(0,3).join('') * (i + 1), seed.slice(3,6).join('') * (i + 1)], commonIngredients1.length-1)] :
                        uncommonIngredients1[pseudoRandomIngredient([seed.slice(0,3).join('') * (i + 1), seed.slice(3,6).join('') * (i + 1)], uncommonIngredients1.length-1)]
                    )
    })
    corridorsLayout = corridorsLayout.map((floor)=>floor.map((item)=> item.length === 0 ? 0 : item))

    function wearableChoose(index, i) {
        let k = [(seed[0].toString() + seed[2] + seed[4]) * (index * 5 + i * 2), [seed[1].toString() + seed[3] + seed[5]] * (index * 5 + i * 2)]
        let j = pseudoRandomWearable(k, 3)
        let l = -1
        let equipment
        if (j === 0) {
            l = pseudoRandomHead(k, rareHead1.length-1)
            equipment = rareHead1[l]
            rareHead1.splice(l, 1)
        }
        else if (j === 1) {
            l = pseudoRandomTorso(k, rareTorso1.length-1)
            equipment = rareTorso1[l]
            rareTorso1.splice(l, 1)
        }
        else if (j === 2) {
            l = pseudoRandomLegs(k, rareLegs1.length-1)
            equipment = rareLegs1[l]
            rareLegs1.splice(l, 1)
        }
        else if (j === 3) {
            l = pseudoRandomFeet(k, rareFeet1.length-1)
            equipment = rareFeet1[l]
            rareFeet1.splice(l, 1)
        }
        return [equipment, weaponChoose(index, i)]
    }

    function weaponChoose(index, i) {
        let k = [(seed[5].toString() + seed[3] + seed[4]) * (index * 5 + i * 2), [seed[1].toString() + seed[2] + seed[0]] * (index * 5 + i * 2)]
        let j = pseudoRandomWeapon(k, 1)
        let l = -1
        let weapon
        if (j === 0) {
            l = pseudoRandomOneHand(k, rareOneHanded1.length-1)
            weapon = rareOneHanded1[l]
            rareOneHanded1.splice(l, 1)
        }
        else if (j === 1) {
            l = pseudoRandomHands(k, rareTwoHanded1.length-1)
            weapon = rareTwoHanded1[l]
            rareTwoHanded1.splice(l, 1)
        }
        return weapon
    }

    treassuresSpawn = layouts.allocation.map((floor, index)=>floor.map(function (room, i) { return room === "room" ? wearableChoose(index, i) : 0 }))
    treassuresSpawn = treassuresSpawn.map((a)=>a.map((b)=>b===0?[]:b))
    corridorsLayout = corridorsLayout.map((a)=>a.map((b)=>b===0?[]: b))
    const corLength = corridorsLayout.length
    roomsLayout = []
    for (i = 0; i < corLength / 2; ++i) {
        roomsLayout.unshift(corridorsLayout.pop())
    }
    roomsLayout = roomsLayout.map((a, ind)=>a.map((b, i)=>treassuresSpawn[ind][i].length > 0 ? treassuresSpawn[ind][i] : b.length > 0 ? b : []))
    console.log(treassuresSpawn.map((a)=>a.map((b)=>b.map((c)=>c.name))))
    console.log("Generator Treassure", enemiesTreassure.map((a)=>a.map((b)=>b.map((c)=>c.name))))
    console.log("Generator Room", enemiesRoom.map((a)=>a.map((b)=>b.map((c)=>c.map((d)=>d.name)))))
    console.log("Corridors Layout", corridorsLayout.map((a)=>a.map((b)=>b.map((c)=>c.name))))
    console.log("Rooms Layout", roomsLayout.map((a)=>a.map((b)=>b.map((c)=>c.name))))

    WorkerScript.sendMessage({
                                 'treassuresSpawn' : treassuresSpawn,
                                 'corridorsLayout' : corridorsLayout,
                                 'roomsLayout' : roomsLayout,
                                 'enemiesTreassure' : enemiesTreassure,
                                 'enemiesCorridor' : enemiesCorridor,
                                 'enemiesRoom' : enemiesRoom
                             })
}
