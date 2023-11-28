function cookingByNumbers(startingPoints, ...operations) {
    points = Number(startingPoints);

    for(let i = 0; i < operations.length; i++) {
        points = manipulator(points, operations[i]);
    }
    
    function manipulator(num, operation) {
        switch(operation) {
            case 'chop': num /= 2; break; 
            case 'dice': num = Math.sqrt(num); break; 
            case 'spice': num += 1; break; 
            case 'bake': num *= 3; break; 
            case 'fillet': num *= 0.80; break; 
        }
        console.log(num);
        return num;
    }
}

cookingByNumbers('32', 'chop', 'chop', 'chop', 'chop', 'chop');
console.log('---------');
cookingByNumbers('9', 'dice', 'spice', 'chop', 'bake', 'fillet');