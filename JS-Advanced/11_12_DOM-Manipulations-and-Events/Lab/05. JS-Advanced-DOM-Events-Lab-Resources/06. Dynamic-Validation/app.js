function validate() {
    const input = document.getElementById('email');
    input.addEventListener('change', validate);

    function validate() {
        const inputValue = this.value;
        let valid = validateEmail(inputValue);

        if(valid) {
            this.className = '';
        } else {
            this.className += 'error';
        }

        function validateEmail(email) {
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());
        }
    }
}