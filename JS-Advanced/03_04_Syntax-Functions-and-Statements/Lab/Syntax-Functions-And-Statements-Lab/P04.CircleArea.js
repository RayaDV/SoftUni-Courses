function calculateArea(parameter) {
    let inputType = typeof(parameter);
    if(inputType === 'number'){
        let area = Math.PI * Math.pow(parameter, 2);
        console.log(area.toFixed(2));
    } else {
        console.log(`We can not calculate the circle area, because we receive a ${inputType}.`);
    }
}

calculateArea(5);
calculateArea('name');