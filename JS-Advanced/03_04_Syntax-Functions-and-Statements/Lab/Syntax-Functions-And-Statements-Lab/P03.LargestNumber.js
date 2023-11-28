function largestNum(x, y, z){
    let result;
    if(x >= y && x >= z){
        result = x;
    }
    else if(y >= x && y >= z){
        result = y;
    }
    else{
        result = z;
    }
    console.log(`The largest number is ${result}.`);
}

function secondSolution(...params){
    console.log(`The largest number is ${Math.max(...params)}.`);
}

function thirdSolution(arg1, arg2, arg3) {
    let largestNum = arg1;
    if (largestNum < arg2){
        largestNum = arg2
    } 
    if (largestNum < arg3) {
        largestNum = arg3
    }
    console.log(`The largest number is ${largestNum}.`);
}

largestNum(5, -3, 16);
secondSolution(-3, -5, -22.5);
thirdSolution(0, -5, -22.5);