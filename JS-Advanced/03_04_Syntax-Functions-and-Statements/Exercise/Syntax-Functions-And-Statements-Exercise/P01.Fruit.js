function printFruit(fruit, grams, price) {
    let weight = grams * 0.001;
    let money = weight * price;
    console.log(`I need $${money.toFixed(2)} to buy ${weight.toFixed(2)} kilograms ${fruit}.`)
}

printFruit('orange', 2500, 1.80);
printFruit('apple', 1563, 2.35);