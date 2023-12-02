function solve() {
   document.querySelector('#searchBtn').addEventListener('click', onClick);

   function onClick() {

      let searchField = document.getElementById('searchField').value;

      const rows = Array.from(document.querySelector('table tbody').children);

      rows.map((v) => v.className = '');

      if (searchField !== '') {
         for (let row of rows) {
            if (Array.from(row.children)
                     .map((v) => v.textContent)
                     .some((v) => v.includes(searchField))) {
               row.className = 'select';
            }
         }
      }
   }
}