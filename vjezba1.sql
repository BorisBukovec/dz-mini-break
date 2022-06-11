-- 0. Kreirajte tablice (16) i veze između tablica. (6)
# C:\xampp\mysql\bin\mysql -uroot --default_character_set=utf8  < C:\Users\botao\OneDrive\Dokumenti\dz-mini-break\proba.sql
drop database if exists vjezba1;
create database vjezba1;
use vjezba1;

create table sestra(
    sifra int not null primary key auto_increment,
    introvertno boolean,
    haljina varchar(31) not null,
    maraka decimal(16,6),
    hlace varchar(46) not null,
    narukvica int 
);

create table zena(
    sifra int not null primary key auto_increment,
    treciputa datetime,
    hlace varchar(46),
    kratkamajica varchar(31) not null,
    jmbag char(11) not null,
    bojaociju varchar(39) not null,
    haljina varchar(44),
    sestra int
);

create table punac(
   sifra int not null primary key auto_increment,
   ogrlica int,
   gustoca decimal(14,9),
   hlace varchar(41) not null 
);

create table cura(
   sifra int not null primary key auto_increment,
   novcica decimal(16,5) not null,
   gustoca decimal(18,6) not null,
   lipa decimal(13,10),
   ogrlica int not null,
   bojakose varchar(38),
   suknja varchar(36),
   punac int
);

create table sestra_svekar(
    sifra int not null primary key auto_increment,
    sestra int not null,
    svekar int not null
);

create table svekar(
    sifra int not null primary key auto_increment,
    bojaociju varchar(40) not null,
    prstena int,
    dukserica varchar(41),
    lipa decimal(13,8),
    eura decimal(12,7),
    majica varchar(35)
);

create table muskarac(
    sifra int not null primary key auto_increment,
    bojaociju varchar(50) not null,
    hlace varchar(30),
    modelnaocala varchar(43),
    maraka decimal(14,5) not null,
    zena int not null
);

create table mladic(
    sifra int not null primary key auto_increment,
    suknja varchar(50) not null,
    kuna decimal(16,8) not null,
    drugiputa datetime,
    asocijalno boolean,
    ekstroventno boolean not null,
    dukserica varchar(48) not null,
    muskarac int
);

alter table zena add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);
alter table muskarac add foreign key (zena) references zena(sifra);
alter table mladic add foreign key (muskarac) references muskarac(sifra);
alter table cura add foreign key (punac) references punac(sifra);





-- 1. U tablice muskarac, zena i sestra_svekar unesite po 3 retka. (7)
insert into sestra
(sifra,haljina,narukvica)
values 
(null,'plava',1);

insert into zena
(sifra,kratkamajica,jmbag,bojaociju,sestra)
values
(null,'nike','12345678901','smeđa',1),
(null,'adidas','12345678901','zelene',1),
(null,'puma','12345678901','smeđa',1);

insert into muskarac
(sifra,bojaociju,maraka,zena)
values
(null,'plava',34,2),
(null,'plava',34,2),
(null,'plava',34,2);

insert into svekar
(sifra,bojaociju)
values
(null,'zelena');

insert into sestra_svekar
(sifra,sestra,svekar)
values
(null,1,1),
(null,1,1),
(null,1,1);






-- 2. U tablici cura postavite svim zapisima kolonu gustoca na vrijednost 
-- 15,77. (4)
update cura
set gustoca = 15.77
where sifra is not null;



-- 3. U tablici mladic obrišite sve zapise čija je vrijednost kolone kuna 
-- veće od 15,78. (4)
delete from mladic where kuna>15.78;





-- 4. Izlistajte kratkamajica iz tablice zena uz uvjet da vrijednost kolone 
-- hlace sadrže slova ana. (6)

select kratkamajica 
from zena
where hlace like '%ana%';






-- 5. Prikažite dukserica iz tablice svekar, asocijalno iz tablice mladic te 
-- hlace iz tablice muskarac uz uvjet da su vrijednosti kolone hlace iz 
-- tablice zena počinju slovom a te da su vrijednosti kolone haljina iz 
-- tablice sestra sadrže niz znakova ba. Podatke posložite po hlace iz 
-- tablice muskarac silazno. (10)

select a.dukserica,f.asocijalno,e.hlace
from svekar a inner join sestra_svekar b on b.svekar=a.sifra
inner join sestra C on b.sestra=c.sifra
inner join zena d on c.sifra=d.sifra
inner join muskarac e on d.sifra=e.zena
inner join mladic f on e.sifra=f.muskarac
where d.hlace like 'a%' and c.haljina like '%ba%'
order buy e.hlace desc;





-- 6. Prikažite kolone haljina i maraka iz tablice sestra čiji se primarni 
-- ključ ne nalaze u tablici sestra_svekar. (5)


select b.haljina,b.maraka
from sestra_svekar a right join sestra b on a.sestra=b.sifra
where a.sestra is null;