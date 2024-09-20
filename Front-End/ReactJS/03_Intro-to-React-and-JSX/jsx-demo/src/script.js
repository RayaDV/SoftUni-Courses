import '../node_modules/react/umd/react.production.min.js';
import '../node_modules/react-dom/umd/react-dom.production.min.js';

const rootDomElement = document.getElementById('root');

const root = ReactDOM.createRoot(rootDomElement);

// const reactHeading = React.createElement('h1', {}, 'Hello from JSX!');
// const reactSecondHeading = React.createElement('h2', {}, 'The best syntax ever!');
// const header = React.createElement('header', {className: 'site-header'}, reactHeading, reactSecondHeading);

// root.render(header);

const headerJSX = (
    <header className='site-header'>
        <h1>Hello from JSX!</h1>
        <h2>The best syntax ever!</h2>
    </header>
);

root.render(headerJSX);