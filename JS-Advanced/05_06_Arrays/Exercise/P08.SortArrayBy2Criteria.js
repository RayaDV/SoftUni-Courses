function sortArray2Criteria(arr) {
    arr.sort((a, b) => {
        if(a.length !== b.length) {
            return a.length - b.length;
        } else {
            return a.localeCompare(b);
        }
    });
    console.log(arr.join("\n"));
}

function sortArray2(arr) {
    console.log(arr.sort((a, b) => 
        a.length !== b.length ?
        a.length - b.length : a.localeCompare(b)
    ).join("\n"));
}

function sortArray(arr) {
    console.log(arr.sort((a, b) => 
        a.length - b.length || a.localeCompare(b)
    ).join("\n"));
}



sortArray(['alpha', 
'beta', 
'gamma']
);

// sortArray2Criteria(['alpha', 
// 'beta', 
// 'gamma']
// );
// sortArray2Criteria(['Isacc', 
// 'Theodor', 
// 'Jack', 
// 'Harrison', 
// 'George']
// )