function acceptCookies() {
    document.querySelector('.cookie-banner').style.display = 'none';
    // Set a cookie to remember the user's choice
    document.cookie = "cookiesAccepted=true; path=/; max-age=" + 60*60*24*30;
}

function necessaryCookies() {
    document.querySelector('.cookie-banner').style.display = 'none';
    // Set a cookie to remember the user's choice for necessary cookies only
    document.cookie = "necessaryCookies=true; path=/; max-age=" + 60*60*24*30;
}

function declineCookies() {
    document.querySelector('.cookie-banner').style.display = 'none';
}

// Check if the user has already accepted cookies
if (document.cookie.indexOf('cookiesAccepted=true') === -1 && document.cookie.indexOf('necessaryCookies=true') === -1) {
    document.querySelector('.cookie-banner').style.display = 'flex';
}