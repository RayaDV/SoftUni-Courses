function solve(number, ...operations) {
    number = Number(number);
    const parser = {
        chop: num => num / 2,   // same as: // chop(num) { return num => num / 2; },
        dice: num => Math.sqrt(num),
        spice: num => num + 1,
        bake: num => num * 3,
        fillet: num => num * 0.80
    }
    for(let operation of operations) {
        number = parser[operation](number);
        console.log(number);
    }
}


solve('9', 'dice', 'spice', 'chop', 'bake', 'fillet');