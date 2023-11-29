function addOrRemoveEl(commands) {
    let num = 1;
    const result = [];
    for (let i = 0; i < commands.length; i++) {
        if (commands[i] === 'add') {
            result.push(num);
        } else if (commands[i] == 'remove') {
            result.pop(num);
        }
        num++;
    }
    console.log(result.length != 0 ? result.join('\n') : "Empty");
}

function addOrRemoveElFunc(commands) {
    let num = 1;
    const result = [];
    commands.forEach(command =>  {
        command === 'add' ?  result.push(num) : result.pop(num);
        num++;
    })
    return result.length != 0 ? result.join('\n') : "Empty";
}

addOrRemoveElFunc(['add', 
'add', 
'add', 
'add']
);
console.log(addOrRemoveElFunc(['add', 
'add', 
'remove', 
'add', 
'add']
));
addOrRemoveElFunc(['remove', 
'remove', 
'remove']
);