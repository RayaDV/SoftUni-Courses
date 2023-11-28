function solve(a, b, operator) {
    let result;
    switch(operator) {
        case '+':
            result = a + b;
            break;
        case '-':
            result = a - b;
            break;   
        case '*':
            result = a * b;
            break;
        case '/':
            if(b !== 0)
            result = a / b;
            break;
        case '%':
            if(b !== 0)
            result = a % b;
            break;
        case '**':
            result = a ** b;
            break;
        default:                        
    }
    console.log(result);
}

solve(5, 6, '+');
solve(3, 5.5, '*');