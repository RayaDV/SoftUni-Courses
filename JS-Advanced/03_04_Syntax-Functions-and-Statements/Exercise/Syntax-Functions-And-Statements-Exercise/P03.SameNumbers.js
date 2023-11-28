function sameNumbers(number) {
    let areSame = true;
    let numberAsString = String(number);
    for(let i = 1; i < numberAsString.length; i++) {
        if(numberAsString[i - 1] !== numberAsString[i]) {
            areSame = false;
            break;
        }
    }

    let sum = 0;
    for(let i = 0; i < numberAsString.length; i++) {
        let currDigit = Number(numberAsString[i])
        sum += currDigit;
    }
    
    console.log(areSame);
    console.log(sum);
}

sameNumbers(2222222);
sameNumbers(1234);