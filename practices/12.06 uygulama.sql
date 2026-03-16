
#2. soru 
select ogrno, count(derskodu) as aldigi_ders from notlar group by ogrno;

#3. soru her bolumdeki ogrenci sayisini ve bolum adini listeleyiniz
select bolumadi, count(*) as ogrenci_sayisi from ogrenci o join bolum b on o.bolumno=b.bolumno
group by b.bolumno; 


#4: her ogrencinin adi soyadi ve aldigi en yuksek final notunu bulunuz
select max(final) , ad, soyad from ogrenci o join notlar n on o.ogrno=n.ogrno group by o.ogrno;

#4. soru icin degistirip alistirma
select final , ad, soyad from ogrenci o join notlar n on o.ogrno=n.ogrno order by final asc;


#5: psikoloji bolumundeki tum ogrencilerin ad ve soyadini listeyiniz
select ad, soyad, bolumadi from ogrenci o join bolum b on b.bolumno=o.bolumno where bolumadi="psikoloji";

#6: ortalama final notu 80 ustunde olan ogrencilerin ad, soyad ve bolum bilgilerini yaziniz
select ad, soyad, bolumadi from ogrenci o join bolum b on o.bolumno=b.bolumno join 
notlar n on o.ogrno=n.ogrno group by o.ogrno having avg(final)>80;


#7: soyadi a ile baslayan kiz ogrencilerin aldigi dersleri ve final notlarini listeleyiniz
select ad, soyad, o.ogrno,cinsiyet, dersadi, final from notlar n join ders d on n.derskodu=d.derskodu 
join ogrenci o on o.ogrno=n.ogrno where cinsiyet="k" and o.soyad like ("a%");

#8: her ogrencinin aldigi dersleri ve donum sonu notlari listeleyiniz(donem_sonu_not= vize*0.4+final*0.6)
select n.ogrno,dersadi, vize*0.4+final*0.6 as donem_sonu_notu from notlar n join ders d
 on n.derskodu=n.derskodu;
 #ceil yukari yuvarlar floor asagi round da virgulden sonra
select n.ogrno,dersadi, ceil(vize*0.4+final*0.6) as donem_sonu_notu from notlar n join ders d 
on n.derskodu=n.derskodu; 

#9: donem sonu notu 60 uzeri olan kisileri ve aldigi dersleri listeleyiniz
select  ad, soyad,dersadi,vize*0.4+final*0.6 as donem_sonu_notu from ogrenci o join notlar n on 
o.ogrno=n.ogrno join ders d on n.derskodu=n.derskodu where (vize*0.4+final*0.6)>60;

#10: en cok dersten basarili olan (donem sonu 60 ve uzeri) ogrencilerin adini, soyadini ve gectigi ders sayisini listeleyiniz
select ad, soyad, count(*) as gectigi_ders_sayisi from ogrenci o join notlar n on 
o.ogrno=n.ogrno
where(vize*0.4+final*0.6)>60 group by o.ogrno order by count(*) desc;

#11: en yuksek final notuna sahip ogrenciyi ders adi ve bolum bilgisiyle birlikte gosteriniz
select o.ogrno, dersadi, bolumadi from ogrenci o join notlar n on o.ogrno=n.ogrno 
join ders d on d.derskodu=n.derskodu join bolum b on b.bolumno=o.bolumno 
where final= (select max(final) from notlar);

#12: her dersin kac ogrenci tarafindan alindigini ve o derse ait ortalama vize ve final 
#notlarini hesaplayiniz
select dersadi, count(*) as ogr_sayisi, avg(vize) as ort_vize, avg(final) as ort_final 
from notlar n join ders d on n.derskodu=d.derskodu group by n.derskodu;   

#13 te bolum ve notların ortak primary olmadigi icin ogrenciyi de katmak zorundayiz
#bu soru finalde gelmez ogrencileri birden cok kez saymasin diye count icine distinct yazdik
#13:ortalama final notu 70 in altinda olan bolumleri ve bu bolumlerdeki ogrenci sayisini gosteriniz
select bolumadi, count(distinct(n.ogrno)) from notlar n join ogrenci o on n.ogrno=o.ogrno join 
bolum b on 
b.bolumno=o.bolumno group by o.bolumno having avg(final)<70 ;

#kontrol
select count(*) from ogrenci;











