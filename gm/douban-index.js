// ==UserScript==
// @name douban index
// @namespace http://www.douban.com/people/iseeiknow
// @version 0.1
// @description haha
// @copyright copyleft <3 hbc
// @match http://www.douban.com
// ==/UserScript==

(function() {
    var evil = 'http://www.douban.com/',
        // TODO add some weights =D
        choices = [
            'http://book.douban.com',
            'http://movie.douban.com',
            'http://9.douban.com',
            'http://digger.com/reader',
            'http://github.com',
            'http://coursera.org'
        ],
        current = document.URL.toString(),
        choice;

    if (current === evil) {
        choice = parseInt(Math.random() * 100 % choices.length, 10);
        document.location.href = choices[choice];
    }
})();
