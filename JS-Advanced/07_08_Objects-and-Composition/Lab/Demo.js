
    // let student = {
    //     name: 'Ivan',
    //     age: 18,
    //     marks: 6,
    //     city: 'Sofia'
    // };
    // let someOtherStudent = {
    //     address: 'Mladost 3',
    //     age: 20,
    //     country: 'Bulgaria'
    // };
    // let anotherStudent = Object.assign(someOtherStudent, student);

    // console.log(student);
    // console.log(anotherStudent);

    // let { age, city, ...rest} = anotherStudent;
    // console.log(age);
    // console.log(city);
    // console.log(rest);


// let phoneBook = {};
// phoneBook['Maria'] = '5';
// phoneBook['Bill'] = '4';
// phoneBook['Ivaylo'] = '20';
// phoneBook['Ana'] = '10';

// const sortedByKeys = {};
// const sortedByValues = {};
// let resultSortedByKey = Object.entries(phoneBook)  // [['Maria', '5'], ['Bill', '4'], ...]
//                    .sort((first, second) => {
//                         if (first[0] > second[0]) return 1;
//                         if (first[0] < second[0]) return -1;
//                         return 0;
//                    })
//                    .reduce((sorted, current) => {
//                         let key = current[0];
//                         let value = current[1];
//                         sorted[key] = value; // sortedByKeys[current[0]] = current[1]
//                         return sorted;
//                    }, {});

// // for (let pair of resultSortedByKey) {   //bebeshki nachin, osven s reduce and forEach
// //     let key = pair[0];
// //     let value = pair[1];
// //     sortedByKeys[key] = value;
// // }

// let resultSortedByValue = Object.entries(phoneBook)  // [['Maria', '5'], ['Bill', '4'], ...]
//                    .sort((first, second) => {
//                         if (Number(first[1]) > Number(second[1])) return 1;
//                         if (Number(first[1]) < Number(second[1])) return -1;
//                         return 0;
//                    })
//                    .forEach(pair => {
//                         sortedByValues[pair[0]] = pair[1];
//                    });

// console.log(resultSortedByKey);
// console.log(resultSortedByValue);
// console.log(sortedByKeys);
// console.log(sortedByValues);


// const compareNums = {
//     ascending: (a, b) => a - b,
//     descending: (a, b) => b - a
// };
// let numbers = [1, 20, 3, 40, 5]
// numbers.sort(compareNums.descending);
// console.log(numbers);

// function solve(commands) {
//     let count = 0;
//     const parser = {              //instead of 'switch' statement
//         increment() { count++; },
//         decrement() { count--; },
//         reset() { count = 0; }
//     }
//     for(let command of commands) {
//         parser[command]();
//     }
//     console.log(count);
// }
// solve(['increment', 'increment', 'decrement', 'reset']);


// let cat = {
//     name: 'Sharo',
//     age: 10,
//     owner: {
//         firstName: 'Ivaylo',
//         lastName: 'Kenov'
//     }
// };
// let catShallowCopy = {
//     name: cat.name,
//     age: cat.age,
//     owner: cat.owner
// }
// cat.owner.firstName = 'Ivan';
// console.log(catShallowCopy.owner.firstName);
// let catDeepCopy = {
//     name: cat.name,
//     age: cat.age,
//     owner: {
//         firstName: owner.firstName,
//         lastName: owner.lastName
//     }
// }

//function decorator
// function decorator(obj) {
//     obj.newFunc = function() {

//     };
// }

//function factory
// function factory(...parameters) {
//     let obj = {};
//     obj.firstParam = parameters[0];
//     obj.secondParam = parameters[1];
//     obj.someFunc = function() {

//     };
//     return obj;
// }


let myObj = {
    name,
    age,
    result: [1, 2, 3 , 4],
    cat: {
        name: 'Sharo',
        age: 7
    }
};
let myObjJson = JSON.stringify(myObj);
console.log(myObjJson);
let parsedObj = JSON.parse(myObjJson);
console.log(parsedObj.age);