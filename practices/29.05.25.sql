create schema nisa;

create table insan;
(insan_id int, soyad varchar(255), ad varchar(255), sehir varchar(255)); #gosternelik yazdik calismasina gerek yok

insan_id not null auto_increment primary key, soyad varchar(255), adres varchar(255), sehir varchar(255); #gostermelik

create table sinif (ogrno varchar(10) primary key, adi varchar(15), soyadi varchar(15), dtarihi int check(dtarihi>10), sinifi int default 1);

#sinif(ogrno, adi, soyadi, dtarihi, sinifi)
insert into sinif values ('2005285001', 'Nisa', 'Nur', 1988,1);
select * from sinif;  #dogru mu yaptik diye bakmak icin cagiriyoruz

insert into sinif(adi,ogrno) values ('nisa', '230705031'); #butun verileri  girmek istemedigimizde boyle yapiyoruz
select * from sinif;

set sql_safe_updates=0;
update sinif set dtarihi=2004;
select * from sinif;  #butun dtarihleri 2004 oldu

update sinif set sinifi=sinifi+1;
select * from sinif;

#ogrencino su 230705031 olan kisinin soyadini degistirmek degistirmek
update sinif set soyadi='Unal' where ogrno='230705031';
select * from sinif;

#dogum tarihi 2003 ten buyuk olanlari 2 azaltti
update sinif set dtarihi=dtarihi-2 where dtarihi>2003;
select * from sinif;

#sinifi 2 olanlarin dtarihini 2004 olarak degistirme
#bunu yapmak icin sinifi iki olan kişi ekleyeyim
insert into sinif(ogrno,sinifi, dtarihi) values(230705020, 2, 2000);
update sinif set dtarihi=2004 where sinifi=2;
select * from sinif;

#veri silme

delete from sinif where adi='nisa';
select * from sinif;

delete from sinif where ogrno='230705020';
select * from sinif;

create table silinecekdeneme(id int);
drop table silinecekdeneme;

alter table sinif add kayit_tarihi date;  #tabloya sutun ekledik
select * from sinif;

alter table sinif drop kayit_tarihi; #sutun silme
select * from sinif;

alter table sinif modify ogrno int; #ogrno yu karakterden int e cevirdim
select * from sinif;


#ana şemayi movie yap
create view film as select title year, name from movie, actor, cast  #film dedigimiz random tablo adi 
where movie.id=cast.actorid and ord=1;


create view film as select * from movie;
select *from film;   #bu çalismadi bir bak

#trigger tetiklemek yani ne dmek şu demek bir şey yapinca bir şey oluyo sinavda trigger yok ama bil(bilmedi)





























