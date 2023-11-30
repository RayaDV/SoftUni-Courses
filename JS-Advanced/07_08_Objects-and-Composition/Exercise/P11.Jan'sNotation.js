function solve(arr) {
    let output = [];
    let numbers = [];
    let operators = [];

    let operationEnum = {
        "+": (a, b) => a + b,
        "-": (a, b) => a - b,
        "*": (a, b) => a * b,
        "/": (a, b) => a / b
    }

    for (let el of arr) {
        if (typeof(el) === "number") {
            numbers.push(el);
        } else {
            operators.push(el);
        }
    }

    if (operators.length < numbers.length - 1) {
        console.log("Error: too many operands!");
        return;
    }
    if (numbers.length <= operators.length) {
        console.log("Error: not enough operands!");
        return;
    }

    for (let el of arr) {
        if (typeof(el) === "number") {
            output.push(el);
            continue;
        }
        let numA = output.pop();
        let numB = output.pop();
        let result = operationEnum[el](numB, numA);
        output.push(result);
    }
    console.log(output.join());
}

solve([3, 4, '+']);
solve([5, 3, 4, '*', '-']);
solve([7, 33, 8, '-']);
solve([15, '/']);