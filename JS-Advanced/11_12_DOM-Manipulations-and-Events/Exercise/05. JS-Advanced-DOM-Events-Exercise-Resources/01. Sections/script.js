function create(words) {
   const content = document.getElementById('content');

   for (let word of words) {
      let paragraph = document.createElement('p');
      let divElement = document.createElement('div');

      paragraph.textContent = word;
      paragraph.style.display = 'none';
      divElement.appendChild(paragraph);

      divElement.addEventListener('click', showText);
      content.appendChild(divElement);

      function showText(event) {
         if (event.target.nodeName === 'P') return;
         event.target.children[0].style.display = 'block';  //'inline', ''
      }
   }

}