function solve() {

  let text = document.getElementById("input").value;
  let sentences = text.split('.').filter(s => s.length > 0);

  const output = document.getElementById("output");
  output.innerHTML = '';
  
  for (let i = 0; i < sentences.length; i += 3) {
    let paragraphContent = '';
    for (let j = 0; j < 3; j ++) {
      if(sentences[i + j]) {
        paragraphContent += sentences[i + j] + ".".trim();
      }
    }
    output.innerHTML += `<p>${paragraphContent}</p>`;
  }

}