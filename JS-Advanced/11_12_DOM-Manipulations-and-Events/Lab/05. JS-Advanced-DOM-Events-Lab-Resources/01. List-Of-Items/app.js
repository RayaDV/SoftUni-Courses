function addItem() {
    let text = document.getElementById('newItemText').value;
    let anotherLi = document.createElement('li');
    // anotherLi.append(text); 
    anotherLi.appendChild(document.createTextNode(text)); 
    document.getElementById('items').appendChild(anotherLi);

    document.getElementById('newItemText').value = ''; // clearing the input
}