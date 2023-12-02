function search() {
   let townsArray = Array.from(document.getElementsByTagName('ul')[0].children);
   // let townsArray = Array.from(document.querySelectorAll("ul li"));
   let searchedText = document.getElementById("searchText").value;
   let matches = 0;

   for (let item of townsArray) {
      let town = item.textContent;

      if (town.includes(searchedText)) {
         item.style.textDecoration = "underline";
         item.style.fontWeight = "bold";
         matches++;
      } else {
         item.style.textDecoration = "none";
         item.style.fontWeight = "normal";
      }
   }

   document.getElementById("result").innerText = `${matches} matches found`;
}
