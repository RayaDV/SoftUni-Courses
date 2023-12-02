function solve() {
  let text = document.getElementById('text').value;
  let convention = document.getElementById('naming-convention').value;
  let words = text.split(' ');
  let result = "";
  for (let word of words) {
    result += word[0].toUpperCase() + word.substring(1).toLowerCase();
  }
  switch (convention) {
    case "Camel Case": result = result[0].toLowerCase() + result.substring(1);
      break;
    case "Pascal Case": result = result;
      break;
    default: result = "Error!";
      break;
  }
  document.getElementById("result").textContent = result;
}