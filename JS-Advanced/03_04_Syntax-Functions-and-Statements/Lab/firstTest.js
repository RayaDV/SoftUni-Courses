let text = 'Hello from Raya!';
text = "Hello from Raya's code!";

text = 10;
text = true;
console.log(text);


let num = 10;
let anotherNum = 145.67;
console.log(num + anotherNum);

let number = Number.MAX_SAFE_INTEGER;
let bigNumber = 900540185235451226355620n;
let anotherBigNumber = 9005401852354512263556205624n;
console.log(bigNumber + anotherBigNumber); 

let cat = {
    name: 'Sharo',
    age: 7
};
console.log(cat.name);
cat.color = 'sharen';
console.log(cat.color);

let numbers = [1, 2 , 3, 'Sharo', {
    name: 'Sharo'
}, true];
console.log(numbers[0]);
console.log(numbers[3].name);
console.log(numbers[4].name);

function sayMyName(name, age){
    console.log(`My name is ${name} and I'm ${age} years old.`);
}
sayMyName('Raya', 34);

function echo(inputAsString) {
    console.log(inputAsString.length)
    console.log(inputAsString)
}

console.log(1 == '1');  // true
console.log(1 === '1'); // false
console.log(3 != '3');  // false
console.log(3 !== '3'); // true
console.log(5 < 5.5);   // true
console.log(5 <= 4);    // false
console.log(2 > 1.5);   // true
console.log(2 >= 2);    // true
console.log((5 > 7) ? 4 : 10); // 10

const val = 5; 
console.log(typeof val);    

console.log(typeof NaN);             //number
console.log(NaN === NaN);            //false
console.log(typeof null);            //object(legacy reasons)
console.log(new Array() == false);   //true
console.log(0.1 + 0.2);              //0.30000000000000004
console.log((0.2 * 10 + 0.1 * 10) / 10); //0.3

