const http = require('http');
const fs = require('fs');
const url = require('url')
const qs = require('qs');
// const LoginController = require('./controller/login-controller.js')
const UserController = require('../Web_trua_nay_an_gi/controller/user-controller')

const mimeTypes = {
    "html": "text/html",
    "js": "text/javascript",
    "min.js": "text/javascript",
    "css": "text/css",
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
let usercontroller = new UserController();

let server = http.createServer((req, res) => {
    let urlParse = url.parse(req.url);
    let urlPart = urlParse.pathname;
    let method = req.method;

    let filesDefences = req.url.match(/\.js|.css|.jpg|.png|.gif|min.js|min.css/);
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
        console.log(extension)
    }

    switch (urlPart) {
        case '/' :
            if(method == 'GET'){
                usercontroller.showLoginForm(req, res);
            }else {
                usercontroller.login(req, res);
            }
            break;
        case '/resister':
            if (method == 'GET'){
                usercontroller.showResisterForm(req, res);

            }else {
                usercontroller.createUser(req, res);
            }
            break;
    }
});

server.listen(8080, () => {
    console.log('server running is localhost:8080 ')
})
