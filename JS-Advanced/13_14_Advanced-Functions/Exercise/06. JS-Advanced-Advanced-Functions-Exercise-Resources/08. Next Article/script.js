function getArticleGenerator(articles) {
    let myArticles = Array.from(articles);
    let content = document.getElementById('content');
    
    return () => {
        if (myArticles.length === 0) return;
        let currArticle = myArticles.shift();
        content.innerHTML += `<article>${currArticle}</article>`;
    }
}
