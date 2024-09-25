import './App.css'
import MovieList from './components/MovieList';
import movies from './assets/movies';
import Timer from './components/Timer';
import Counter from './components/Counter';
import Button from './components/Button';
import { useState } from "react";

function App() {
  const [clicks, setClicks] = useState(0);
  const clickHandler = (e) => {
      setClicks(c => c + 1)
  };

  return (
    <div>
      <h1>My first Dynamic React Application</h1>

      <Button 
        clickHandler={clickHandler}
        clicks={clicks}
      />

      <Counter />

      <Timer startTime={5} />
      <Timer startTime={10} />

      <MovieList movies={movies} headingText="Movie List" />
    </div>
  );
}

export default App
