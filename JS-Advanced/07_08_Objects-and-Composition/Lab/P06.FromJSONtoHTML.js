function JsonToHtml(json) {
  let parsedArr = JSON.parse(json);
  let keys = Object.keys(parsedArr[0]);
  let valuesArr = parsedArr.map(obj => Object.values(obj));

  let outputArr = ["<table>"];
  outputArr.push(makeKeyRow(keys));
  valuesArr.forEach(values => outputArr.push(makeValueRow(values)));
  outputArr.push("</table>");

  function makeKeyRow(keys) {
      let result = `    <tr>`;
      for (let key of keys) {
          result += `<th>${escacpeHtml(key)}</th>`;
      }
      result += `</tr>`;
      return result;
  }

  function makeValueRow(values) {
      let result = `    <tr>`;
      for (let value of values) {
          result += `<td>${escacpeHtml(value)}</td>`;
      }
      result += `</tr>`;
      return result;
  }

  function escacpeHtml(value) {
      return value.toString()
                  .replace(/&/g, "&amp;")
                  .replace(/</g, "&lt;")
                  .replace(/>/g, "&gt;")
                  .replace(/"/g, "&quot;")
                  .replace(/'/g, "&#039;");
                  // .replace('<', '&lt;')
                  // .replace('>', '&gt;');
  }

  console.log(outputArr.join('\n'));
}

JsonToHtml(`[{"Name":"Stamat",
"Score":5.5},
{"Name":"Rumen",
"Score":6}]`
);
JsonToHtml(`[{"Name":"Pesho",
"Score":4,
" Grade":8},
{"Name":"Gosho",
"Score":5,
" Grade":8},
{"Name":"Angel",
"Score":5.50,
" Grade":10}]`
);