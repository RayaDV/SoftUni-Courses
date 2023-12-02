function solve() {
   document.querySelector('#btnSend').addEventListener('click', onClick);

   function onClick () {
      let restaurantsData = document.querySelector("#inputs textarea").value;

      if (restaurantsData !== '') {
         const input = JSON.parse(restaurantsData);
         const restaurants = [];

         for (let data of input) {
            let [name, workersList] = data.split(" - ");
            const workers = workersList.split(", ")
                                   .map(worker => { return {
                                          name: worker.split(' ')[0],
                                          salary: worker.split(' ')[1]
                                          }
                                       })
                                   .sort((a, b) => b.salary - a.salary);
                                   
            const avgSalary = calculateAvgSalary(workers);
            const bestSalary = calculateBestSalary(workers);
                                   
            if (restaurants.some(r => r.name === name)) {
               const currRestaurant = restaurants.filter(r => r.name === name)[0];
               workers.forEach(worker => currRestaurant.workers.push(worker));

               currRestaurant.avgSalary = calculateAvgSalary(currRestaurant.workers);
               currRestaurant.bestSalary = calculateBestSalary(currRestaurant.workers);
               currRestaurant.workers.sort((a, b) => b.salary - a.salary);
            } else {
               restaurants.push({
                  name: name,
                  workers: workers,
                  avgSalary: avgSalary,
                  bestSalary: bestSalary
               });
            }                
         }

         const bestRestaurant = restaurants.sort((a, b) => b.avgSalary - a.avgSalary)[0];
         let bestRestaurantOutput = `Name: ${bestRestaurant.name} Average Salary: ${bestRestaurant.avgSalary.toFixed(2)} Best Salary: ${bestRestaurant.bestSalary.toFixed(2)}`;
         let bestRestWorkersOutput = '';
         bestRestaurant.workers.forEach(worker => {
            bestRestWorkersOutput += `Name: ${worker.name} With Salary: ${worker.salary} `;
         });

         document.querySelector('#bestRestaurant p').textContent = bestRestaurantOutput;
         document.querySelector('#workers p').textContent = bestRestWorkersOutput.trim();

      } else {
         document.querySelector('#bestRestaurant p').textContent = '';
         document.querySelector('#workers p').textContent = '';
      }


      function calculateAvgSalary(workers) {
         return workers.map(worker => Number(worker.salary))
                       .reduce((a, b) => a + b) / workers.length;
      }

      function calculateBestSalary(workers) {
         return workers.map(worker => Number(worker.salary))
                       .sort((a, b) => b - a)[0];
      }
      
   }
}