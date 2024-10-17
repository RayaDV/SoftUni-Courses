function solve(...params) {
    let types = [];
    params.forEach(entry => {
        let argumentType = typeof(entry);
        let argumentValue = entry;
        console.log(`${argumentType}: ${argumentValue}`);

        //types[argumentType] === undefined ? types[argumentType] = 1 : types[argumentType]++;
        if (!types.hasOwnProperty(argumentType)) {
            types[argumentType] = 0;
        }
        types[argumentType]++;
    });

    let sortedEntries = Object.entries(types).sort((a, b) => b[1] - a[1]);
    sortedEntries.forEach(([key, value]) => console.log(`${key} = ${value}`));
}

solve('cat', 42, function () { console.log('Hello world!'); });