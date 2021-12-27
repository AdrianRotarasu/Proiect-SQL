drop table tip_produs;
drop table produs;
drop table carucior;
drop table livrare;
drop table locatie;
drop table carucior;
drop table comanda;
drop table cont;

create table locatie(
    locatie_id int primary key,
    oras varchar(50) not null,
    cod_postal int not null,
    detalii varchar(100) 
);
create table livrare(
    livrare_id int primary key,
    locatie_id int references locatie(locatie_id),
    status varchar(50) not null
);

create table tip_produs(
    tip_produs_id int primary key,
    firma_produs varchar(50) not null,
    gama varchar(100) not null
);
create table produs(
    produs_id int primary key,
    tip_produs_id int references tip_produs(tip_produs_id),
    pret int not null,
    nume_produs varchar(50) not null,
    descriere varchar(100) not null
    
);
create table cont(
    cont_id int primary key,
    metoda_plata varchar(50) not null,
    adresa_livrare varchar(50) not null,
    nume varchar(50) not null,
    prenume varchar(50) not null,
    varsta int ,
    data_inscriere date not null
);

create table carucior(
    carucior_id int primary key,
    produs_id int references produs(produs_id),
    cont_id int references cont(cont_id),
    cantitate int not null
);
create table comanda(
    comanda_id int primary key,
    cont_id int references cont(cont_id),
    produs_id int references produs(produs_id),
    livrare_id int references livrare(livrare_id),
    data_comenzii date
);

create sequence idval
start with 1
increment by 1;
insert into locatie(locatie_id, oras, cod_postal, detalii) values (idval.nextval, 'Brasov', 500021,'Livrarea in fata blocului contactless');
insert into locatie(locatie_id, oras, cod_postal, detalii) values (idval.nextval, 'Cluj-Napoca',500213,'Livrare in easybox');
insert into locatie(locatie_id, oras, cod_postal, detalii) values (idval.nextval, 'Bucuresti', 23201, 'Livrare cu verificare');
insert into locatie(locatie_id, oras, cod_postal, detalii) values (idval.nextval, 'Constnata',213231,'Livrare cu verificare si plata la livrare');
insert into locatie(locatie_id, oras, cod_postal, detalii) values (idval.nextval, 'Brasov', 21323,' - fara mentiuni livrare');
drop sequence idval;

create sequence idval_livrare
start with 1
increment by 1;
insert into livrare(livrare_id, locatie_id, status) values(idval_livrare.nextval, 1, 'In curs de livrare la adresa');
insert into livrare(livrare_id, locatie_id, status) values(idval_livrare.nextval, 2, 'In sediul Targu Mures');
insert into livrare(livrare_id, locatie_id, status) values(idval_livrare.nextval, 3, 'In drum spre sediul Ilfov');
insert into livrare(livrare_id, locatie_id, status) values(idval_livrare.nextval, 4,'In asteptarea curierului la sediu central');
insert into livrare(livrare_id, locatie_id, status) values(idval_livrare.nextval, 5,'In drum spre locatie');
drop sequence idval_livrare;
select * from livrare;

create sequence idval_tip
start with 1
increment by 1;
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Sony PS4', 'Consola');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Sony PS5', 'Consola');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Microsoft', 'Consola');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Nintendo', 'Consola');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Nintendo','Controller');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Sony PS4','Controller');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Sony PS5','Controller');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Microsoft','Controller');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Sony PS4', 'Joc');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Sony PS5', 'Joc');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Microsoft' , 'Joc');
insert into tip_produs(tip_produs_id,firma_produs,gama) values(idval_tip.nextval,'Nintendo','Joc');
drop sequence idval_tip;
select * from tip_produs;

create sequence idval_prod
start with 1
increment by 1;
insert into produs(produs_id,tip_produs_id,pret,nume_produs,descriere) values(idval_prod.nextval,1,42000,'Playstation 4','Start a gaming adventure with the latest tehnology');
insert into produs(produs_id,tip_produs_id,pret,nume_produs,descriere) values(idval_prod.nextval,4,32000,'Nintendo Switch','The wonderful world of childhood games');
insert into produs(produs_id,tip_produs_id,pret,nume_produs,descriere) values(idval_prod.nextval,6,230,'Microsoft Controller','Start playing games locally with your friends');
insert into produs(produs_id,tip_produs_id,pret,nume_produs,descriere) values(idval_prod.nextval,12,170,'Super Mario Party','The funnest party game');
insert into produs(produs_id,tip_produs_id,pret,nume_produs,descriere) values(idval_prod.nextval,10,123,'The last of us','The best cinnematic game');
drop sequence idval_prod;
select * from produs;


create sequence idval_cont
start with 1
increment by 1;
insert into cont (cont_id, metoda_plata, adresa_livrare, nume, prenume, varsta, data_inscriere) values (idval_cont.nextval, 'Card Visa','Str Lunga 10','Rotarasu', 'Adrian', 21,to_date('29/10/2021', 'DD/MM/YYYY'));
insert into cont (cont_id, metoda_plata, adresa_livrare, nume, prenume, varsta, data_inscriere) values (idval_cont.nextval, 'Card Visa','Str Simeria 10','Schmidt', 'Karin', 32,to_date('25/10/2021', 'DD/MM/YYYY'));
insert into cont (cont_id, metoda_plata, adresa_livrare, nume, prenume, varsta, data_inscriere) values (idval_cont.nextval, 'Card Mastercard','Str Lamaitei 35', 'Gabor', 'Vlad',10,to_date('09/10/2021', 'DD/MM/YYYY'));
insert into cont (cont_id, metoda_plata, adresa_livrare, nume, prenume, varsta, data_inscriere) values (idval_cont.nextval, 'Cash Livrare', 'Str Bisericii 28', 'Nastase', 'Radu', 55,to_date('15/10/2021', 'DD/MM/YYYY'));
insert into cont (cont_id, metoda_plata, adresa_livrare, nume, prenume, varsta, data_inscriere) values (idval_cont.nextval, 'Card Mastercard','Str Rozelor 15', 'Simion', 'Vlad', 20,to_date('01/10/2021', 'DD/MM/YYYY'));
insert into cont (cont_id, metoda_plata, adresa_livrare, nume, prenume, varsta, data_inscriere) values (idval_cont.nextval, 'Card Mastercard','Str Franzelelor', 'Finta', 'Valenitin', 22,to_date('11/10/2021', 'DD/MM/YYYY'));

drop sequence idval_cont;
select * from cont;


create sequence idval_cart
start with 1
increment by 1;
insert into carucior(carucior_id,produs_id,cont_id,cantitate) values(idval_cart.nextval,1,1,2);
insert into carucior(carucior_id,produs_id,cont_id,cantitate) values(idval_cart.nextval,2,2,1);
insert into carucior(carucior_id,produs_id,cont_id,cantitate) values(idval_cart.nextval,3,3,1);
insert into carucior(carucior_id,produs_id,cont_id,cantitate) values(idval_cart.nextval,4,4,2);
insert into carucior(carucior_id,produs_id,cont_id,cantitate) values(idval_cart.nextval,5,5,1);
drop sequence idval_cart;
select * from carucior;


create sequence idval_cmd
start with 1
increment by 1;
insert into comanda(comanda_id,cont_id,produs_id,livrare_id,data_comenzii) values(idval_cmd.nextval,1,1,1,to_date('29/10/2021', 'DD/MM/YYYY'));
insert into comanda(comanda_id,cont_id,produs_id,livrare_id,data_comenzii) values(idval_cmd.nextval,2,2,2,to_date('27/09/2021', 'DD/MM/YYYY'));
insert into comanda(comanda_id,cont_id,produs_id,livrare_id,data_comenzii) values(idval_cmd.nextval,3,3,3,to_date('13/06/2021', 'DD/MM/YYYY'));
insert into comanda(comanda_id,cont_id,produs_id,livrare_id,data_comenzii) values(idval_cmd.nextval,4,4,4,to_date('05/04/2021', 'DD/MM/YYYY'));
insert into comanda(comanda_id,cont_id,produs_id,livrare_id,data_comenzii) values(idval_cmd.nextval,5,5,5,to_date('02/01/2021', 'DD/MM/YYYY'));
drop sequence idval_cmd;
select * from comanda;
commit;