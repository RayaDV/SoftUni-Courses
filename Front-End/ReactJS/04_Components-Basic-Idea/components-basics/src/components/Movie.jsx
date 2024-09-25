export default function Movie(props){
    return (
        <li>
            <h3>{props.movieData.title}</h3>
            <p>Year: {props.movieData.year}</p>
            <p>Description: {props.movieData.description}</p>
        </li>
    );
}