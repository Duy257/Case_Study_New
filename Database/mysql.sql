create database module3;
use module3;
drop database module3;

create TABLE role (
    id INT PRIMARY KEY,
    name VARCHAR(20)
);

create table users(
    id int AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) not null,
    email VARCHAR(50) not null,
    phone varchar(12) not null,
    password VARCHAR(50) not null,
    idRestaurant varchar(100)
);

create table address(
	id int primary key auto_increment,
    name varchar(255) not null,
    idUser int,
    foreign key (idUser) references users(id)
);

create table role_user(
	idRole int,
    idUser int,
    primary key(idRole, idUser),
    foreign key (idRole) references role(id),
    foreign key (idUser) references users(id)
);


create table category(
	id int primary key auto_increment,
    name varchar(50) not null,
    type varchar(30) not null,
    image varchar(30),
    amoountAddress int default 0
);

create table restaurant(
	id int primary key auto_increment,
    name varchar(100),
    operatingtime varchar(100),
    address varchar(255),
    idUser int,
    idCategory int,
    foreign key (idCategory) references category(id),
    foreign key (idUser) references users(id)
);

create table tag(
	id int primary key auto_increment,
    name varchar(50) not null,
    slug varchar(50) not null,
    innings int default 0,
    view int default 0
);

create table discount(
	id varchar(100) primary key,
    name varchar(100),
	value float not null
);

create table product(
	id int auto_increment primary key,
    name varchar(100) not null,
    idCategory int,
    iddiscount varchar(100),
    idtag int,
    image varchar(50) not null,
    price varchar(50) not null,
    promotionalprice varchar(50) not null,
    serviceprice varchar(50) default 0,
    servicenote varchar(255) not null,
    preparationtime varchar(50) not null,
    usagesdiscount int default 0,
    view int default 0,
    amount int,
    creationdate date, 
    editdateend date,
    foreign key (idCategory) references category(id),
    foreign key (iddiscount) references discount(id),
    foreign key (idtag) references tag(id)
);

create table cart(
	id int auto_increment primary key,
    iduser int,
	total int default 0,
    createDay datetime,
    foreign key (iduser) references users(id)
);

create table cartdetails(
	id int auto_increment primary key,
    idproduct int,
    idcart int,
    amount int,
    price int,
    foreign key (idproduct) references product(id),
    foreign key (idcart) references cart(id)
);

insert into category(name, type, image) values
('Danh muc 1', 'Nha hang', 'Anh 1'),
('Danh muc 2', 'Nha hang', 'Anh 2'),
('Danh muc 3', 'Nha hang', 'Anh 1')
;

insert into category(name, idCategory, idtag, image, price, promotionalprice, serviceprice, servicenote, preparationtime, creationdate, editdateend ) values  ('Cơm Sườn', 1,2,'11.png','40000','4000','2000','Thơm ngon','10 phút',2022-07-25,22-07-25);

insert into role(id, name) values 
(0, 'admin'), 
(1, 'collabarator'), 
(2, 'client');

select * from users;

insert into users(name, email, phone, password) values 
('Ngô Gia Bảo', 'bao@gmail.com', 0123456789, '123456aA@'),
('Duy Duy', 'Duy@gmail.com', 0123456222, '123456aA@');

insert into role_user(idRole, IdUser) values
(1, 8);
select * from role_user;
insert into restaurant(name, operatingtime, address, idUser, idCategory) values
('Nha hang1', '12:00-22:00', 'Ha Noi', 1);

select id from users order by id desc limit 1;

select * from users;

update users set name='a', email='a@gmail.com', phone='0121212121', password='1212121' where id = 1;

delete from users where id = 1;

insert into users(name, email, phone, password, idRestaurant) values 
('Thu', 'bao@gmail.com', 0123456333, '123456aA@', 1),
('Nghiêm Văn Đông', 'Dong@gmail.com', 0123456444, '123456aA@', 2)