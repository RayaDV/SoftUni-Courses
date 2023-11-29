function extractSubseq(array) {
    let result = [];
    let max = -Infinity;
    for (let num of array) {
        if (num >= max) {
            result.push(num);
            max = num;
        }
    }

    // res = array.reduce((acc, currEl) => {
    //     if(max <= currEl) {
    //         acc.push(currEl);
    //         max = currEl;
    //     }
    //     return acc
    // }, []);
    return result;
}

console.log(extractSubseq([1, 
    3, 
    8, 
    4, 
    10, 
    12, 
    3, 
    2, 
    24]
    ));
console.log(extractSubseq([1, 
    2, 
    3,
    4]
    ));