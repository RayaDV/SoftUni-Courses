// // ****** FIRST ****** //
// function makeCounter() {
//     let counter = 0;

//     return function () {
//         console.log(++counter);
//     }
// }

// //Every function make own reference to the counter and remember it for itself:
// let firstCountFunc = makeCounter();  //counter1
// let secondCountFunc = makeCounter();  //counter2

// console.log("First");
// firstCountFunc();
// firstCountFunc();
// firstCountFunc();
// firstCountFunc();
// console.log("Second");
// secondCountFunc();
// secondCountFunc();


// ****** SECOND ****** //

let globalFirstVar = 100; // this variable lives in its scope, in this case globally
{
    let globalVar = 100; //this is valid only in this scope
}
{
    var globalSecondVar = 100; //this is legacy, valid globaly
}
//hoisting / raising

function outer() {   //function declaration //this function lives where it is defined, this means one level over it
    let outerVar = 200;

    console.log(globalFirstVar);

    inner();
    function inner() {   //inner() lives only in outer scope
        let innerVar = 5;
        console.log(innerVar);
        console.log(outerVar);
    }
}
outer(); //If we want to see globalFirstVar value, we must define and then invoke the function or first invoke then define, but if the function is define in another one scope, first invoked will doesn't work

// Summary:
// 1. Let lives in the curly brackets and cannot be accessed before ititialization
// 2. Function declaration can be executed in the current function scope
// 3. Function has access to the outer function scope but not the inner one
// 4. Arrow functions do not have their own 'this'. They use the 'this' from their outer function.
// 5. Context of 'this' - global, object, forced: call, apply, bind

function myFunc(a, b) {  // function declaration
    return a + b;
}

let myFunc = function (a, b) { // function expression
    return a + b;
}

let myFunc = (a, b) => a + b  // function expression with lambda


// ****** Example ****** //
function createFunc(myFunc) {
    return function (a, b, c) {
        return myFunc(a, b, c);
    }
}
let sum = craeteFunc((a, b, c) => a + b + c);
console.log(sum(1, 2, 3));


function solve() {
    return (a, b) => a + b;
}
let myFunc = solve(); // first we define function
let result = myFunc(1, 2); // then we give its value to the variable
console.log(result); // and print the result

function first() {
    return function second() {
        return function third() {
            return 100;
        }
    }
}
let resultValue = first()()(); // we use it like this OR:
let second = first();
let third = second();
let resultV = third();
console.log(resultV);


// ****** THIS ****** //
let cat = {
    name: 'Sharo', 
    mew() {
        console.log(this.name + ': Mew!');

        let mewNewFunc = () => {
            console.log(this.name + ': Mew Again!');
        }
        mewNewFunc(); // 'this' of the arrow functin take 'this' of the outer function
    },
    age: 10,
    grow(ageCount, message) {
        this.age += ageCount;
        console.log('Age increased: ' + message);
    }
};
cat.mew(); // Sharo: Mew! // it is in the context of object and 'this' refer to object
let mewFunc = cat.mew;
mewFunc(); // undefined: Mew! // it is outside the context of 'this'

let anotherCat = {
    name: 'Another cat',
    age: 20,
    mew: mewFunc //not always we will have the oppertunity to define the object
}
anotherCat.mew();

cat.grow(20, 'Top!');
console.log(cat.age);

// *** CALL, APPLY ***
let growFunc = cat.grow;
growFunc.call(anotherCat, 40, 'Call!'); // call grow function of the cat in the context of another object with first parameter = 40
console.log(anotherCat.age);
growFunc.apply(anotherCat, [40, 'Apply!']); //apply takes the parameters as array
console.log(anotherCat.age);

// *** BIND ***
let growFuncBind = cat.grow.bind(cat); //'this' always points the original cat
growFuncBind.call(anotherCat, 15, 'Top!');
console.log(anotherCat.age);
console.log(cat.age);

// First-Class Functions - Passed as an argument, Returned by another function, Assigned as a value to a variable
// Higher-Order Functions - Take other functions as an argument or return a function as a result
// Built-in Higher Order Functions - Array.prototype.map, Array.prototype.filter, Array.prototype.reduce
// Predicates - Any function that returns a bool based on evaluation of the truth of an assertion 
// Pure Functions - Returns the same result given same parameters 
// Referential Transparency - An expression that can be replaced with its corresponding value without changing the program's behavior. Expression is pure and its evaluation must have no side effects
// Closure - An inner function retains variables being used from the outer function scope even after the parent function has returned. A state is preserved in the outer function.
// Immediately-Invoked Function Expressions (IIFE) /LEGACY/ - anonymous function expression, invoked immediately after declaration

// (function () { let name = "Peter"; })();
// // Variable name is not accessible from the outside scope
// console.log(name); // ReferenceError

// let result = (function () {
//         let name = "Peter"; 
//         return name; 
//     })(); 
//     // Immediately creates the output: 
//     console.log(result); // Peter
    
// // Partial Application - Set some of the arguments of a function, without executing it
// Math.pow(x,y)
// sqr = (x) => Math.pow(x,2)

// Currying is a technique for function decomposition. Execution can be delayed until it's needed
function sum3(a) {
    return (b) => {
        return (c) => {
            return a + b + c;
        }
    }
}
console.log(sum3(5)(6)(8)); // 19 OR:

// function sum(x, y, z) {
//     return x + y + z;
// }
// let sum = (x, y, z) => x + y + z;
// let curriedSum = (x) => (y) => (z) => sum(x, y, z);
// console.log(curriedSum(1)(2)(3));

//Currying always produces nested unary functions.
//Partial application produces functions of arbitrary number of arguments.
//Currying is NOT partial application. It can be implemented using partial application.


