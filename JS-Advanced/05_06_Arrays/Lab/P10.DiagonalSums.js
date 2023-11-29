function diagonalSum(matrix) {
    let mainDiagonalSum = 0;
    let secondaryDiagonalSum = 0;
    let firstIndex = 0;
    let secondIndex = matrix[0].length -1;
    matrix.forEach(row => {
        mainDiagonalSum += row[firstIndex++];
        secondaryDiagonalSum += row[secondIndex--];
    });
    console.log(mainDiagonalSum, secondaryDiagonalSum);
}

diagonalSum([[20, 40],
            [10, 60]]);
            diagonalSum([[3, 5, 17],
            [-1, 7, 14],
            [1, -8, 89]]);    