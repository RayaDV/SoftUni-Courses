function townsToJSON(input) {
    let output = [];

    let keys = input.shift().split(' | ');
    let firstColumn = keys[0].substring(2);
    let secondColumn = keys[1];
    let thirdColumn = keys[2].substring(0, keys[2].length - 2);
    for (let element of input) {
        let [town, latitude, longitude] = element.split(' | ');
        town = town.substring(2);
        latitude = parseFloat(Number(latitude).toFixed(2));
        longitude = parseFloat(Number(longitude.substring(0, longitude.length - 2)).toFixed(2));
        let curTown = {
            [firstColumn]: town,
            [secondColumn]: latitude,
            [thirdColumn]: longitude
        }
        output.push(curTown);
    }

    console.log(JSON.stringify(output));
}

townsToJSON([
    '| Town | Latitude | Longitude |',
    '| Sofia | 42.696552 | 23.32601 |',
    '| Beijing | 39.913818 | 116.363625 |'
]);