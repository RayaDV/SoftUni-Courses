function changeText() {
    let header = document.getElementsByTagName('h1');
    let input = document.getElementById('my-data');
    let value = input.value;
    header[0].innerHTML = `<p>${value}!</p>`;
    header[0].style.color = 'red';
    // for (let element of header) {
    //     // element.innerText = 'My JavaScript text!';
    //     // console.log(element.innerText);
    //     let children = element.childNodes;
    //     for (let child of children) {
    //         child.innerHTML = `
    //         <ul>
    //             <li>1</li>
    //             <li>2</li>
    //             <li>3</li>
    //             </ul>`;
    //         }
    //     }
    //     let headerMain = document.getElementById('main-header');
    //     headerMain.innerHTML += '<p>Test!</p>'; // =header[0].innerHTML
    }
