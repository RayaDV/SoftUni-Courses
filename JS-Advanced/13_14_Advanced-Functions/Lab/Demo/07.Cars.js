function solve(input) {
    const myFunctionality = selectFunctionality();

    input.forEach(element => {
        let [command, ...params] = element.split(' ');
        myFunctionality[command](...params);
    });

    function selectFunctionality() {
        const objects = [];
        return {
            create: (name, additionalCommand, parentName) => {
                objects.push({ name: name});
                let currObj = objects.find(obj => obj.name == name);
                if (additionalCommand === 'inherit') {
                    let parentObj = objects.find(obj => obj.name == parentName);
                    let sourceObj = Object.assign({}, parentObj);
                    sourceObj.name = name;
                    currObj = Object.assign(currObj, sourceObj);
                    console.log(currObj);
                }
            },
            set: (name, key, value) => {
                let currObj = objects.find(obj => obj.name == name);
                currObj[key] = value;
            },
            print: (name) => {
                let currObj = objects.find(obj => obj.name == name);
                let currObjProps = Object.entries(currObj).splice(1);
                let result = [];
                currObjProps.map(([key, value]) => {
                    result.push(`${key}:${value}`)}
                    );
                console.log(result.join(','));
            }
        }
    }
}

solve(['create c1',
'create c2 inherit c1',
'set c1 color red',
'set c2 model new',
'print c1',
'print c2']
);