function lockedProfile() {
    let buttons = document.getElementsByTagName('button');
    for (let button of buttons) {
        button.addEventListener('click', listener);
    }

    function listener(event) {
        let currProfile = event.target.parentElement;
        let command = event.target.textContent;
        const currProfileChildren = Array.from(currProfile.children);
        let hiddenDiv = currProfile.getElementsByTagName('div')[0];

        const isLocked = currProfileChildren
                        .find(child => child.value === 'lock').checked;

        if (!isLocked) {
            if (command === 'Show more') {
                hiddenDiv.style.display = 'block';
                event.target.textContent = 'Hide it';
            } else {
                hiddenDiv.style.display = 'none';
                event.target.textContent = 'Show more';
            }
        }

    }
}