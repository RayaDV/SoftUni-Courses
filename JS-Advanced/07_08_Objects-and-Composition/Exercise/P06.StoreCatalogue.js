function storeCatalogue(input) {
    let catalogue = [];

    for (let element of input) {
        let [name, price] = element.split(' : ');
        price = Number(price);

        let product = {name, price};
        catalogue.push(product);
    }
    let sortedCatalogue = catalogue.sort((a, b) => a.name.localeCompare(b.name));

    let firstLetter;
    for (let product of sortedCatalogue) {
        if (product.name.charAt(0) !== firstLetter) {
            firstLetter = product.name.charAt(0);
            console.log(firstLetter);
        }
        console.log(`  ${product.name}: ${product.price}`)
    }
}

storeCatalogue([
    'Appricot : 20.4',
    'Fridge : 1500',
    'TV : 1499',
    'Deodorant : 10',
    'Boiler : 300',
    'Apple : 1.25',
    'Anti-Bug Spray : 15',
    'T-Shirt : 10'
]);
console.log("---------");
storeCatalogue([
    'Banana : 2',
    'Rubic\'s Cube : 5',
    'Raspberry P : 4999',
    'Rolex : 100000',
    'Rollon : 10',
    'Rali Car : 2000000',
    'Pesho : 0.000001',
    'Barrel : 10'
]);
