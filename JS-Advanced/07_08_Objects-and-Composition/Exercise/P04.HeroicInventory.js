function heroInventory(inputArr) {
    let result = [];

    for (const element of inputArr) {
        let [name, level, items] = element.split(' / '); //destructuring assignment syntax
        level = Number(level);
        items = items ? items.split(", ") : [];

        result.push({name, level, items})
    }
    console.log(JSON.stringify(result));
}

heroInventory(['Isacc / 25 / Apple, GravityGun',
'Derek / 12 / BarrelVest, DestructionSword',
'Hes / 1 / Desolator, Sentinel, Antara']
);