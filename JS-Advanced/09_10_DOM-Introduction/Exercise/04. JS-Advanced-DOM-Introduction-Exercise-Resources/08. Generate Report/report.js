function generateReport() {
    const checkedHeaders = Array.from(document.querySelectorAll('table thead tr th'))
        .map((header, i) => { return {
            index: i,
            name: header.textContent.trim().toLowerCase(),
            selected: header.children[0].checked 
        } }) 
        .filter(header => header.selected);
    
    const dataRows = Array.from(document.querySelectorAll('table tbody tr'));
    let result = [];

    for (let row of dataRows) {
        const element = {};
        const children = row.children;
        for (let header of checkedHeaders) {
            element[header.name] = children[header.index].textContent;
        };
        result.push(element);
    };

    document.getElementById('output').textContent = JSON.stringify(result);

}