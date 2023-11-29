function printNthEl(array, n) {
    let result = [];
    for (let i = 0; i < array.length; i += n) {
        result.push(array[i]);
    }
    return result;
}

function printNthElFunc(array, n) {
    return array.filter((el, i) => {
        if(i % n === 0) {
            return el;
        }
    });
}

console.log(printNthElFunc(['5', 
'20', 
'31', 
'4', 
'20'], 
2
));
console.log(printNthElFunc(['dsa',
'asd', 
'test', 
'tset'], 
2
));
console.log(printNthElFunc(['1', 
'2',
'3', 
'4', 
'5'], 
6
));