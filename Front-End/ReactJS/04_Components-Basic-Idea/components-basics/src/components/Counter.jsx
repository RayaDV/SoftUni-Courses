import { useState } from "react";

export default function Counter(props) {
    const [count, setCount] = useState(0);

    const incrementClickHandler = () => {  // onIncrementClick or incrementClickHandler
        setCount(oldValue => oldValue + 1);  // it is better than setCount(count + 1); 
    }

    const clearClickHandler = () => {  
        setCount(0);  // there is no dynamic change that's why may be (count = 0) directly
    }

    // 1. Conditional Rendering with multiple returns
    // if (count < 0){
    //     return (
    //         <h3>Invalid count!</h3>
    //     );
    // }

    let message = null;
    switch (count) {
        case 1:
            message = 'First blood';
            break;
        case 2:
            message = 'Double kill';
            break;
        case 3:
            message = 'Tripple kill';
            break;
        default:
            message = 'Monster kill';
            break;
    }

    return (
        <div>
            <h3>Counter</h3>

            {/* // 2. Conditional Rendering with ternary operator */}
            {count < 0      
                ? <p>Invalid count!</p>
                : <p>Valid count!</p>
            }

            {/* // 3.1. Conditional Rendering with ternary operator - && - only when the first is true, show the second */}
            {/* // 3.2. Conditional Rendering with ternary operator - || - only when the first is false, show the second */}
            {count == 0 && <p>Please start incrementing!</p>}  

            {/* // 4. Conditional Rendering with if/switch operators */}
            <h4>{message}</h4>

            <p>Count: {count}</p>

            <button disabled={count < 0} onClick={() => setCount(count - 1)}>-</button>
            <button onClick={clearClickHandler}>clear</button>
            <button onClick={incrementClickHandler}>+</button>   {/* this is better way */}
        </div>
    );
}