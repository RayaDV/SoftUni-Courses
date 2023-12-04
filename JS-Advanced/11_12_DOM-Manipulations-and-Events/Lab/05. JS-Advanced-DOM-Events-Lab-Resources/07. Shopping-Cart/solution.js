function solve() {
   let shoppingCart = document.getElementsByClassName('shopping-cart')[0];
   let textOutput = document.getElementsByTagName('textarea')[0];
   let checkoutBtn = document.getElementsByClassName('checkout')[0];
   let totalMoney = 0;
   let list = [];
   let checkoutDone = false;

   shoppingCart.addEventListener('click', function(event) {

      if (event.target.nodeName !== 'BUTTON') return;
      
      if (checkoutDone) return;

      let currButton = event.target;
      if (currButton !== checkoutBtn) {
         let currProduct = currButton.parentElement.parentElement;
         let currProductTitle = currProduct.querySelectorAll('.product-title')[0].textContent;
         let currProductPrice = Number(currProduct.querySelectorAll('.product-line-price')[0].textContent);

         if (!list.includes(currProductTitle)) {  //if (list.indexOf(currProductTitle) < 0)
            list.push(currProductTitle);
         }
         totalMoney += currProductPrice;
         textOutput.textContent += `Added ${currProductTitle} for ${currProductPrice.toFixed(2)} to the cart.\n`

      } else {
         textOutput.textContent += `You bought ${list.join(', ')} for ${totalMoney.toFixed(2)}.`;
         totalMoney = 0;
         list = [];
         checkoutDone = true;
      }

   });

}