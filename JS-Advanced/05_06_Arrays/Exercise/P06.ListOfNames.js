function listOfNames(list) {
    list.sort((a, b) => a.localeCompare(b));
    for (let i = 0; i < list.length; i++) {
        let num = i + 1;
        console.log(num + '.' + list[i]);
        // console.log(`${i + 1}.${list[i]}`);
    }
}

function listOfNamesForEach(list) {
    list.sort((a, b) => a.localeCompare(b))
        .forEach((x, i) => console.log(`${i + 1}.${x}`));
}

listOfNames(["John", "Bob", "Christina", "Ema"]);
listOfNamesForEach(["John", "Bob", "Christina", "Ema"]);