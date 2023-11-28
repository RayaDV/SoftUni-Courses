function calculateGCD(num1, num2) {
    let GCD = 1;
    let minNum = num1 < num2 ? num1 : num2;
    for(let i = 2; i <= minNum; i++) {
        if(num1 % i === 0 && num2 % i === 0) {
            GCD = i;
        }
    }
    console.log(GCD)
}

calculateGCD(15, 5);
calculateGCD(2154, 458);