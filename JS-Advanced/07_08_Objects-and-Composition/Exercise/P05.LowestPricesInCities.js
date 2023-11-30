function lowestPriceInCities(input) {
    let result = {};

    for (const element of input) {
        let [town, product, price] = element.split(" | ");
        price = Number(price);

        if(!result.hasOwnProperty(product)) {
            result[product] = {town, price};
        } else {
            let curPrice = result[product]["price"];  
      //Or: let curPrice = result[product].price;
            if (curPrice > price) {
                result[product] = {town, price};
            }
        }
    }
    
    for (let [product, value] of Object.entries(result)) {
            console.log(`${product} -> ${value.price} (${value.town})`)
    }
}

// lowestPriceInCities([
//     'Sample Town | Sample Product | 1000',
//     'Sample Town | Orange | 2',
//     'Sample Town | Peach | 1',
//     'Sofia | Orange | 3',
//     'Sofia | Peach | 2',
//     'New York | Sample Product | 1000.1',
//     'New York | Burger | 10'
// ]);
lowestPrice([
    'Sofia City | Audi | 100000',
    'Sofia City | BMW | 100000',
    'Sofia City | Mitsubishi | 10000',
    'Sofia City | Mercedes | 10000',
    'Sofia City | NoOffenseToCarLovers | 0',
    'Mexico City | Audi | 1000',
    'Mexico City | BMW | 99999',
    'Mexico City | Mitsubishi | 10000',
    'New York City | Mitsubishi | 1000',
    'Washington City | Mercedes | 1000]'
]);

function lowestPrice(input) {
    let products = [];

    for (const element of input) {
        let [town, name, price] = element.split(" | ");
        price = Number(price);

        if (!products.some(pr => pr.productName === name)) {
            let product = {
                "productName": name, 
                "productLowestPrice": price, 
                "townName": town
            };
            products.push(product);
        } else {
            let product = products.find(pr => pr.productName === name);
            if (product.productLowestPrice > price) {
                product.productLowestPrice = price;
                product.townName = town;
            }
        }
    }
    for (let pr of products) {
        console.log(`${pr.productName} -> ${pr.productLowestPrice} (${pr.townName})`);
    }
}