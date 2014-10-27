/*-------sql sript for the project sreeartgallery database--------*/
/*--Include 1. create tables--------------------------------------*/
/*----------2.Insert data-------------------------------------------*/
/*----------3.creating users and granting permissions---------------*/
/*----------4. Frequently used queries--------------------------------*/
create database sreeArtGallery;
use sreeArtGallery;
create table if not exists artists
(
artist_id int(6)   not null auto_increment,
artist_name varchar(30) not null,
dob  date,
contact_no varchar(18),
photo_file_name varchar(50),
country varchar(30),
usual_price decimal(10,2),
other_details varchar(300),
constraint pk_artist primary key(artist_id)
);
create table if not exists buyer
(
buyer_id int(6)   not null auto_increment,
organisation varchar(30),
person_name varchar(30) not null,
gender varchar(14),
contact_no varchar(18),
pay_method varchar(18),
payment_details varchar(300),
constraint pk_buyer primary key(buyer_id)
);
create table if not exists artworks
(
art_id int(6) not null auto_increment,
artist_id int(6) not null,
art_title varchar(50) not null,
image_file_name varchar(50),
inventory varchar(50)     default 'gHall1',
art_status enum('available','sold','reserved','consigned out') default 'available',
selling_price decimal(10,2),
artform enum('painting','photograph','sculpture') default 'painting',
constraint pk_art primary key(art_id),
constraint fk_artist foreign key(artist_id) references artists(artist_id)
ON UPDATE CASCADE ON DELETE RESTRICT);
/* There are 3 subclasses  for the super class artwork    */
/* First subclass of artwork*/
create table if not exists painting
(
paint_id int(6) not null,
Painting_medium varchar(30) not null,
dimensions varchar(15),
category enum('landscape', 'potrait', 'abstract','still_life') default 'landscape',
notes varchar(300),
constraint pk_painting primary key(paint_id),
constraint fk_artwork foreign key(paint_id) references artworks(art_id)
on update cascade on delete restrict
);
/* second subclass of artwork*/
create table if not exists photograph
(
photo_id int(6) not null,
color enum('yes','no') default 'yes',
size varchar(15),
description varchar(300),
signed_by_artist enum('yes','no') default 'yes',
dated date,
constraint pk_photograph primary key(photo_id),
constraint fk_artwork1 foreign key(photo_id) references artworks(art_id)
on update cascade on delete restrict
);
/* third subclass of artwork*/
create table if not exists sculpture
(
scul_id int(6) not null,
material varchar(30) default 'stone',
dimensions_3 varchar(21),
other_depictions varchar(150),
maintain_note varchar(250),
constraint pk_sculpture primary key(scul_id),
constraint fk_artwork2 foreign key(scul_id) references artworks(art_id)
on update cascade on delete restrict
);
create table if not exists sale
(
sale_id int(6) not null auto_increment,
buyer_id int(6)   not null,
art_id int(6) not null,
date_of_sale date,
price_paid decimal(10,2) not null,
delivery_note varchar(300),
constraint pk_sale primary key(sale_id),
constraint fk_buyer foreign key(buyer_id) references buyer(buyer_id)
on update cascade on delete restrict,
constraint fk_artwork3 foreign key(art_id) references artworks(art_id)
on update cascade on delete restrict
);
/*-------------------- POPULATING THE TABLES------------------------------ */
/* INSERTING DATA INTO 'ARTISTS' TABLE */
SET FOREIGN_KEY_CHECKS = 0;
insert into  artists(artist_name, photo_file_name,usual_price)
values('Paddy','artists/artist1.jpg',1000.00), ('ketty','artists/artist2.jpg',1500.00);
insert into  artists(artist_name, photo_file_name,usual_price)
values('Mary O Gorman','artists/artist3.jpg',5000.00), 
('George','artists/artist4.jpg',15000.00);
insert into  artists(artist_name, photo_file_name,usual_price,dob,country)
values('Miriam Shaw','artists/artist5.jpg',25000.00,'1972-08-24','UK'), 
('John','artists/artist6.jpg',25000.00,'1959-06-04','Ireland'),
('James','artists/artist7.jpg',15000.00,'1969-10-09','Denmark'),
('Hanuman Kambli','artists/artist8.jpg',25000.00,'1959-07-09','India'),
('Ramsa','artists/artist9.jpg',25000.00,'1971-05-16','Portugal'),
('Wilson D Souza','artists/artist10.jpg',25000.00,'1965-06-14','India');
insert into  artists(artist_name, photo_file_name,usual_price)
values('Clare Farmer','artists/artist11.jpg',35000.00,'1968-07-15','sweden'), 
('Hussain','artists/artist12.jpg',50000.00,'1937-11-09','India');
/* INSERTING DATA INTO 'BUYER' TABLE */
insert into buyer(organisation, person_name,gender,pay_method,contact_no)
values('Bulmers','Hillary','Female','Direct debit','003537261245068'),
('Pinewood','Himan','Male','Direct debit','003539261245068'),
('Ranbaxy','Rose','Female','Cheque','003537261249063'),
('Cisco','Himanshu','Male','Direct debit','003535661245068'),
('Brennan','Roma','Female','Cash','0035372613675068');
insert into buyer( person_name,gender,pay_method,payment_details)
values('Anna','Female','Direct debit','BOI, Account No. 12345678'),
('Arman','Male','Cheque','BOI, Cheque No. 1006789'),
('Beena','Female','Cash','All 50s'),
('Den','Male','Direct debit','AIB, Account No. 1567348'),
('Emma','Female','Cheque','Ulster Bank, Cheque No. 009765678'),
('Geeta','Female','Credit card','UTI Bank, Credit card No. 1003425689');
/* INSERTING DATA INTO 'ARTWORKS' TABLE */
insert into artworks(artist_id,art_title,image_file_name,selling_price,artform)
values(1,'Flying Together','artwork/art1.png',1200.00,'photograph'),
(2,'Mountain Range','artwork/art2.png',1750.00,'photograph'),
(1,'Wild Parrot','artwork/art3.png',1250.00,'photograph'),
(1,'war zone','artwork/art5.png',1100.00,'photograph'),
(2,'Living with Fear','artwork/art4.png',1200.00,'photograph');
insert into artworks(artist_id,art_title,selling_price,inventory,art_status)
values(4,'The Indian Maid',15000.00,'out of Gallery','consigned out'),
(4,'The Girl in Pink',15000.00,'out of Gallery','consigned out'),
(3,'The Girl in Black',6000.00,'out of Gallery','consigned out'),
(5,'The Rich Five',25000.00,'out of Gallery','consigned out');
insert into artworks(artist_id,art_title,selling_price,artform,art_status,inventory)
values(7,'The Soulmates',15000.00,'painting','sold','delivered'),
(2,'The Flight',5000.00,'photograph','sold','delivered'),
(3,'The Fish in the Waves',6000.00,'photograph','sold','delivered'),
(5,'In view of the Nestlings',25000.00,'painting','sold','delivered');
insert into artworks(artist_id,art_title,selling_price)
values(8,'Going with the Wind',25000.00),
(7,'Face to Face',25000.00),
(9,'The Heavy Headed',35000.00),
(8,'The Wild Reflections',25000.00);
insert into artworks(artist_id,art_title,selling_price,artform)
values(10,'The Soldier',35000.00,'sculpture'),
(11,'The Unique Craft',35000.00,'sculpture'),
(12,'Radha Krishna',46000.00,'sculpture'),
(10,'The Cave Men',25000.00,'sculpture');
UPDATE artworks SET `image_file_name`='artworks/art30.png' WHERE `art_id`='30';
UPDATE artworks SET `image_file_name`='artworks/art31.png' WHERE `art_id`='31';
UPDATE artworks SET `image_file_name`='artworks/art32.png' WHERE `art_id`='32';
UPDATE artworks SET `image_file_name`='artworks/art33.png' WHERE `art_id`='33';
UPDATE artworks SET `image_file_name`='artworks/art34.png' WHERE `art_id`='34';
UPDATE artworks SET `image_file_name`='artworks/art35.png' WHERE `art_id`='35';
UPDATE artworks SET `image_file_name`='artworks/art36.png' WHERE `art_id`='36';
UPDATE artworks SET `image_file_name`='artworks/art37.png' WHERE `art_id`='37';
UPDATE artworks SET `image_file_name`='artworks/art38.png' WHERE `art_id`='38';
UPDATE artworks SET `image_file_name`='artworks/art39.png' WHERE `art_id`='39';
UPDATE artworks SET `image_file_name`='artworks/art40.png' WHERE `art_id`='40';
UPDATE artworks SET `image_file_name`='artworks/art41.png' WHERE `art_id`='41';
insert into artworks(artist_id,art_title,image_file_name,selling_price,artform,inventory,art_status)
values(1,'The Glowing Reflection','artwork/art42.png',1200.00,'photograph','delivered','sold'),
(9,'The Patterned Peacock','artwork/art43.png',11750.00,'painting','delivered','sold'),
(8,'Group violation','artwork/art44.png',15250.00,'painting','delivered','sold'),
(7,'The Last Entry','artwork/art45.png',14000.00,'painting','delivered','sold'),
(12,'Metalic Soul','artwork/art46.png',12000.00,'sculpture','delivered','sold');
/* INSERTING DATA INTO 'painting' TABLE */
insert into painting(paint_id,painting_medium,dimensions,category)
values(6,'water colour','20.4*28.4','potrait'),
(7,'Acrylic paints','44.4*38.2','potrait'),
(8,'Acrylic paints','44.4*38.2','abstract'),
(9,'oil','44.4*38.2','still_life'),
(10,'Acrylic paints','40.4*30.2','abstract');
insert into painting(paint_id,painting_medium,dimensions)
values(13,'water colour','20.4*28.4'),
(14,'oil','53.4*42.4'), (15,'oil','50.4*40.4'),
(16,'oil','40.2*32.4'), (17,'oil','53.4*42.4');
insert into painting(paint_id,painting_medium,dimensions,category)
values(23,'water colour','20.4*28.4','potrait'),
(24,'Acrylics','40.2*38.4','abstract'), (25,'Acrylics','40.2*38.4','abstract'),
(46,'Water colour','40.2*38.4','still_life');
/* INSERTING DATA INTO 'photograph' TABLE */
insert into photograph(photo_id,size,description,dated)
values(1,'12*12','landscape','1972-03-12'),
(2,'12*12','landscape','1972-03-12'), (3,'21*21','war story','1989-09-12'),
(4,'12*12','landscape','1986-05-09'), (5,'15*15','Event','1968-07-04');
insert into photograph(photo_id,size,color,description,signed_by_artist)
values(11,'18*18','no','aerial','no'), (12,'18*18','no','war effected','no'),
(22,'18*18','no','artistic','no');
/* INSERTING DATA INTO 'sculpture' TABLE */
insert into sculpture(scul_id,material)
values(18,'chrome alloy'),(19,'glass'),(20,'marble'),(21,'stone'),(26,'stone');
/* INSERTING DATA INTO 'sale' TABLE */
insert into sale(buyer_id,art_id,date_of_sale,price_paid,delivery_note)
values(6,10,'2012-07-09',15000.00,'shipping'),
(7,11,'2012-09-19',5000.00,'cargo'), (8,12,'2012-10-18',6000.00,'by land'),
(9,13,'2012-11-09',25000.00,'shipping'), (10,22,'2012-12-29',1200.00,'by land'),
(11,23,'2013-02-10',11750.00,'shipping'), (9,24,'2013-07-09',15250.00,'cargo'), 
(7,25,'2013-09-29',14000.00,'shipping'), (11,26,'2013-11-15',12000.00,'shipping');
SET FOREIGN_KEY_CHECKS = 1;
/*------ creating users and granting permissions-------------*/
create user pro_buyer@localhost identified by 'buyers123';
grant select on artworks to pro_buyer@localhost;
/*revoke select on artworks from buyer;*/
show grants for pro_buyer@localhost;

create user salesperson@localhost identified by 'sales123';
grant select, update, insert on sale  to salesperson@localhost;
grant select on artworks to salesperson@localhost;
show grants for salesperson@localhost;
/*drop user salesperson */

CREATE USER gallerymanager@'%' 
IDENTIFIED BY 'Gmanager***';
SELECT PASSWORD ('Gmanager***') AS encrypt_password;
GRANT ALL ON sreeartgallery.* 
TO gallerymanager@'%' WITH GRANT OPTION;


/*-----------------------viewing tables one by one-----------------------------*/
use sreeartgallery;
select * from artworks;
select* from sale;
select * from artists;
select * from buyer;
select * from painting;
/* creating view with all information about each subclass of artwork */
create view paintings_details
as
select p.painting_medium, p.dimensions, p.category, a.artist_id, a.art_title, a.art_status, a.selling_price 
from painting p
join artworks a
on p.paint_id = a.art_id
where a.artform = 'painting';
create view photographs_details
as
select p.size, p.description , a.artist_id, a.art_title, a.art_status, a.selling_price 
from photograph p
join  artworks a
on p.photo_id = a.art_id
where a.artform = 'photograph';

create view sculptures_details
as
select s.material, a.artist_id, a.art_title, a.art_status, a.selling_price
from sculpture s
join  artworks a
on s.scul_id = a.art_id
where a.artform = 'sculpture';
/*--------------artists  whoose arts are sold with related fields---------------*/
create view artists_art_sold
as
select s.artist_name , a.artist_id, a.art_title, a.artform, a.selling_price 
from artists s
join  artworks a
on s.artist_id = a.artist_id
where a.art_status = 'sold';


select * from sculptures_details;
select * from photographs_details;
select * from paintings_details;
select * from artists_art_sold;

SHOW FULL TABLES IN sreeartgallery WHERE TABLE_TYPE LIKE 'VIEW';

/*-----------------------Queries-----------------------------*/
select * from artworks where art_title = 'Going with the Wind';
delete from artistss where artist_id >55;
/* order by the same field which has condition on */
Select artist_id, artist_name, usual_price from artists
where usual_price >10000.00 order by usual_price;
/* 2 conditions at a time */
Select artist_id, artist_name, usual_price, dob from artists
where year(dob) <=1960 and usual_price >= 25000;
/* specific to one tuple */
select person_name,contact_no from buyer
where organisation = 'Bulmers';
/* getting number of females and  males from buyers to check the general trend*/
select count(gender) from buyer
where gender = 'Female';
select count(gender) from buyer
where gender = 'Male';
/*------------------------------------ sold items list------------*/
select * from artworks 
where art_status = 'sold';
/* fields from 2 tables */
select a.art_id, a.art_title, a.selling_price, s.artist_name from artworks a, artists s
where  a.artist_id = s.artist_id ;
/* --------------retrieving fields from 3 tables----------------*/
select a.art_title, a.artform, s.price_paid, t.artist_name from artworks a, sale s, artists t
where a.art_id = s.art_id  and  a.artist_id = t.artist_id order by t.artist_name;
/* ---------------list of painters------------*/
select artist_name from artists t 
where artist_id in (select artist_id from artworks a where artform = 'painting'); 
/* ------total sales on paintngs-----------------*/ 
select sum(s.price_paid)
from sale s
where art_id in (select art_id from artworks a where artform = 'painting');
/*  joining 4 tables to retrieve related information----*/
select b.person_name, a.art_title, t.artist_name, s.price_paid
from buyer b
join sale s
on b.buyer_id = s.buyer_id
join  artworks a
on s.art_id = a.art_id
join artists t
on a.artist_id = t.artist_id;
/* ------------sum of sales on year 2013-----------*/
select sum(price_paid) from sale
where year(date_of_sale) = 2013;
/*number of artworks sold in 2013*/
select count(art_id) from sale
where year(date_of_sale) = 2013;
select count(art_id) from sale
where year(date_of_sale) = 2012;
select sum(price_paid) from sale
where year(date_of_sale) = 2012;

/*----------------------getting contact numbers of prospective buyers to make contact---------*/
select b.contact_no from buyer b
where b.buyer_id not in(select buyer_id from sale s);
/*---------------artist names whose work not present in the gallery at the moment---------*/
select t.artist_name from artists t
where t.artist_id not in (select artist_id from artworks a);

/* ---given medium of painting getting all paintings-----*/
select a.art_title, a.selling_price, p.dimensions
from artworks a
join painting p
on p.paint_id = a.art_id
where p.painting_medium = 'oil';
/* getting available paintings from the above situation, require condition on both tables */
select a.art_title, a.selling_price
from artworks a where a.art_status = 'available'
and a.art_id in(select paint_id from painting p
where p.painting_medium = 'oil');




/*----------------------------------------------------------------*/