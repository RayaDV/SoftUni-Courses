function spiralMatrix(rows, cols) {
 
    let matrix = Array(rows);
    for (let i = 0; i < rows; i++) {
        matrix[i] = Array(cols);
    }

    let arrLength = rows * cols;
    let arr = Array(arrLength);
    arr[0] = 1;
    for (let i = 1; i < arrLength; i++) {
        arr[i] = arr[i - 1] + 1;
    }
    
    for (let i = 0; i <= rows / 2; i++) {
        for (let col = i; col < cols - i; col++) {
            matrix[i][col] = arr.shift();
        }  //col = cols - 1
        for (let row = i + 1; row < rows - i; row++) {
            matrix[row][cols - 1 - i] = arr.shift();
        }  // row = rows - 1
        for (let col = cols - 2 - i; col >= i; col--) {
            matrix[rows - 1 - i][col] = arr.shift();
        }  //col = 0
        for (let row = rows - 2 - i; row >= 1 + i; row--) {
            matrix[row][i] = arr.shift();
        }
    }

    matrix.forEach(row => console.log(row.join(" ")));
    // console.table(matrix);
}

spiralMatrix(3, 3);
spiralMatrix(5, 5);