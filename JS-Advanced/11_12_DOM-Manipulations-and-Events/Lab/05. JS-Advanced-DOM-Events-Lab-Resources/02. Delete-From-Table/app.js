function deleteByEmail() {
    let inputEmail = document.getElementsByName('email')[0].value;
    const emails = document.querySelectorAll('table tbody tr td:nth-child(2)');
                                          //("#customers tr td:nth-child(2)")
    for (let email of emails) {
        if (email.textContent === inputEmail) {
            let row = email.parentNode;
            row.parentNode.removeChild(row);
            document.getElementById('result').textContent = "Deleted.";
            return;
        }
        document.getElementById('result').textContent = "Not found.";
    }
}