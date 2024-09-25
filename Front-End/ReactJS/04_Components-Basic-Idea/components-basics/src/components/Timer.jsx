import { useState } from 'react';

export default function Timer(props) {
    const hookResult = useState();  // the result is array with two elements
    // const stateValue = hookResult[0]; // state value
    // const setState = hookResult[1];  // function for changing the state
    // const [state, setState] = useState(); // we do it like this
    const [time, setTime] = useState(props.startTime); // Pass initial state (0)

    // let time = 0;
    console.log(`Current time is = ${time}`);

    // Note: Do not use setTimeout, useEffect is more appropriate
    setTimeout(() => {    
        setTime(time + 1);  
    }, 1000);    // load in the ivent queue the new value after 1s
    // setTime change the state, but also say to React: "apply the Timer component again, there is a change in its state"

    return (
        <div>
            <h3>Timer</h3>
            <p>{time}</p>
        </div>
    );
}