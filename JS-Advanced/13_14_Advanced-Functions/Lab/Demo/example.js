
function createFunc(myFunc) {
    return function (a, b, c) {
        return myFunc(a, b, c);
    }
}
let sum = craeteFunc((a, b, c) => a + b + c);
console.log(sum(1, 2, 3));
