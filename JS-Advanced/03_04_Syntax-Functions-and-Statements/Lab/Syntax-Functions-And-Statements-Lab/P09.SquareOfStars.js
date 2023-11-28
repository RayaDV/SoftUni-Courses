function printSquareOfStars(n = 5) {
    const star = '* ';
    for (let i = 0; i < n; i++) {
        console.log(star.repeat(n).trim())
    }
}

printSquareOfStars(3);
printSquareOfStars();