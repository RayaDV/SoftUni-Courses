function previousDay(year, month, day) {
    let prevDate = new Date(year, month - 1, day - 1);
    console.log(`${prevDate.getFullYear()}-${prevDate.getMonth() + 1}-${prevDate.getDate()}`);
}

previousDay(2016, 9, 30);
previousDay(2016, 10, 1);


function prevDay(year, month, day) {
    let pattern = `${year}/${month}/${day}`;
    let myDate = new Date(pattern);
    myDate.setDate(myDate.getDate() - 1);
    
    console.log(`${myDate.getFullYear()}-${myDate.getMonth() + 1}-${myDate.getDate()}`);
}

prevDay(2016, 9, 30);
prevDay(2016, 10, 1);