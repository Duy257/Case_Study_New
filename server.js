const http = require('http');
const fs = require('fs');
const url = require('url')
const qs = require('qs');
const UserController = require('./controller/user-controller');
const CategoryController = require('./controller/admin_controller/category-controller');
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
let usercontroller = new UserController();
let categoryController = new CategoryController();
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
    }

    switch (urlPart) {
        // case '/' :
        //     if(method == 'GET'){
        //         usercontroller.showLoginForm(req, res);
        //     }else {
        //         usercontroller.login(req, res);
        //     }
        //     break;
        // case '/resister':
        //     if (method == 'GET'){
        //         usercontroller.showResisterForm(req, res);

        //     }else {
        //         usercontroller.createUser(req, res);
        //     }
        //     break;
        case '/':
            if(method == 'GET'){
                categoryController.showCategory(req, res);
            }
            
            break;
        case '/createcategory':{
            if(method == 'GET'){
                categoryController.showFormCreateCategory(req, res);
            }else{
                categoryController.createCategory(req, res);
            }
            break;
        }
        // case '/donecategory':{
        //     categoryController.showCategory(req, res);
        //     break;
        // }
        case '/editcategory':{
            let query = qs.parse(urlParse.query);
            let idUpdate = query.id;
            if(method == 'GET'){
                categoryController.showFormEditCategory(req, res, idUpdate);
            }
            else{
                categoryController.editCategory(req, res, idUpdate);
            }
            break;
        }
        // case '/deletecategory':{
            
        //     break;
        // }
    }
});

server.listen(8080, () => {
    console.log('server running is localhost:8080 ')
})
