#odev movie verisi
#1- Her yıl kac film cekilmistir?
select count(*), year from movie group by year;

#2- Her filmde kaç oyuncu var?
select movieid, count(actorid) from cast group by movieid;

#3-En çok oyuncusu olan filmin ismi nedir?
select title, count(actorid) from movie m join cast c on m.id=c.movieid 
group by title order by count(actorid) desc limit 1;

#4-En çok oyuncusu olan 3 filmin ismi nedir?
select title, count(actorid) from movie m join cast c on m.id=c.movieid 
group by title order by count(actorid) desc limit 3;

#5-10'dan fazla oyuncusu olan filmlerin adı nedir?
select title, count(actorid) from movie m join cast c on m.id=c.movieid group by title having count(actorid)>=10;

#6- Her oyuncu kaç filmde oynamıştır?
select name, count(movieid) from actor a join cast c on a.id=c.actorid 
group by name;

#7- Her oyuncu kaç filmde başrol oynamıştır? 
select  a.name, count(*) as basrol_sayisi from actor a join cast c on a.id=c.actorid where c.ord="1" group by name;


#8- En çok başrol oynayan oyuncunun ismi nedir?
select name, count(*) as basrol from actor a join cast c on a.id=c.actorid where c.ord="1" group by name order by 
count(*) desc limit 1;


#en çok filmde oynayan oyuncu kim (alistirma)
select name, count(movieid) from actor a join cast c on a.id=c.actorid group by name 
order by count(movieid) desc limit 1;


#9-Star Wars' ta oynayan oyuncularin adlari nedir?
select name, movieid as star_wars from actor a join cast c on a.id=c.actorid 
join movie m on 
c.movieid=m.id where title="Star Wars";

#10-Harrison Ford' un oynadığı filmlerin isimleri nedir? aciklamasi anlamam icin: 
#harris id si actor den ve o id ile cast tablsundan movieid si bulunmali o veriyle de 
#title movie tablosundan secilmeli
select name as oyuncu_ismi, title as Film_Adi from movie m join cast c on m.id=c.movieid join actor a 
on c.actorid=a.id where a.name="harrison ford";


#11-HArrison Fold'Un başrol oynadigi filmlerin isimleri nedir?
select name, title from movie m join cast c on m.id=c.movieid join actor a on a.id=c.actorid 
where a.name="harrison ford" and c.ord="1";


#Her filmin adi, yili ve oyuncu sayisi nedir?
select title, year, count(c.actorid) as oyuncu_sayisi from movie m join cast c on m.id=movieid  
group by year, title;


#star wars serisinin film adi yili ve basrol oyuncusu kimdir?
select title, year, name from movie m join cast c on m.id=c.movieid join actor a on a.id=c.actorid 
where m.title like "%star wars%" and c.ord="1";

# en yuksek score a sahip filmin oyunculari kimlerdir?
select title, name from movie m  join cast c on m.id=c.movieid join actor a on a.id=c.actorid 
where m.score=(select max(score) from movie);

#beyaz esya verisi 7-10 arasi
#her ulkenin kac markasi vardir?
select ulke, count(marka) from markalar group by ulke;

#her turun fiyat ortalamasi nedir?
select avg(fiyati) from beyazesya b join turler t on t.turkodu=b.turkodu group by t.turadi;

#7- her turun en pahali ve en ucuz urunlerinin fiyati nedir?
select turadi , min(fiyati), max(fiyati) from turler t join beyazesya b 
on t.turkodu=b.turkodu 
group by turadi;

#8- Her markanin en ucuz ve en pahali urunlerinin fiyati nedir?
select marka, min(fiyati), max(fiyati) from markalar m join beyazesya b on m.markakodu=b.markakodu 
group by marka;

#9- Her markanin her turunun fiyat ortalamasi?
select marka,turadi, avg(fiyati) FROM turler t join beyazesya b on t.turkodu=b.turkodu 
join markalar m on b.markakodu=m.markakodu group by m.marka,t.turadi;

# beko marka urunlerin fiyat ortalamasi nedir?
select avg(fiyati) from beyazesya b join markalar m on b.markakodu=m.markakodu where m.marka="beko";


#10- Her turun her markasinin fiyat ortalamasi nedir?
select marka, turadi, avg(fiyati) from beyazesya b join markalar m on b.markakodu=m.markakodu
 join turler t on t.turkodu=b.turkodu group by t.turadi,m.marka;











