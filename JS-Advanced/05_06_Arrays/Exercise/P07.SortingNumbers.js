function sortingNumbers(arr) {
    arr.sort((a, b) => a - b);
    let firstLength = arr.length;
    let result = [];
    for (let i = 0; i < firstLength / 2; i++) {
        result.push(arr.shift());
        result.push(arr.pop());
    }
    return result;
}

console.log(sortingNumbers([1, 65, 3, 52, 48, 63, 31, -3, 18, 56]));
// console.log(sortingNumbers([4, 3, 2, 1]));