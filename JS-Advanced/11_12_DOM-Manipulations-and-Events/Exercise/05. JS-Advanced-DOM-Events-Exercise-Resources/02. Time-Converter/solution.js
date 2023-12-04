function attachEventsListeners() {

    let buttons = Array.from(document.querySelectorAll('input[type=button]'));

    for (let button of buttons) {
        button.addEventListener('click', convert);
    }

    function convert(event) {
        let currDiv = event.target.parentElement;
        let inputValue = Number(currDiv.querySelector('input[type=text]').value);
        let unit = currDiv.querySelector('input[type=text]').id;

        switch(unit) {
            case "days": 
                populate(inputValue);
                break;
            case "hours": 
                populate(inputValue / 24);
                break;
            case "minutes": 
                populate(inputValue / 24 / 60);
                break;
            case "seconds": 
                populate(inputValue / 24 / 60 / 60)
                break;
        }
    }
    function populate(valueInDays) {
        let inputs = Array.from(document.querySelectorAll('input[type=text]'));
        inputs.shift().value = valueInDays;
        let currValue = valueInDays * 24;
        for (let input of inputs) {
            input.value = currValue;
            currValue *= 60;
        }
    }
}