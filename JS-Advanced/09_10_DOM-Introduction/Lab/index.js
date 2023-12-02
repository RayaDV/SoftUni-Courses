function sum() {
    let firstNumber = document.getElementById('first').value; //inputs always come as strings, even though we define them with type="number", so we need to parse them
    let secondNumber = document.getElementById('second').value;
    let result = Number(firstNumber) + Number(secondNumber);

    document.getElementById('result').textContent = `Result: ${result}`;
}

let elements = document.getElementsByClassName('important-info');
for (let element of elements) {
    if (element.tagName === 'H1') {
        console.log(element)
        element.style.color = 'black';
    }
}