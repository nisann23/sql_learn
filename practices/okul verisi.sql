drop schema if exists Okul;
create schema Okul ;
Use Okul;


CREATE TABLE Bolum (
    BolumNo INT PRIMARY KEY,
    BolumAdi VARCHAR(50)
);


CREATE TABLE Ogrenci (
	BolumNo INT,
    OgrenciNo INT PRIMARY KEY,
    OgrenciAdi VARCHAR(50)
);


-- Departman verileri
INSERT INTO Bolum (BolumNo, BolumAdi) VALUES
(1, 'İstatistik'),
(2, 'Bilgisayar Bilimleri'),
(3, 'Matematik'),
(4, 'Fizik'),
(5, 'Kimya'),
(6, 'Biyoloji');



-- Ogrenci Verileri
INSERT INTO Ogrenci (BolumNo, OgrenciNo, OgrenciAdi) VALUES
(1, 125123, 'Ali Veli' ),
(1, 51511, 'Ayşe Fatma'),
(1, 516723, 'Hasan Hüseyin'),
(2, 997831, 'Ahmet Mehmet' ),
(2, 99816, 'Leyla Nejla' ),
(3, 997832, 'Murat Fırat' ),
(4, 51245, 'Jale Lale' ),
(15, 8812, 'Osman Orhan' )
;



