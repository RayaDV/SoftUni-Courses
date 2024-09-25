export default function Button(props) {
    return (
        <button className="counter" onClick={props.clickHandler}>
            Click me! I'm a counter [{props.clicks}]
        </button>
    )
}