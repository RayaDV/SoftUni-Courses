let solve = (function () {
    let sum = 0;
 
    return function add(number) {
        sum += number;
        add.toString = () => sum;
        return add;
    }
})();
 
console.log(solve(1)(6)(-3).toString());

