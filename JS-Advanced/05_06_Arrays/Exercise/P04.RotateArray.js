function rotateArr(array, rotations) {
    for (let i = 0; i < rotations; i++) {
        
        array.unshift(array.pop());
    }
    console.log(array.join(' '));
}

rotateArr(['1', 
'2', 
'3', 
'4'], 
2
);
rotateArr(['Banana', 
'Orange', 
'Coconut', 
'Apple'], 
15
);