const {combine} = require("qs/lib/utils");
const qs = require('qs');
const fs = require('fs');
const { rejects } = require('assert');
const { resolve } = require('path');
const Connection = require("./connection");

class User {
    
    constructor() {
        this.connection = Connection.createConnection();
        this.connection.connect((err) => {
            if (err) {
                console.log(err)
            }else {
                console.log('connect success!')
            }
        });
    }

    
    getUser() {
        return new Promise((resolve, reject) => {
            this.connection.query(`select * from users;`, (err, data) => {
                if(err) {
                    return reject (err)
                }else {
                    return resolve (data)
                }
            });
        });
    }

    createUser(user) {
        let insertQuery = `insert into users (name, password, email, phone) VALUES
                                                                                ('${user.name}', '${user.password}', '${user.email}', '${user.phone}');`
        this.connection.query(insertQuery, (err, data) => {
            if (err) {
                console.log('create error: ' + err)
            }else {
                console.log('create success!')
            }
        })
    };

    updateUser(idUser, User){
        return new Promise((rejects, resolve) => {
            let updateQuery = (`update users set name='${User.name}', email='${User.email}', phone='${User.phone}', password='${User.password}' where id=${idUser}`);
            this.connection.query(updateQuery, (err, data) => {
                if(err){
                    rejects(err);
                } else {
                    resolve('Update Success!');
                }
            })
        })
    };

    remoteUser(id){
        return new Promise((rejects, resolve) => {
            let deleteQuery = `delete from users where id=${id}`
            this.connection.query(deleteQuery, (err, data) => {
                if(err){
                    rejects(err);
                } else {
                    resolve('Remove success!');
                }
            })
        })
    }

};
module.exports = User;
