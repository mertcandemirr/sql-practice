create table bolum (
id Serial primary key ,
ad varchar(50) not null 
);

CREATE TABLE ogrenci (
    identify SERIAL PRIMARY KEY,
    ad VARCHAR(50),
    not_ort NUMERIC(4,2)
);

CREATE TABLE ders (
    identify SERIAL PRIMARY KEY,
    ad VARCHAR(100) not null ,
	kredi int,
	bolum_id INT references bolum(id)
    );

CREATE TABLE kayit (
    ogrenci_id INT REFERENCES ogrenci(identify) ON DELETE CASCADE,
    ders_id INT REFERENCES ders(identify) ON DELETE CASCADE,
    notu INT,
    donem VARCHAR(25),
    PRIMARY KEY (ogrenci_id, ders_id)
);

--veri ekleme
-- 1. BÖLÜM VERİLERİ
INSERT INTO bolum (id, ad) VALUES
(1, 'Şanssızlık Mühendisliği'),
(2, 'Dedikodu Bilimleri ve Stratejik Fısıltı'),
(3, 'Uykusuzluk ve Gece 3 Mesajları Anabilim Dalı'),
(4, 'Fast Food Felsefesi ve Ketçap Yönetimi');

-- 2. ÖĞRENCİ VERİLERİ
INSERT INTO ogrenci (ad, not_ort) VALUES
('Zıpırcan', 68.30),
('Cırcırböceği Cemal', 42.10),
('Pırtlayan Pınar', 12.50),
('Makyajlı Muhtar', 88.90),
('Çorapsız Çetin', 50.00),
('Tostçu Tayfun', 31.80),
('Biberli Bedriye', 74.20),
('Hapşıran Hikmet', 61.70);

-- 3. DERS VERİLERİ
INSERT INTO ders (ad, kredi, bolum_id) VALUES
('Kopya Çekme Teknikleri 101', 4, 1),
('Açık Unutulan Muslukları Kapatma Sanatı', 3, 1),
('Yan Masadakinin Konuşmasını Dinleme ve Raporlama', 5, 2),
('Sabah 8.00 Dersine Gidiyormuş Gibi Görünme', 2, 3),
('Ketçap ve Mayonez Dökülme Risk Analizi', 4, 4),
('Sosyal Medyada Eski Sevgilinin Profilini İnceleme', 3, 2);

-- 4. KAYIT (NOT VE DÖNEM) VERİLERİ
INSERT INTO kayit (ogrenci_id, ders_id, notu, donem) VALUES
(1, 1, 45, '2025-Güz'),

(1, 2, 70, '2025-Güz'),

(2, 3, 90, '2025-Güz'),

(3, 4, 15, '2026-Bahar'),

(4, 5, 88, '2026-Bahar'),

(5, 1, 50, '2025-Güz'),

(6, 5, 30, '2026-Bahar'),

(7, 6, 95, '2026-Bahar'),

(8, 2, 62, '2025-Güz');


select ad , not_ort
from ogrenci 
where not_ort >(select avg(not_ort )from ogrenci )
order by not_ort desc;


SELECT
    o.ad,
    COUNT(k.ders_id) AS ders_sayisi
FROM ogrenci o
JOIN kayit k ON o.identify = k.ogrenci_id
GROUP BY o.identify, o.ad
ORDER BY ders_sayisi DESC;

--harf notu öğrenme if else case aend
select o.ad,
	case 
		when avg(k.notu)>= 90 then 'AA'
		when avg(k.notu)>= 80 then 'BB'
		when avg(k.notu)>= 70 then 'CC'
		else 'ff'
end as harf_notu

from ogrenci o
join kayit k on o.identify =k.ogrenci_id
group by o.identify,o.ad;

--her öğrencinin derslerde kaçıncı geldiğini göster

SELECT
    o.ad,
    d.ad AS ders,
    k.notu,
    ROW_NUMBER() OVER (
        PARTITION BY k.ders_id
        ORDER BY k.notu DESC
    ) AS siralama
FROM ogrenci o
JOIN kayit k ON o.identify = k.ogrenci_id
JOIN ders d ON k.ders_id = d.identify;

WITH ogrenci_ort AS (
    SELECT
        o.identify,
        o.ad,
        AVG(k.notu) AS ort
    FROM ogrenci o
    JOIN kayit k ON o.identify = k.ogrenci_id
    GROUP BY o.identify, o.ad
)
SELECT *
FROM ogrenci_ort
WHERE ort > 60
ORDER BY ort DESC;