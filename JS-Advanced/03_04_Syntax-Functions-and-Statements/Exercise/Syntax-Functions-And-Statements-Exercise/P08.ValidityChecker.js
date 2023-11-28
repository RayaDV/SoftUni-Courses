function validityChecker(x1, y1, x2, y2) {

    validDistance(x1, y1, 0, 0);
    validDistance(x2, y2, 0, 0);
    validDistance(x1, y1, x2, y2);

    function validDistance(x1, y1, x2, y2) {
        let distance = Math.sqrt(Math.pow((x2 - x1), 2) + Math.pow((y2 - y1), 2));
        if(Number.isInteger(distance)){
            console.log(`{${x1}, ${y1}} to {${x2}, ${y2}} is valid`);
        } else {
            console.log(`{${x1}, ${y1}} to {${x2}, ${y2}} is invalid`);
        }
    }
}

validityChecker(3, 0, 0, 4);
validityChecker(2, 1, 1, 1);