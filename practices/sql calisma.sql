#sql calisma (dreamhome)
#Tüm çalışanların isimlerini ve maaşlarını listele.
select fname, salary from employee;

#"London" şehrinde bulunan şubelerin branchNo ve postcode bilgilerini getir.
select branchno, postcode from branch where city='london'; #from tablo adı yazıyoruz 

#employee tablosundaki tüm kadın çalışanların (F) adlarını ve pozisyonlarını listele.
select fname, position from employee where sex="F";

#400'dan düşük kira bedeli olan mülklerin adreslerini ve kiralarını listele.
select street, rent from propertyforrent where rent<400;

#"Assistant" pozisyonundaki çalışanların isimlerini ve doğum tarihlerini sırala.
select fname, dob from employee where position="Assistant";

#Her şubedeki çalışanların ortalama maaşlarını göster.
select branchno,avg(salary) from employee group by branchNo;

#En düşük maaşa sahip 2 çalışanı listele.
select fname, salary from employee order by salary asc limit 2;

#Hangi pozisyon kaç çalışan tarafından yapılmaktadır?
select position, count(*) as calisan_sayisi from employee group by position;

#Her şehre göre mülk sayısını gösteren bir liste oluştur.
select city, count(*) as mulk_sayisi from propertyforrent group by city;

#Hangi şehirde kaç farklı şube vardır? (Şehirlere göre şube sayısını listele.)
select city, count(*) as sube_sayisi from branch group by city;

#En yüksek kiraya sahip mülkün tipi nedir ve kaç odalıdır? (propertyForRent tablosundan)
select type,rooms, rent from propertyforrent order by rent desc limit 1;

#Maaşı 10.000 ile 25.000 arasında olan çalışanların adlarını ve maaşlarını listele.
select fname, salary from employee where salary>10000 and salary<25000;

#"Flat" türünde olan mülklerden kiraları 400'ün üzerinde olanların adres ve kira bilgilerini sırala.
select street, rent from propertyforrent where type='flat' and rent>400;

#Her pozisyonda kaç çalışan olduğunu göster. (Yani pozisyona göre çalışan sayısı)
select position, count(*) from employee group by position;

#Kiraya verilen mülkler arasında en fazla odası olan mülkün adresi nedir?
select street, rooms from propertyforrent order by rooms desc limit 1;
#daha pro yapilisi
select street, city, rooms from propertyforrent where rooms = (select max(rooms) from propertyforrent);
#Aynı şehirde birden fazla şubesi bulunan şehirleri listele. (Yani branch tablosunda aynı şehirden birden fazla varsa)
select city, count(*) from branch group by city;

#Doğum yılı 1980'den sonra olan çalışanların adlarını ve doğum tarihlerini listele.
select fname, dob from employee where dob>1980;

#Kira bedeli 400 ile 600 arasında olan mülkleri artan sırada listele.
select rent, propertyno from propertyforrent where rent>=400 and rent<=600 ;

#Maaşı 20.000'den fazla olan çalışanları maaşa göre azalan şekilde sirala.
select salary from employee where salary>20000 order by salary desc;

#Aynı şehirde birden fazla şubesi bulunan şehirleri listele. (Yani branch tablosunda aynı şehirden birden fazla varsa)
select city, count(*) from branch group by city having count(*)>1;

#Her şubedeki toplam maaş 30.000'den fazla olan şubeleri listele.
select branchno, sum(salary) from employee group by branchNo having sum(salary)>30000;

#Her pozisyonda en az 2 çalışan varsa, o pozisyonları ve sayısını listele.
select position, count(*) from employee group by position having count(*)>=2;

#Her pozisyonda en az 2 çalışan varsa, o pozisyonları ve sayısını listele, kucukten buyuge.
select position, count(*) from employee group by position having count(*)>=2 order by position desc;


# Tüm kadın çalışanların (F) adlarını ve maaşlarını listele.
select salary,fname from employee where sex='F';

# Maaşı 15.000’den yüksek olan çalışanların soyadlarını ve şube numaralarını sırala.
select lname, branchno from employee where salary>15000;


# Her şubede çalışan erkek ve kadınların ortalama maaşlarını ayrı ayrı göster.
select branchno,avg(salary) as ort_maas,sex from employee group by branchNo , sex;

# En düşük maaşlı erkek çalışanın adını ve maaşını getir.
select fname, salary from employee where sex='M'order by salary asc limit 1;


# !!!!!! (güzel soru) Her pozisyondaki ortalama maaş, genel ortalamadan yüksekse, 
#o pozisyonları ve ortalamalarını listele.
select position, avg(salary) as ort_maas from employee group by position having 
avg(salary)> (select avg(salary) from employee);

#!!!!!! Maaşı, kendi şubesindeki ortalama maaşın üzerinde olan çalışanların adlarını ve maaşlarını listele.
SELECT fname, salary, branchno FROM employee WHERE salary > (SELECT AVG(salary)FROM employee 
WHERE branchno = employee.branchno);

#Her pozisyonun ortalama maaşını hesapla. Ortalama maaşı 15.000’in üzerinde olan pozisyonları 
#ve ortalama maaşlarını büyükten küçüğe sırala
select position, avg(salary) from employee group by position having avg(salary)>15000 
order by avg(salary) desc;

#kendi şubesindeki ortalama maaştan daha fazla maaş alan çalışanların adını, maaşını ve şube numarasını listele
select branchno, fname, salary from employee e where salary>(Select avg(salary) from employee where branchno=e.branchNo); 
# yukarıda Eğer bunu yapmazsak (yani where branchno = e.branchno olmasa), iç sorgu tüm şirketin ortalama maaşını hesaplar (bizim istediğimiz kendi subesindeki ortalama) ve karşılaştırma yanlış olur

#Her şubedeki en yüksek maaşa sahip çalışanların adını, maaşını ve şube numarasını listele.
select branchno,fname, salary from employee e where salary=(Select max(salary) from employee where branchno= e.branchno); #en son kisim calisanin bagli oldugu sube gibi dusunebilirsin)




#baska bir gün
#Çalışan tablosundan sadece ilk 3 çalışanı listele.
select * from employee limit 3;

#En yüksek maaş alan çalışanı listele.
select fname, salary from employee order by salary desc limit 1;

#Her şubedeki toplam maaş tutarını listele.
select sum(salary), branchno from employee group by branchno;

#Her pozisyonun ortalama maaşını bul.
select position,avg(salary) from employee group by position;

#Cinsiyet ve şube bazında ortalama maaşları listele.
select sex, branchno,avg(salary) from employee group by sex, branchno;

#Şubelere göre çalışan sayısını say ve azdan çoğa doğru sırala.
select branchno,count(staffno) from employee group by branchno order by count(staffno);

#Sadece B003 ve B005 şubelerinde çalışan personel sayısını bul.
select branchno, count(staffno) from employee where branchno in ("B003", "B005") group by branchno;

#Toplam maaş ödemesi 30.000 TL’den fazla olan şubeleri listele.
select sum(salary), branchno from employee group by branchno having sum(salary)>30000;

#Hangi şubede kaç çalışan olduğunu ve toplam maaşlarını görmek istiyorsun. 
#Bu bilgileri hem toplam sayıya göre hem de toplam maaşa göre sıralayacak iki ayrı sorgu yaz.
select count(staffno),sum(salary),branchno from employee group by branchno order by count(staffno), sum(salary); 

#Şube ve cinsiyete göre gruplandırarak, her grubun ortalama maaşını hesapla. 
#Bu grupların ortalama maaşı genel ortalamanın üstünde olanlarını seç.
select avg(salary),branchno, sex from employee group by sex, branchno  having avg(salary)>(select avg(salary) from employee);
#group by dan sonra iç sorgu (sunquery) olduğu için having kullandik










