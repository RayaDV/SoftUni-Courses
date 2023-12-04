function attachGradientEvents() {
    let gradient = document.getElementById('gradient');
    gradient.addEventListener('mousemove', gradientMove);
    gradient.addEventListener('mouseout', gradientOut);

    function gradientMove(event) {
        let percentage = Math.trunc(event.offsetX * 100 / (event.target.clientWidth - 1));
        document.getElementById('result').textContent = percentage + "%";
    }

    function gradientOut(event) {
        document.getElementById('result').textContent = "";
    }
}