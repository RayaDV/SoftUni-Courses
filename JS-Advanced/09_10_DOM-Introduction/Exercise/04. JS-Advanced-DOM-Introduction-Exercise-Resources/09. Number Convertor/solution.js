function solve() {

    document.querySelector('button').addEventListener('click', convert);
           //querySelector("#container button").

    function convert() {
        const selector = document.getElementById('selectMenuTo');
        selector.innerHTML = '';
    
        const bin = document.createElement('option');
        bin.value = 'binary';
        bin.innerHTML = 'Binary';
        selector.appendChild(bin);
    
        const hex = document.createElement('option');
        hex.value = 'hexadecimal';
        hex.innerHTML = 'Hexadecimal';
        selector.appendChild(hex);
    
        const input = Number(document.getElementById('input').value);
        const convertType = document.getElementById('selectMenuTo').value;
    
        let result = convertType === 'binary' ? 
                    input.toString(2) : input.toString(16).toUpperCase();
        document.getElementById('result').value = result;
    }
    
}