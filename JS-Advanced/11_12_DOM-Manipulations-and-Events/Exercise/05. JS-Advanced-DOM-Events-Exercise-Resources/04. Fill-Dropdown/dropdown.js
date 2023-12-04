function addItem() {
    let newItemText = document.getElementById('newItemText').value;
    let newItemValue = document.getElementById('newItemValue').value;

    let op = document.createElement('option');
    op.textContent = newItemText;
    op.value = newItemValue;

    let selectItem = document.getElementById('menu');
    selectItem.appendChild(op);

    document.getElementById('newItemText').value = '';
    document.getElementById('newItemValue').value = '';
}