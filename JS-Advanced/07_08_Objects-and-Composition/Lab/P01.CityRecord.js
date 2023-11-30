function cityRecord(name, population, treasury) {
    return {
        name: name,
        population: population,
        treasury: treasury
    };
}
function cityRecord1(name, population, treasury) {
    return {
        name,
        population,
        treasury
    };
}
function cityRecord2(name, population, treasury) {
    const city = {};
    city.name = name;
    city.population = population;
    city.treasury = treasury;
    return city;
}

console.log(cityRecord('Tortuga',
7000,
15000
));
console.log(cityRecord1('Santo Domingo',
12000,
23500
));