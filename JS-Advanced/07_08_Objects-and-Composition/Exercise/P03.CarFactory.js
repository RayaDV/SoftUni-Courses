function carFactory(input) {
    let output = {};
    output.model = input.model;

    // if (input.power <= 90) {
    //     output.engine = {
    //         power: 90,
    //         volume: 1800
    //     }
    // } else if (input.power <= 120) {
    //     output.engine = {
    //         power: 120,
    //         volume: 2400
    //     }
    // } else if (input.power <= 200) {
    //     output.engine = {
    //         power: 200,
    //         volume: 3500
    //     }
    // }

    let engineEnum = {
        "Small engine": { power: 90, volume: 1800 },
        "Normal engine": { power: 120, volume: 2400 },
        "Monster engine": { power: 200, volume: 3500 }
    }
    if (input.power <= 90) {
        output.engine = engineEnum["Small engine"];
    } else if (input.power <= 120) {
        output.engine = engineEnum["Normal engine"];
    } else if (input.power <= 200) {
        output.engine = engineEnum["Monster engine"];
    }

    output.carriage = {
        type: input.carriage,
        color: input.color
    }

    let size = input.wheelsize % 2 !== 0 ? 
        input.wheelsize : input.wheelsize - 1;
    // if (input.wheelsize % 2 !== 0) {
    //     size = input.wheelsize;
    // } else {
    //     size = input.wheelsize - 1;
    // }
    output.wheels = new Array(4).fill(size);

    return output;
}


carFactory({ model: 'VW Golf II',
power: 90,
color: 'blue',
carriage: 'hatchback',
wheelsize: 14 }
);
console.log("----------");
carFactory({ model: 'Opel Vectra',
power: 110,
color: 'grey',
carriage: 'coupe',
wheelsize: 17 }
);