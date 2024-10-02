import React, { useState, useEffect } from 'react';
import styles from './App.module.css';
import Starwars from './Starwars';

function App() {
    const [numbers, setNumbers] = useState([1, 2, 3, 4, 5, 1]);
    const [count, setCount] = useState(0);
    const [isManualUpdate, setIsManualUpdate] = useState(false);

    useEffect(() => {
        // console.log('Mount component');
    }, []);

    useEffect(() => {
        // console.log(`Update component - ${numbers.length}`);
    }, [numbers]);

    useEffect(() => {
        // if (!isManualUpdate) {
        //     setTimeout(() => setCount(s => s + 1), 1000);
        // } else {
        //     setIsManualUpdate(false);
        // }
    }, [count]);

    const onRemoveClick = () => {
        setNumbers(oldState => oldState.slice(1, oldState.length - 1));  // with slice we make a new referance 
    }

    const onClick = () => {
        setCount(c => c + 1);
        setIsManualUpdate(true);
    }

    if (!numbers.length) {
        return null;
    }

    return (
        <div className={styles.app}>
            <Starwars />

            <h3>Count: {count}</h3>
            <ul>
                {numbers.map((number, index) => (
                    <li data-key={index} key={index} className={styles.listItem}>
                        {number * 2}
                    </li>)
                )}
            </ul>

            <button style={{marginRight: '10px'}} onClick={onRemoveClick}>Remove</button>
            <button onClick={onClick}>+</button>
        </div>
    );
}

export default App
