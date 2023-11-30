function createSortedList() {
    let list = {
        collection: [],
        size: 0,
        add(element) { 
            this.collection.push(element);
            sortCollection(this.collection);
            this.size++;
        },
        remove(index) {
            if (isIndexValid(index, this.collection)) {
                this.collection.splice(index, 1);
                sortCollection(this.collection);
                this.size--;
            }
        },
        get(index) {
            if (isIndexValid(index, this.collection)) {
                return this.collection[index];
            }
        }
    }

    function isIndexValid(index, array) {
        return index >= 0 && index < array.length;
    }
    function sortCollection(array) {
        return array.sort((a, b) => a - b);
    }

    return list;
}

let list = createSortedList();
list.add(5);
list.add(6);
list.add(7);
console.log(list.get(1)); 
list.remove(1);
console.log(list.get(1));
console.log(list.size);
