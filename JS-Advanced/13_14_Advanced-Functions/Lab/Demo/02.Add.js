function solutionArrow(num1) {
    return add = (num2) => num1 + num2;
}

function solution(num1) {
    return function add(num2) {
        return num1 + num2;
    }
}

let add5 = solutionArrow(5);
console.log(add5(2));
console.log(add5(3));

let add7 = solution(7);
console.log(add7(2));
console.log(add7(3));
