function magicMatrices(matrix) {
    for (let row = 0; row < matrix.length - 1; row++) {
        let sumRowOne = matrix[row].reduce((acc, el) => acc + el);
        let sumRowTwo = matrix[row + 1].reduce((acc, el) => acc + el);
        let sumColOne = 0;
        let sumColTwo = 0;
        for(let col = 0; col < matrix[row].length; col++) {
            sumColOne += matrix[row][col];
            sumColTwo += matrix[row + 1][col];
        }
        if (sumRowOne !== sumRowTwo || sumColOne !== sumColTwo) {
            return false;
        }
    }
    return true;
}

console.log(magicMatricesVik([[11, 32, 45],
    [21, 0, 1],
    [21, 1, 1]]   
   ));
console.log(magicMatricesVik([[1, 0, 0],
    [0, 0, 1],
    [0, 1, 0]]   
   ));
console.log(magicMatricesVik([[4, 5, 6],
    [6, 5, 4],
    [5, 5, 5]]
   ));

function magicMatricesVik(matrix) {
    let columns = [];
    for (let col = 0; col < matrix.length; col++) {
        columns.push(matrix.map((v, i, a) => v[col]));
    }
    matrix = matrix.concat(columns);
    let sum = matrix[0].reduce((a,b)=>a+b);
    return matrix.every((v,i,a)=> v.reduce((a,b)=> a+b) == sum);
}

