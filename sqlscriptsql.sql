-- Tablo oluşturma
CREATE TABLE  ogrenciler(
	id Integer Primary KEY AUTOINCREMENT,
	ad text not null,
	yas integer CHECK (yas>14),
	sehir text default 'İstanbul',
	kayit TEXT DEFAULT CURRENT_TIMESTAMP );

-- veri ekleme
insert into ogrenciler (ad,yas) Values ("Zıpırcan",28);
insert into ogrenciler (ad,yas) values ("Tripcan", 24);
insert into ogrenciler (ad,yas,sehir) VALUES ("yurdagül",23,"Gümüşhane"),("Zeynep", 19, "Ankara")

-- Güncelleme ve silme 

update ogrenciler  SET yas = 21 WHERE ad ="Zeynep";
DELETE FROM ogrenciler WHERE  id=2;

-- db deki verileri görmek için
SELECT * from ogrenciler ;
SELECT ad ,yas From ogrenciler o  WHERE o.yas > 20 order by o.yas DESC LIMIT  3;
Select * from ogrenciler where ad Like 'Z%';


--yeni sütün ekleme
alter TABLE ogrenciler ADD eposta Text;

c

--Tabloyu tamamaen silme
DROP Table if Exists ogrenciler  ;


-----------------------------------------------------------------------------

Create Table hayvanlar ( 
	id Integer PRIMARY Key Autoincrement ,
	isim text not null,
	tur text ,
	yas Integer CHECK(yas>0),
	renk Text DEFAULT "Kahverengi"
	
);


-- verileri görmek için
select * FROM hayvanlar ;


INSERT INTO hayvanlar (isim, tur, yas, renk) VALUES
('Pamuk', 'kedi', 3, 'beyaz'),
('Duman', 'kedi', 4, 'gri'),
('Zeytin', 'köpek', 2, 'siyah'),
('Boncuk', 'kuş', 2, 'mavi'),
('Fıstık', 'kuş', 1, 'yeşil'),
('Şanslı', 'köpek', 6, 'kahverengi'),
('Gölge', 'kedi', 5, 'siyah'),
('Mercan', 'balık', 1, 'kırmızı'),
('Bulut', 'köpek', 3, 'beyaz'),
('Ateş', 'kedi', 2, 'turuncu'),
('Çikolata', 'köpek', 4, 'kahverengi'),
('Limon', 'kuş', 1, 'sarı'),
('Kömür', 'kedi', 3, 'siyah'),
('Sakız', 'tavşan', 1, 'beyaz'),
('Gümüş', 'balık', 2, 'gri'),
('Coşku', 'kuş', 3, 'yeşil'),
('Poyraz', 'köpek', 7, 'gri'),
('Fındık', 'sincap', 2, 'kahverengi'),
('Ceviz', 'köpek', 4, 'kahverengi'),
('Gece', 'kedi', 1, 'siyah');



select isim ,yas FROM hayvanlar WHERE yas >=5;
SELECT * from hayvanlar order by yas DESC  LIMIT 2;

SELECT * 
FROM hayvanlar 
WHERE yas BETWEEN 5 AND 7;

update hayvanlar set yas =8 WHERE isim  = "Poyraz";

DELETE FROM hayvanlar where isim ="Boncuk";

select * from hayvanlar ;

ALTER table hayvanlar add column sevdigi_yemek text;

update hayvanlar set sevdigi_yemek = "havuç" where isim = "Sakız";


DROP Table if Exists hayvanlar   ;


----------------------------------------------------------------------------------------

SELECT * from oyuncak ;

Create Table oyuncak  ( 
	id Integer PRIMARY Key Autoincrement ,
	isim text not null,
	cesit text ,
	fiyat Integer CHECK(fiyat >0),
	renk Text DEFAULT "Kırmızı"
	);

INSERT INTO oyuncak (isim , cesit , fiyat) VALUES ("Şimşek" , "Araba" , 50);

--Toplu ekleme
insert into oyuncak (isim , cesit ,fiyat , renk) VALUES 
("Ayıcık", "Peluş", 80, "Kahverengi"),
("Kale Seti", "Lego", 150, "Gri"),
("Zıpzıp", "Top", 20, "Sarı"),
("Barbi", "Bebek", 90, "Pembe");

--80 tl üstü oyuncaklar isim ve fiyat
select isim , fiyat from oyuncak where fiyat>80;

--en pahalı 2 oyuncak
select * FROM oyuncak ORDER by fiyat DESC Limit 2;

--ismi Z harfi ile başlayan
select * from oyuncak where isim like "Z%";

--sadece araba ve topları
SELECT * FROM oyuncak WHERE cesit IN ('Araba', 'Top');

--fiyat 20- 60
SELECT * FROM oyuncak WHERE 20<fiyat<60;

--şimşek mavi
UPDATE oyuncak set renk = "Mavi" WHERE id =1;

--zıpzıp kutudan sil
delete from oyuncak WHERE isim ="Zıpzıp";

--tabloya yeni sütün ekleme
ALTER TABLE oyuncak ADD kimin text;

--kaleseti sahibi ali
update oyuncak set kimin = "Ali" where isim ="Kale Seti";

--cesit sütünün adını tur
alter TABLE oyuncak  RENAME COLUMN cesit to tur;

DROP Table if Exists oyuncak   ;

----------------------------------------------------------

-- FOREIGN key kapalı defaultta açmak için

PRAGMA foreign_keys = ON;

CREATE TABLE ogrenciler(
id INTEGER PRIMARY KEY AUTOINCREMENT,
ad  TEXT NOT NULL,
yas INTEGER CHECK (yas > 13),
sehir TEXT DEFAULT 'Erzincan',
kayit TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dersler(
id INTEGER PRIMARY KEY,
ad TEXT UNIQUE NOT NULL
);

CREATE TABLE notlar (
ogrenci_id  INTEGER REFERENCES ogrenciler(id) ON DELETE CASCADE,
ders_id INTEGER REFERENCES dersler(id),
puan   REAL,
PRIMARY KEY (ogrenci_id, ders_id)
);

--------join işlemleri
SELECT 
















