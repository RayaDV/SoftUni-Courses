function editElement(ref, match, replacer) {
    let text = ref.textContent;
    // text = text.replaceAll(match, replacer);
    const matcher = new RegExp(match, 'g');
    const edited = text.replace(matcher, replacer);
    ref.textContent = edited;
}