function solve(input) {
    const myProcessor = processor();

    input.forEach(element => {
        let [command, value] = element.split(' ');
        myProcessor[command](value);
    })

    function processor() {
        const innerObject = [];
        return {
            add: (value) => innerObject.push(value),
            remove: (value) => {
                while (innerObject.includes(value)) {
                    innerObject.splice(innerObject.indexOf(value), 1);
                }
            },
            print: () => console.log(innerObject.join())
        }
    }
}

solve(['add hello', 'add again', 'remove hello', 'add again', 'print']);
solve(['add pesho', 'add george', 'add peter', 'remove peter','print']);