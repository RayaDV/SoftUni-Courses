function area() {
    return Math.abs(this.x * this.y);
};
function vol() {
    return Math.abs(this.x * this.y * this.z);
};

function solve(area, vol, input) {  // functional programming
    return JSON.parse(input)
               .map(entry => {
                return {
                    area: area.call(entry),
                    volume: vol.call(entry)
                };
               });
}

function solve1(area, vol, input) {  // more detailed, what is behind map
    let objects = JSON.parse(input);
    function calc(obj) {
        let areaObj = Math.abs(area.call(obj));
        let volObj = Math.abs(vol.call(obj));
        return {
            area: areaObj,
            volume: volObj
        }
    }
    return objects.map(calc);
}


console.log(solve(area, vol, `[
    {"x":"1","y":"2","z":"10"},
    {"x":"7","y":"7","z":"10"},
    {"x":"5","y":"2","z":"10"}
    ]`
    ));
