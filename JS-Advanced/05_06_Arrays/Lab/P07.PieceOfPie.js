function findPies(pies, firstPie, lastPie = 'Lemon Meringue Pie') {
    const start = pies.indexOf(firstPie);
    const end = pies.indexOf(lastPie) + 1;
    const result = pies.slice(start, end);
    return result;
}

console.log(findPies(['Pumpkin Pie',
'Key Lime Pie',
'Cherry Pie',
'Lemon Meringue Pie',
'Sugar Cream Pie'],
'Key Lime Pie'
));

// console.log(findPies(['Apple Crisp',
// 'Mississippi Mud Pie',
// 'Pot Pie',
// 'Steak and Cheese Pie',
// 'Butter Chicken Pie',
// 'Smoked Fish Pie'],
// 'Pot Pie',
// 'Smoked Fish Pie'
// ));

