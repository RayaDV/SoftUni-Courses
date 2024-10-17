function solution() {
    let store = {
        protein: 0,
        carbohydrate: 0,
        fat: 0,
        flavour: 0
    };

    let meals = { // const is also available
        apple: { carbohydrate: 1, flavour: 2 },
        lemonade: { carbohydrate: 10, flavour: 20 },
        burger: { carbohydrate: 5, fat: 7, flavour: 3 },
        eggs:  { protein: 5, fat: 1, flavour: 1 },
        turkey:  { protein: 10, carbohydrate: 10, fat: 10, flavour: 10 }
    };

    return (instruction) => {
        const robot = manager();
        let [command, element, quantity] = instruction.split(' ');
        return robot[command](element, quantity);
    };

    function manager() {
        let successMessage = 'Success';

        return {
            restock,
            prepare,
            report
        }

        function restock(element, quantity) {
            store[element] += Number(quantity);
            return successMessage;
        }

        function prepare(recipe, quantity) {
            const products = meals[recipe];
            let resultMessage = successMessage;
            let copyStore = JSON.parse(JSON.stringify(store)); // to protect the store from errors, if we are sure we can manipulate the store directly


            if (productsAvailable(products)) {
                for (let product in products) {
                    copyStore[product] -= products[product] * Number(quantity);
                }
            }

            return resultMessage;

            function productsAvailable(products) {
                let isAvailable = true;

                for (let product in products) {
                    let neededQuantity = products[product] * Number(quantity);
                    let availableQuantity = copyStore[product];
                    if (availableQuantity < neededQuantity) {
                        resultMessage = `Error: not enough ${product} in stock`;
                        isAvailable = false;
                        break;
                    }
                }

                store = copyStore;
                return isAvailable;
            }
        }

        function report() {
            let report = '';
            for (let ingredient in store) {
                report += `${ingredient}=${store[ingredient]} `;
            }
            return report.trim();
        }

    }
}

let manager = solution (); 
console.log (manager ("restock flavour 50")); // Success 
console.log (manager ("prepare lemonade 4")); // Error: not enough carbohydrate in stock 
