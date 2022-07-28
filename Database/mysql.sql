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
    email VARCHAR(50) not null unique,
    phone varchar(12) not null unique,
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
 
create table restaurant(
	id int primary key auto_increment,
    name varchar(100) unique,
    operatingtime varchar(100),
    address varchar(255),
    idUser int,
    foreign key (idUser) references users(id)
);

drop table category;
create table category(
	id int primary key auto_increment,
    name varchar(50) not null unique,
    type varchar(30) not null,
    image varchar(30),
    amountAddress int default 0,
    idrestaurant int,
    foreign key (idrestaurant) references restaurant(id)
);

create table tag(
	id int primary key auto_increment,
    name varchar(50) not null,
    slug varchar(50) not null unique,
    innings int default 0,
    view int default 0
);

create table discount(
	id varchar(100) primary key,
    name varchar(100) unique,
	value float not null
);

create table product(
	id int auto_increment primary key,
    name varchar(100) not null unique,
    idCategory int,
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
insert into role(id, name) values 
(0, 'admin'), 
(1, 'collabarator'), 
(2, 'client');

select * from users;

insert into users(name, email, phone, password) values 
('Ngô Gia Bảo', 'bao@gmail.com', 0123456789, '123456aA@'),
('Shop 1', 'shop1@gmail.com', 0123455523, '123456aA@'),
('Shop 2', 'shop2@gmail.com', 0123455456, '123456aA@'),
('Shop 3', 'shop3@gmail.com', 0123451211, '123456aA@'),
('Shop 4', 'shop4@gmail.com', 0123456567, '123456aA@');
insert into users(name, email, phone, password) values 
('Shop 5', 'shop5@gmail.com', 0123456422, '123456aA@'),
('Shop 6', 'shop6@gmail.com', 0123456311, '123456aA@'),
('Shop 7', 'shop7@gmail.com', 0123456665, '123456aA@'),
('Shop 8', 'shop8@gmail.com', 0123456476, '123456aA@');

select * from users;
insert into role_user(idRole, IdUser) values (2, 1), (2, 2), (2, 3) ,(2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9);
insert into role_user(idRole, IdUser) values (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9);
select * from role_user;

select id from users order by id desc limit 1;

select * from users;

update users set name='a', email='a@gmail.com', phone='0121212121', password='1212121' where id = 1;

delete from users where id = 1;

insert into tag(name, slug) values  ('All', 'all'),
							  ('Đồ ăn', 'do-an'),	
							  ('Đồ uống', 'do-uong'),
                              ('Đồ chay', 'do-chay'),
                              ('Bánh kem', 'banh-kem'),
                              ('Tráng miệng', 'trang-mieng'),
                              ('Piza/Burger', 'pizza-burger'),
                              ('Món gà', 'mon-ga'),
                              ('Món lẩu', 'mon-lau'),
                              ('Mì phở', 'mi-pho'),
                              ('Cơm hộp', 'com-hop'),
                              ('Sushi', 'sushi');
					
insert into category(name,type, image) values  ('Cơm', 'product', '1.png'),
										('Bún/Phở', 'product', '2.jpg'),
										('Đồ uống', 'product', '3.jpg'),
										('Đồ ăn nhanh', 'product', '4.jpg'),
										('Ăn vặt', 'product', '5.jpg'),
                                        ('Lẩu nướng', 'product', '6.jpg'),
										('Đặc sản', 'product', '7.jpg'),
										('Healthy', 'product', '8.jpg');
insert into restaurant(name, operatingtime, address, idUser) values ('Cơm Rang Gà Sốt 30K - Mỹ Đình', '06:30 - 22:30', '14 Ngõ 20 Mỹ Đình, P. Mỹ Đình 2, Nam Từ Liêm, Hà Nội', 2),
('BUMTRO - Bún Trộn Nam Bộ - Đào Tấn', '07:00 - 21:00', '26 Ngõ 58 Đào Tấn, P. Cống Vị, Ba Đình, Hà Nội', 3),
('Trà sữa Tocotoco - Lê Trọng Tấn', '08:00 - 23:00', '156 Lê Trọng Tấn, P. La Khê, Hà Đông, Hà Nội', 4),
('McDonald - Hồ Gươm', '07:00 - 23:00', '2 Hàng Bài, P. Tràng Tiền, Hoàn Kiếm, Hà Nội', 5),
('Tào Phớ Jellybean - Quang Trung', '07:30 - 21:30', '28 Quang Trung, P. Trần Hưng Đạo, Hoàn Kiếm, Hà Nội', 6),
('Quán Ngon Thái - Ẩm Thực Thái Lan', '08:00 - 22:00', '56/52 Tô Ngọc Vân, Tây Hồ, Hà Nội',7 ),
('Cô Hương Béo - Bún Riêu Tóp Mỡ Mọc Giòn - Tống Duy Tân', '07:30 - 23:59', '2C Tống Duy Tân, P. Hàng Bông, Hoàn Kiếm, Hà Nội', 8),
('Diệu Âm Quán - Ngọc Lâm', '07:00 - 21:50', '696 Ngọc Lâm, P. Gia Thuỵ, Long Biên, Hà Nội', 9);

-- insert into discount(id,value) values   ('giảm 20k cho đơn 50k', '20000'),
-- 										('giảm 30k cho đơn 70k', '30000'),
-- 										('Giảm 50k cho đơn 120k', '50000'),
-- 										('Giảm 70k cho đơn 200k', '70000'),
-- 										('Giảm 100k cho đơn 300k', '100000')
insert into product(name, idCategory, idtag, image, price, promotionalprice, serviceprice, servicenote, preparationtime, creationdate, editdateend ) values  ('Cơm Sườn', 1,2,'11.png','40000','4000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
																																							 ('Cơm Gà', 1,8,'12.jpg','40000','4000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Cơm Bò', 1,2,'13.jpg','50000','5000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
																																							 ('Bún Bò', 2,10,'21.jpg','60000','6000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Bún Hến', 2,10,'22.jpg','30000','3000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Phở bò', 2,10,'23.jpg','45000','4500','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
																																							 ('Trà sữa', 3,3,'31.jpg','35000','3500','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Trà chanh', 3,3,'32.jpg','15000','1500','2000','Thơm ngon','5 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Nước sinh tố', 3,3,'33.jpg','25000','2500','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
																																							 ('Bánh mì', 4,2,'41.png','25000','2500','2000','Thơm ngon','5 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Gà rán', 4,8,'42.jpg','50000','5000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Hambuger', 4,7,'43.jpg','60000','6000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
																																							 ('Mì lắc', 5,10,'51.jpg','35000','3500','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Bánh tráng trộn', 5, 2,'52.jpg','15000','1500','2000','Thơm ngon','5 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Phô mai que', 5,2,'53.jpg','10000','1000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
																																							 ('Lẩu thái', 6,9,'61.jpg','250000','25000','5000','Thơm ngon','15 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Lẩu hải sản', 6,9,'62.jpg','350000','35000','5000','Thơm ngon','15 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Lẩu Tokbokki', 6, 9,'63.jpg','200000','20000','5000','Thơm ngon','15 phút','2022-07-25','22-07-25'),
																																							 ('NEM 36 - Đặc Sản Thanh Hóa', 7,2,'71.jpg','120000','12000','2000','Thơm ngon','5 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Trâu gác bếp Tây Bắc', 7,2,'72.jpg','400000','40000','2000','Thơm ngon','5 phút','2022-07-25','22-07-25'),
                                                                                                                                                             (' Đặc Sản Nem Bùi Bắc Ninh', 7,2,'73.jpg','80000','8000','2000','Thơm ngon','5 phút','2022-07-25','22-07-25'),
																																							 ('Gateau Healthy', 8, 4,'81.jpg','40000','4000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Salad - Healthy', 8,4,'82.jpg','30000','3000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25'),
                                                                                                                                                             ('Bột - Healthy Food ', 8,4,'83.jpg','40000','4000','2000','Thơm ngon','10 phút','2022-07-25','22-07-25');


                                        
