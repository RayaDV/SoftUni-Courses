function ticTacToe(moves) {

    const field = createField();

    let playerWon = false;

    let currentPlayer = 'X';


    for (let i = 0; i < moves.length; i++) {
        if (field.some((v) => v.some((v) => v === false))) {
            let move = moves[i];

            if (isPositionFree(field, move)) {

                currentPlayerPlay(field, move);

                if (playerWins(field, currentPlayer)) {
                    playerWon = true;
                    break;
                }

                currentPlayer = switchPlayers(currentPlayer);
            }
            else {
                console.log('This place is already taken. Please choose another!');
            }
        }
        else {
            break;
        }
    }
    if (playerWon) {
        console.log(`Player ${currentPlayer} wins!`);
    }
    else {
        console.log('The game ended! Nobody wins :(');
    }

    field.forEach(row => console.log(row.join('\t')));


    function createField() {
        const field = [];
        for (let row = 0; row < 3; row++) {
            field[row] = [];
            for (let col = 0; col < 3; col++) {
                field[row][col] = false;
            }
        }
        return field;
    }

    function isPositionFree(field, position) {
        let row = Number(position.split(' ')[0]);
        let col = Number(position.split(' ')[1]);

        return field[row][col] === false;
    }

    function currentPlayerPlay(field, move) {
        let row = move.split(' ')[0];
        let col = move.split(' ')[1];
        field[row][col] = currentPlayer;
    }

    function switchPlayers(currentPlayer) {
        currentPlayer == 'X' ? currentPlayer = 'O' : currentPlayer = 'X';
        return currentPlayer;
    }

    function playerWins(field, currentPlayer) {
        const fieldColumns = [];
        for (let col = 0; col < field.length; col++) {
            fieldColumns.push(field.map((v) => v[col]));
        }

        const fieldDiagonals = [];
        fieldDiagonals.push(field.map((v, i, a) => a[i][i]));
        const fieldSecDiagonal = [];
        let col = field.length - 1;
        for (let row = 0; row < field.length; row++) {
            fieldSecDiagonal.push(field[row][col]);
            col--;
        }
        fieldDiagonals.push(fieldSecDiagonal);

        const fieldElements = field.concat(fieldColumns, fieldDiagonals);

        return fieldElements.some((v) => v.every((v) => v === currentPlayer));
    }
}

ticTacToe2(["0 1",
"0 0",
"0 2", 
"2 0",
"1 0",
"1 1",
"1 2",
"2 2",
"2 1",
"0 0"]
);
console.log("---------");
ticTacToe2(["0 0",
"0 0",
"1 1",
"0 1",
"1 2",
"0 2",
"2 2",
"1 2",
"2 2",
"2 1"]
);
console.log("---------");
ticTacToe2(["0 1",
"0 0",
"0 2",
"2 0",
"1 0",
"1 2",
"1 1",
"2 1",
"2 2",
"0 0"]
);


function ticTacToe2(moves) {

    let field = [
        [false, false, false],
        [false, false, false],
        [false, false, false]
    ];
    let isFirstPlayer = true;
    for (let coordinates of moves) {
        let [row, col] = coordinates.split(" "); //destructured array; if there is more than 2 elements, they will be omitted
        // let row = coordinates.split(' ')[0]; //the same
        // let col = coordinates.split(' ')[1];
        if (field[row][col]) {
            console.log("This place is already taken. Please choose another!");
            continue;
        }
        let marker = isFirstPlayer ? "X" : "O";
        field[row][col] = marker;

        if (checkWin(field, marker)) {
            console.log(`Player ${marker} wins!`);
            printTable(field);
            return;
        }

        if (!checkFreeSpace(field)) {
            console.log("The game ended! Nobody wins :(");
            printTable(field);
            return;
        }

        isFirstPlayer = !isFirstPlayer;
    }

    function checkFreeSpace(field) {
        for (let row = 0; row < field.length; row++) {
            for (let col = 0; col < field[row].length; col++) {
                if (!field[row][col]) {
                    return true;
                }
            }
        }
        return false;
    }

    function printTable(field) {
        return field.forEach(row => console.log(row.join("\t")));
    }

    function checkWin(field, marker) {
        const fieldColumns = [];
        for (let col = 0; col < field.length; col++) {
            fieldColumns.push(field.map((v) => v[col]));
        }

        const fieldDiagonals = [];
        fieldDiagonals.push(field.map((v, i, a) => a[i][i]));
        const fieldSecDiagonal = [];
        let col = field.length - 1;
        for (let row = 0; row < field.length; row++) {
            fieldSecDiagonal.push(field[row][col]);
            col--;
        }
        fieldDiagonals.push(fieldSecDiagonal);

        const fieldElements = field.concat(fieldColumns, fieldDiagonals);

        return fieldElements.some((v) => v.every((v) => v === marker));
    }

}

