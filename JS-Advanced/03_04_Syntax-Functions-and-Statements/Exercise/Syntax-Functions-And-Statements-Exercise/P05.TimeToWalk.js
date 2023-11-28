function timeToWalk(steps, footprint, speed) {
    let speedMs = speed * 1000 / 3600;
    let distance = steps * footprint;
    let delay = Math.floor(distance / 500) * 60;
    let time = Math.round(distance / speedMs + delay);

    let seconds = time % 60;
    let timeInMin = (time - seconds) / 60;
    let minutes = timeInMin % 60;
    let hours = (timeInMin - minutes) / 60;
    
    console.log(`${hours.toString().padStart(2, "0")}:${minutes.toString().padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`)
}

timeToWalk(4000, 0.60, 5);
timeToWalk(1000, 0.60, 2);
timeToWalk(2564, 0.70, 5.5);
