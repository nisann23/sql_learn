#20 mayıs dersi her markanin kac urunu var sorusu,
select marka, count(urunno) as adet
from beyazesya b,  markalar m
where b.markakodu = m.markakodu
group by marka;

#join
#az onceki srou join ile
select marka, count(urunno) as adet from markalar m 
inner join beyazesya b on b.markakodu= m.markakodu
group by marka;

#outer join
select marka, count(urunno) as adet from markalar m 
left outer join beyazesya b on b.markakodu= m.markakodu
group by marka;
#table A markalar oluyor esas olan

#okul verisine geciyoruz
#tum ogrencilerin bolumleri where ile
select ogrenciadi, bolumadi
from ogrenci, bolum 
where ogrenci.bolumno= bolum.bolumno;

#inner join ile yapma
select ogrenciadi, bolumadi from ogrenci
inner join bolum on ogrenci.bolumno=bolum.bolumno;

#outer join ile yapinca kesisim olalacak bir de sadece ogrenci kismi olacak yani 15 te gelecek
select ogrenciadi, bolumadi from ogrenci
left outer join bolum on ogrenci.bolumno=bolum.bolumno;

#right join ile yapimi
select ogrenciadi, bolumadi from ogrenci
right outer join bolum on ogrenci.bolumno= bolum.bolumno;
#ogrenciadi 2 tane null geldi 5,6 yoktu ya onlar hatirla (midem yaniyo açma isirma diyettesin)

#natural join
select ogrenciadi, bolumadi from ogrenci natural join bolum;

select bolumno from bolum
intersect
select bolumno from ogrenci;
#tablo geldi ama hata veriyor sorun yok 1 2 3 4 diye vermeli

select bolumno from bolum
except
select bolumno from ogrenci;
#yine hata veriyor 5 6 veriyor

select bolumno from bolum
union
select bolumno from ogrenci;
#her deger birer tane geldi

select bolumno from bolum
union all
select bolumno from ogrenci;




