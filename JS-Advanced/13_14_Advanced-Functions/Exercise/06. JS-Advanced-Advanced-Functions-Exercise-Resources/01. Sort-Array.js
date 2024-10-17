function sort(arr, string) {
    string === 'asc' ? arr.sort((a, b) => a - b) 
                     : arr.sort((a, b) => b - a);
    return arr;
}

let numsAsc = sort([14, 7, 17, 6, 8], 'asc');
console.log(numsAsc);
let numsDesc = sort([14, 7, 17, 6, 8], 'desc');
console.log(numsDesc.join(', '));