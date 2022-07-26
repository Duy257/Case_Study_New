const http = require('http');
const fs = require('fs');
const url = require('url')
const qs = require('qs');
const UserController = require('./controller/user-controller');
const HomeController = require('./controller/home-controller');
// const LoginController = require('./controller/login-controller.js')


const mimeTypes = {
    "html": "text/html",
    "js": "text/javascript",
    "min.js": "text/javascript",
    "css": "text/css",
    "css.map": "text/css",
    "min.css": "text/css",
    "jpg": "image/jpg",
    "png": "image/png",
    "gif": "image/gif",
    "woff": "text/html",
    "ttf": "text/html",
    "woff2": "text/html",
    "eot": "text/html",
};

// let loginController = new LoginController();
let userController = new UserController();
let homeController = new HomeController();

let server = http.createServer((req, res) => {
    let urlParse = url.parse(req.url);
    let urlPart = urlParse.pathname;
    let method = req.method;

    let filesDefences = req.url.match(/\.js|.css|.css.map|.jpg|.png|.gif|min.js|min.css|.woff|.ttf|.woff2|.eot/);
    if (filesDefences) {
        let filePath = filesDefences[0].toString();
        let extension = mimeTypes[filesDefences[0].toString().split('.')[1]];
        // console.log(extension);
        if (filePath.includes('/')){
            extension = mimeTypes[filesDefences[0].toString().split('/')[1]];
        }
        if (extension.includes('?')){
            extension = extension.split('?')[0];

        }
        res.writeHead(200, { 'Content-Type': extension });
        fs.createReadStream(__dirname + '/template' + '/' + req.url).pipe(res);
        
    }else{

    switch (urlPart) {
        case '/' :
            if(method == 'GET'){
                homeController.showHomePage(req, res);
            }
            break;
        case '/login' :
            if(method == 'GET'){
                userController.showLoginForm(req, res);
            }else {
                userController.login(req, res);
            }
            break;
        case '/register':
            if (method == 'GET'){
                userController.showResisterForm(req, res);

            }else {
                userController.createUser(req, res);
            }
            break;
    }};
});

server.listen(8080, () => {
    console.log('server running is localhost:8080 ')
})
