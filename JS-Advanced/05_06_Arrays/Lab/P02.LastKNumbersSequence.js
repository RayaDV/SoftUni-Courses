function lastKNumbersSeq(n, k) {
    let arr = [1];
    arr[0] = 1;
    for(let i = 1; i < n; i++) {
        arr[i] = 0;
        for(let j = 1; j <= k; j++) {
            if(arr[i - j] != undefined) {
                arr[i] += arr[i - j];
            }
        }
    }
    return arr;
}

console.log(lastKNumbersSeq(6, 3));
console.log(lastKNumbersSeq(8, 2));