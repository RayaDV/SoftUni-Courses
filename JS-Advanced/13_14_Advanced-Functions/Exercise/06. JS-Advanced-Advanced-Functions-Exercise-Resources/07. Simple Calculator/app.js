function calculator() {
    let firstSelector;
    let secondSelector;
    let resSelector;

    return{
        init: (selector1, selector2, resultSelector) => {
            firstSelector = document.querySelector(selector1);
            secondSelector = document.querySelector(selector2);
            resSelector = document.querySelector(resultSelector);
        },
        add: () => {
            let firstNum = Number(firstSelector.value);
            let secondNum = Number(secondSelector.value);
            let sum = firstNum + secondNum;
            resSelector.value = sum;
        },
        subtract: () => {
            let firstNum = Number(firstSelector.value);
            let secondNum = Number(secondSelector.value);
            let subtract = firstNum - secondNum;
            resSelector.value = subtract;
        }
    }
}

const calculate = calculator (); 
calculate.init ('#num1', '#num2', '#result'); 





