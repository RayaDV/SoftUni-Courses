function rectangle(width, height, color) {
    let rect = {
        width, 
        height, 
        color: color[0].toUpperCase() + color.substring(1), 
        calcArea: function() {   
            return width * height;
        }
    };

    return rect;
}

function rectangle1(width, height, color) {
    return {
        width, 
        height, 
        color: color.charAt(0).toUpperCase() + color.slice(1),
        calcArea() {
            return width * height;
        }
    };
}

let rect = rectangle1(4, 5, 'red');
console.log(rect.width);
console.log(rect.height);
console.log(rect.color);
console.log(rect.calcArea());
