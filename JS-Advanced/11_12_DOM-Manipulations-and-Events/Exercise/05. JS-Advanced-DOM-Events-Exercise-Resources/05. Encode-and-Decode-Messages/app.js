function encodeAndDecodeMessages() {
    let buttons = document.querySelectorAll('button');
    buttons[0].addEventListener('click', encode);
    buttons[1].addEventListener('click', decode);

    function encode() {
        let textAreas = document.querySelectorAll('textarea');
        let msgToEncode = textAreas[0].value;
        let decodedMsg = "";
        for (let i = 0; i < msgToEncode.length; i++) {
            let currChar = msgToEncode[i].charCodeAt();
            decodedMsg += String.fromCharCode(currChar + 1);
        }
        let resultTextArea = textAreas[1];
        resultTextArea.value = decodedMsg;
        textAreas[0].value = "";
    }

    function decode(event) {
        let currArea = event.target.parentElement.children[1];
        let currText = currArea.value;
        let resultMsg = "";
        for (let i = 0; i < currText.length; i++) {
            let currChar = currText[i].charCodeAt();
            resultMsg += String.fromCharCode(currChar - 1);
        }
        currArea.value = resultMsg;
    }
}