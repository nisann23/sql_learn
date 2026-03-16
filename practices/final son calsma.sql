#FİNAL SON ÇALIŞMA
#Tüm öğrencilerin ad, soyad ve bağlı oldukları bölüm adını listeleyin.
select bolumadi, ad, soyad from ogrenci o join bolum b on o.bolumno=b.bolumno;

#"Bilgisayar Mühendisliği" bölümünde okuyan öğrencilerin numara, ad ve soyad bilgilerini listeleyin.
select ogrno, ad, soyad from ogrenci o join bolum b on o.bolumno=b.bolumno where 
bolumadi="Bilgisayar Mühendisliği";

#Her bölümde kaç öğrenci olduğunu listeleyin.
select count(ogrno), bolumadi from ogrenci o join bolum b on o.bolumno=b.bolumno 
group by bolumadi;

#Her öğrencinin genel ortalamasını (vize %40 + final %60) hesaplayın ve ogrno, ad, soyad ile 
#birlikte gösterin.
select o.ogrno, ad, soyad, vize*0.4+final*0.6 as not_ortalamasi from ogrenci o join 
notlar n on o.ogrno=n.ogrno;

#Final notu 80'den büyük olan öğrencilerin ad, soyad, ders adı ve final notunu listeleyin.
select ad, soyad,final from ogrenci o join notlar n on o.ogrno=n.ogrno where final>80;

#En az bir dersten kalan (ortalaması 50'nin altında olan) öğrencilerin bilgilerini listeleyin.
select o.ogrno, ad, soyad, vize*0.4+final*0.6 as ortalamasi from ogrenci o join notlar n 
on o.ogrno=n.ogrno where (vize*0.4+final*0.6)<50;

#Her ders için başarı ortalamasını (ortalama not) listeleyin.
select dersadi, avg(vize*0.4+final*0.6) as ortalama from notlar n join ders d 
on n.derskodu=d.derskodu group by dersadi;

#"Veritabanı" dersini alan öğrencilerin ad, soyad ve ders notlarını listeleyin.
select ad, soyad, vize, final from ogrenci o join notlar n on o.ogrno=n.ogrno join ders d 
on d.derskodu=n.derskodu where dersadi="Veritabanı";


#Her öğrencinin aldığı toplam kredi miktarını listeleyin.
select o.ogrno, sum(kredisi) from ogrenci o join notlar n on o.ogrno=n.ogrno join ders d 
on n.derskodu=d.derskodu group by o.ogrno;


#Tüm dersleri alan öğrencilerin ad, soyad ve kaç dersten not aldıklarını listeleyin.
select ad, soyad, count(derskodu) from ogrenci o join notlar n on o.ogrno=n.ogrno join ders 
on n.derskodu=d.derskodu;

#2.set

# Tüm öğrencilerin ad, soyad ve aldıkları ders sayısını listeleyiniz.
select ad, soyad, count(derskodu) from ogrenci o join notlar n on o.ogrno=n.ogrno join ders 
on n.derskodu=d.derskodu;


# Final notu 50 ile 80 arasında olan öğrencilerin adını, soyadını ve ders adını listeleyiniz.
select ad, soyad, dersadi from ogrenci o join notlar n on o.ogrno=n.ogrno join ders d
 on d.derskodu=n.derskodu where final>50 and final<80;

# “Matematik” dersini alan öğrencilerin vize ve final notlarının ortalamasını bulunuz.
select avg(vize), avg(final) from notlar n join ders d on n.derskodu=d.derskodu where 
dersadi="Matematik_1";


# En az bir dersten vizesi 30’un altında olan öğrencilerin adı, soyadı ve ders adını listeleyiniz.
select ad, soyad,vize, dersadi from ogrenci o join notlar n on o.ogrno=n.ogrno 
join ders d on n.derskodu=d.derskodu where vize<=30;

# Her bölümdeki öğrencilerin aldığı toplam kredi miktarını ve bölüm adını listeleyiniz.
select sum(kredisi), bolumadi from ders d join notlar n on d.derskodu=n.derskodu
 join ogrenci o on n.ogrno=o.ogrno join bolum b on o.bolumno=b.bolumno group by bolumadi;

# Cinsiyeti “e” olan ve soyadı “z” harfiyle biten öğrencilerin aldığı dersleri ve dönem 
#sonu notlarını listeleyiniz.
select dersadi,ad,soyad, final from ders d join notlar n on d.derskodu=n.derskodu join ogrenci o
 on o.ogrno=n.ogrno where cinsiyet="e" and soyad like("a%");


# Final notu 90’ın üstünde olan öğrencilerden, en yüksek dönem sonu notuna sahip olan 
#öğrencinin adı, soyadı ve ders adını gösteriniz.
select ad, soyad, dersadi, vize*0.4+final*0.6 as donem_notu from ogrenci o join notlar n on
 o.ogrno=n.ogrno join ders d on n.derskodu=d.derskodu where final>90 order by 
 vize*0.4+final*0.6 desc limit 1;


# !!!!!!!!!!Her öğrencinin aldığı derslerden en düşük vize notunu ve ilgili dersin adını listeleyiniz.
select dersadi, vize  from ders d join notlar n on d.derskodu=n.derskodu where vize=(select min(vize)
from notlar );

# !!!!!!!“Psikoloji” bölümündeki öğrencilerin aldığı derslerin adını ve ortalama final notlarını 
#(sadece bu bölüm özelinde) listeleyiniz.
select dersadi, avg(final) from notlar n join ders d on d.derskodu=n.derskodu join
 ogrenci o on o.ogrno=n.ogrno join bolum b on o.bolumno=b.bolumno where bolumadi="Psikoloji"
 group by dersadi;

# Hiçbir dersten geçemeyen (bütün dönem sonu notları 50’nin altında olan) öğrencilerin 
#ad ve soyadlarını listeleyiniz.
select ad,soyad, avg(vize*0.4+final*0.6) as donem_sonu_notu from ogrenci o join notlar n
on o.ogrno=n.ogrno group by o.ogrno,ad,soyad having avg(vize*0.4+final*0.6) <50;

#burda avg kullanmamızın sebebi group by da birden fazla şeyle grupladıgın için having içine
#avg min mac gibi aggrate mi ne onlardan kullanman gerekiyor ve avg olarak kullandığın içim
#başta da avg olarak secmen gerekiyor



#HOCANIN 12.06 ÇÖZDÜRDÜKLERİ
#1. tum ogrencilerin ad,soyad ve cinsiyet bilgilerini giriniz
select ad,soyad, cinsiyet from ogrenci;

#2. her ogrencinin kac farklı derse girdiğini listeleyiniz
select count(derskodu), ogrno from notlar group by ogrno;



#3. soru her bolumdeki ogrenci sayisini ve bolum adini listeleyiniz
select count(*), bolumadi from ogrenci o join bolum b on o.bolumno=b.bolumno group by bolumadi;



#4: her ogrencinin adi soyadi ve aldigi en yuksek final notunu bulunuz
select max(final),ad, soyad from ogrenci o join notlar n on o.ogrno=n.ogrno group by o.ogrno;

#4. soru icin degistirip alistirma
select final , ad, soyad from ogrenci o join notlar n on o.ogrno=n.ogrno order by final asc;




#5: psikoloji bolumundeki tum ogrencilerin ad ve soyadini listeyiniz
select ad,soyad,bolumadi from ogrenci o join bolum b on o.bolumno=b.bolumno where 
bolumadi="Psikoloji";



#6: ortalama final notu 80 ustunde olan ogrencilerin ad, soyad ve bolum bilgilerini yaziniz
select ad, soyad, bolumadi from ogrenci o join bolum b on o.bolumno=b.bolumno join notlar n 
on o.ogrno=n.ogrno group by o.ogrno having avg(final)>80;



#7: soyadi a ile baslayan kiz ogrencilerin aldigi dersleri ve final notlarini listeleyiniz
select dersadi, final ,soyad from ogrenci o join notlar n on o.ogrno=n.ogrno join ders d
on n.derskodu=d.derskodu where cinsiyet="k" and soyad like("a%");



#8: her ogrencinin aldigi dersleri ve donum sonu notlari listeleyiniz
#(donem_sonu_not= vize*0.4+final*0.6)
select n.ogrno,dersadi, vize*0.4+final*0.6 as donem_sonu_notu from notlar n join ders d
 on n.derskodu=n.derskodu;
 #ceil yukari yuvarlar floor asagi round da virgulden sonra
select n.ogrno,dersadi, ceil(vize*0.4+final*0.6) as donem_sonu_notu from notlar n join ders d 
on n.derskodu=n.derskodu; 




#9: donem sonu notu 60 uzeri olan kisileri ve aldigi dersleri listeleyiniz
select ad,soyad, dersadi from ogrenci o join notlar n on o.ogrno=n.ogrno join ders d on
n.derskodu=d.derskodu where (vize*0.4+final*0.6)>60;



#10: en cok dersten basarili olan (donem sonu 60 ve uzeri) ogrencilerin adini, soyadini ve
# gectigi ders sayisini listeleyiniz
select ad, soyad, count(*) as gecilen from ogrenci o join notlar n on o.ogrno=n.ogrno
 where (vize*0.4+final*0.6)>=60 group by o.ogrno;

#en çok dersten gecen ogrenci
select o.ad, o.soyad, count(*) as gecilen from ogrenci o join notlar n on o.ogrno=n.ogrno join ders d on 
n.derskodu=d.derskodu where vize*0.4+final*0.6>=60 group by o.ogrno  order by gecilen desc limit 1;


#11: en yuksek final notuna sahip ogrenciyi ders adi ve bolum bilgisiyle birlikte gosteriniz
select ad,soyad, dersadi, bolumadi from ogrenci o join notlar n on o.ogrno=n.ogrno join bolum
 b on o.bolumno=b.bolumno join 
ders d on n.derskodu=d.derskodu where final= (select max(final) from notlar);



#12: her dersin kac ogrenci tarafindan alindigini ve o derse ait ortalama vize ve final 
#notlarini hesaplayiniz
select count(*), dersadi, avg(vize), avg(final) from ogrenci o join notlar n on 
o.ogrno=n.ogrno join ders d on n.derskodu=d.derskodu group by dersadi;

#yukarı yuvarlamasi
SELECT 
  dersadi, 
  COUNT(*) AS ogrenci_sayisi, 
  CEIL(AVG(vize)) AS ort_vize, 
  CEIL(AVG(final)) AS ort_final
FROM ogrenci o 
JOIN notlar n ON o.ogrno = n.ogrno 
JOIN ders d ON n.derskodu = d.derskodu 
GROUP BY dersadi;







