function wordsUppercaseWithRegEx(text) {
    return text.match(/\w+/g).join(", ").toUpperCase();
}
console.log(wordsUppercaseWithRegEx('Hi, how are you?'));
console.log(wordsUppercaseWithRegEx('hello'));

function wordsUppercase(text) {

    let result = [];
    let word = "";

    for(let i = 0; i < text.length; i++) {
        let charCode = text.charCodeAt(i);
        if((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122) || (charCode >= 48 && charCode <= 57)) {
            word += text[i].toUpperCase();
        } else {
            result.push(word);
            word = "";
        }
    }

    if(word) {
        result.push(word);
    }
    
    result = result.filter(x => x);

    console.log(result.join(', '));

}

console.log(wordsUppercase('Hi, how are you?'));
console.log(wordsUppercase('hello'));

