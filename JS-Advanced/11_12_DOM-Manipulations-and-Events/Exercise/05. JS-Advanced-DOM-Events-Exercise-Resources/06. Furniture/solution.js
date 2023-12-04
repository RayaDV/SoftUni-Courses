function solve() {
  let buttons = document.querySelectorAll('button');
  buttons[0].addEventListener('click', generate);
  buttons[1].addEventListener('click', buy);

  function generate() {
    let currItems = JSON.parse(document.querySelectorAll('textarea')[0].value);
    for (let item of currItems) {
      let tableRow = document.createElement('tr');
      let tableBody = document.querySelector('tbody');
      tableBody.appendChild(tableRow);
      tableRow.innerHTML = `<td>
                              <img src=${item.img}>
                            </td>
                            <td>
                              <p>${item.name}</p>
                            </td>
                            <td>
                              <p>${item.price}</p>
                            </td>
                            <td>
                              <p>${item.decFactor}</p>
                            </td>
                            <td>
                              <input type="checkbox">
                            </td>
                            `;

      // let imgTd = document.createElement('td');
      // let img = document.createElement('img');
      // img.setAttribute('src', item.img);
      // imgTd.appendChild(img);
      // tableRow.appendChild(imgTd);

      // let nameTd = document.createElement('td');
      // let name = document.createElement('p');
      // name.textContent = item.name;
      // nameTd.appendChild(name);
      // tableRow.appendChild(nameTd);

      // let priceTd = document.createElement('td');
      // let price = document.createElement('p');
      // price.textContent = item.price;
      // priceTd.appendChild(price);
      // tableRow.appendChild(priceTd);

      // let decFactorTd = document.createElement('td');
      // let decFactor = document.createElement('p');
      // decFactor.textContent = item.decFactor;
      // decFactorTd.appendChild(decFactor);
      // tableRow.appendChild(decFactorTd);

      // let markTd = document.createElement('td');
      // let mark = document.createElement('input');
      // mark.type = 'checkBox';
      // markTd.appendChild(mark);
      // tableRow.appendChild(markTd);
    }
  }

  function buy() {
    let tableRows = Array.from(document.querySelectorAll('tbody tr'));
    let selectedItems = [];
    let totalPrice = 0;
    let sumOfDecFactors = 0;
    for (let row of tableRows) {
      if (row.querySelector('input[type=checkbox]:checked')) {
        let rowData = row.querySelectorAll('td p');
        selectedItems.push(rowData[0].textContent.trim());
        totalPrice += Number(rowData[1].textContent);
        sumOfDecFactors += Number(rowData[2].textContent);
        debugger
      }
    }
    let avgDecFactor = sumOfDecFactors / selectedItems.length;
    
    let result = "";
    result += `Bought furniture: ${selectedItems.join(', ')}\n`;
    result += `Total price: ${totalPrice.toFixed(2)}\n`;
    result += `Average decoration factor: ${avgDecFactor.toFixed(2)}`;

    let resultTextArea = document.querySelectorAll('textarea')[1];
    resultTextArea.textContent = result;
  }

}