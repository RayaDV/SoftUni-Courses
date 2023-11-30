function townPopulation(input){
    const towns = {};
    for (let townAsString of input) {
        let [name, population] = townAsString.split(" <-> ");
        population = Number(population);

        if (towns[name] != undefined) {
            population += towns[name];
        }
        towns[name] = population;
    }

    for (let town in towns) {
        console.log(`${town} : ${towns[town]}`);
    }
}

// townPopulation(['Sofia <-> 1200000',
// 'Montana <-> 20000',
// 'New York <-> 10000000',
// 'Washington <-> 2345000',
// 'Las Vegas <-> 1000000']
// );
// townPopulation(['Istanbul <-> 100000',
// 'Honk Kong <-> 2100004',
// 'Jerusalem <-> 2352344',
// 'Mexico City <-> 23401925',
// 'Istanbul <-> 1000']
// );

function solve(input) {
    let townData = input
        .map(element => {
            let data = element.split(' <-> ');
            return {
                name: data[0],
                population: Number(data[1])
        };
    });
    let towns = {};

    for (let town of townData) {
        if (towns[town.name] === undefined) {
            towns[town.name] = town.population;
        } else {
            towns[town.name] += town.population;
        }
    }

    for (let town in towns) {
        console.log(`${town.name} : ${town.population}`);
    }
}

function solveReduce(input) {
    let towns = input
        .map(element => {
            let data = element.split(' <-> ');
            return {
                name: data[0],
                population: Number(data[1])
            };
        })
        .reduce((result, town) => {
            if (result[town.name] === undefined) {
                result[town.name] = town.population;
            } else {
                result[town.name] += town.population;
            }
            return result;
        }, {});

        for (let town in towns) {
            console.log(`${town} : ${towns[town]}`);
        }
}

console.log(solveReduce(['Istanbul <-> 100000',
'Honk Kong <-> 2100004',
'Jerusalem <-> 2352344',
'Mexico City <-> 23401925',
'Istanbul <-> 1000']
));
