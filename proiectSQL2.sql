select * from cont join comanda on (comanda.cont_id=cont.cont_id) join livrare on(comanda.livrare_id=livrare.livrare_id) join locatie on(locatie.locatie_id=livrare.locatie_id);
-- join la 4 tabele
select nume, prenume from cont where varsta > 18;
--filtrare celor care au varsta peste 18 ani
select * from comanda where produs_id in( select produs_id from produs where tip_produs_id in ( select tip_produs_id from tip_produs where gama='Controller'));
--subcerere nesincronizata slectarea tuturor datelor din comanda pentru cei care au comandat controller
select * from cont where cont_id in ( select cont_id from comanda cmd where cont_id in ( select cont_id from cont where data_inscriere = cmd.data_comenzii));
--subcerere sincronizata selectarea tuturor conturilor care au comandat in ziua in care au facut contul
select count(locatie_id),oras from locatie group by oras ;
--grupari de date gruparea datelor dupa oras
select count(locatie_id),oras from locatie group by oras having count(locatie_id)>1;
--filtrare grupari selecteaza orasele care au mai mult de un client in ele
select count(locatie_id),oras from locatie group by oras order by count(locatie_id) desc;
--functii grup  grupeaza orasul desrescator
select * from cont order by nume;
--ordonare  selecteaza cont in ordine alfabetica
select concat(nume, concat('.',prenume)) from cont;
--concat a doua siruri (char functii 1/2)
select upper(nume) from cont;
--upper case la un sir (char functii 2/2)
select carucior_id, NVL(cantitate, 0)
  "Cantitate produse diferita de null" from carucior
--nvl selecteaza cantitatile diferite de null din carucior
select cont_id, nume, prenume, varsta from cont order by DECODE('v','n',nume,'p',prenume,'v', varsta);
--decode ordoneaza dupa primul caracter dat ( decode compara cu primul caracter/numar)
select nume,
       varsta,
       case when varsta > 17 then 'major'
            else 'minor'
        end
 "major sau minor" from cont
--case afiseaza major pentru cei peste 18 ani si minor pt cei sub
select extract(year from data_comenzii) as "Anul Comenzii" from comanda;
-- extract la anul comenzi(functie data 1/2)
select sysdate from dual;
--sysdate afiseaza data curenta (functie date 2/2)
with temp (medcant) as
    (select avg(cantitate)
    from carucior)
    select *
    from carucior , temp
    where carucior.cantitate > temp.medcant;
--with se compara cantitatea cu cantitatea medie(stocata intru-un tabel temporar)

------EX 12
drop table cont1;
create table cont1(
    cont1_id int primary key,
    metoda_plata varchar(50) ,
    adresa_livrare varchar(50),
    nume varchar(50) ,
    prenume varchar(50) ,
    varsta int ,
    data_inscriere date
);
insert first
    when varsta > 18 then 
        into cont1
    select * from cont;
select * from cont1;
update cont1 
set prenume='Prenume',varsta=100
where nume='Rotarasu';
select * from cont1;

update cont1 
set     varsta = 
        (
          select varsta 
          from cont  
          where cont1.nume = cont.nume
        );
        
select * from cont1
delete from cont1 c1
where 60 > ( select varsta
                    from   cont  
                    where  nume = c1.nume
                    and  data_inscriere >= sysdate
        );

update cont1 c 
set varsta = ( select varsta
                    from cont
                    where varsta = c.varsta
                    );

drop view TabelView;
create view TabelView as
select cont.nume,cont.prenume,cont.metoda_plata,locatie.cod_postal,locatie.oras, locatie.detalii
from cont join comanda on (comanda.cont_id=cont.cont_id) join livrare on(comanda.livrare_id=livrare.livrare_id) join locatie on(locatie.locatie_id=livrare.locatie_id)
group by count(metoda_plata);
---In operatiile de view nu se pot folosii functii de group by

drop view TabelView;
create view TabelView as
select cont.nume,cont.prenume,cont.metoda_plata,locatie.cod_postal,locatie.oras, locatie.detalii
from cont join comanda on (comanda.cont_id=cont.cont_id) join livrare on(comanda.livrare_id=livrare.livrare_id) join locatie on(locatie.locatie_id=livrare.locatie_id);
-- Table View

---16

select c.comanda_id, 
       c.data_comenzii,
       c.cont_id,
       co.nume,
       livrare.status,
       locatie.oras
from comanda c
full outer join cont co ON (co.cont_id = c.cont_id) 
full outer join livrare on (livrare.livrare_id = c.comanda_id) 
full outer join locatie on (livrare.locatie_id = locatie.locatie_id)
order by cont_id;
---full outer join 
SELECT cont_id
FROM cont  
minus  
SELECT cont_id   
FROM comanda ;
---arata cine nu a comandat nimic de pe cont
select tip_produs_id
from tip_produs
minus
select tip_produs_id
from produs;
--- division arata tipurile de produsele care nu au fost cumparate 
----15
create index index1
on cont ( metoda_plata, data_inscriere);
select count(*)
from cont
where metoda_plata='Card Mastercard' and data_inscriere < to_date('15/10/2021', 'DD/MM/YYYY');
--index