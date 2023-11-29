function diagonalAttack(input) {
    let matrix = input.map(row => row.split(" ").map(Number));

    let mainDiagonal = matrix.map((row, i, arr) => arr[i][i]);
    let mainSum = mainDiagonal.reduce((acc, el) => acc + el);

    let secondaryDiagonal = [];
    let secDiagonalIndexCol = matrix.length - 1;
    for (let row = 0; row < matrix.length; row++) {
        secondaryDiagonal.push(matrix[row][secDiagonalIndexCol]);
        secDiagonalIndexCol--;
    }
    let secondarySum = secondaryDiagonal.reduce((acc, el) => acc + el);

    if (secondarySum === mainSum) {
        let newMatrix = matrix.map((row, i, arr) => row.fill(mainSum));
        for (let row = 0; row < newMatrix.length; row++) {
            newMatrix[row][row] = mainDiagonal[row];
            newMatrix[row][matrix.length - 1 - row] = secondaryDiagonal[row];
        }
        printMatrix(newMatrix);
    } else {
        printMatrix(matrix);
    }

    function printMatrix(matrix) {
        matrix.forEach(row => console.log(row.join(" ")));
    }

}

diagonalAttack(['1 2 3',
'4 5 6',
'7 8 9']
);
diagonalAttack(['5 3 12 3 1',
'11 4 23 2 5',
'101 12 3 21 10',
'1 4 5 2 2',
'5 22 33 11 1']
);
diagonalAttack(['1 1 1',
'1 1 1',
'1 1 0']
);