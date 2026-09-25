-- ================================================================
--  GO-TANI — SQL Editor: Complete Database Setup
--  Jalankan di: Supabase Dashboard → SQL Editor
--  (Catatan: Artikel dikelola langsung via Blogger Native Feed)
-- ================================================================

-- Bersihkan tabel lama jika ada
DROP TABLE IF EXISTS blog_posts CASCADE;
DROP TABLE IF EXISTS layanan CASCADE;
DROP TABLE IF EXISTS layanan_fitur CASCADE;

-- ================================================================
-- LANGKAH 1: BUAT TABEL UTAMA (bibit_tanaman & pesan_kontak)
-- ================================================================

CREATE TABLE IF NOT EXISTS bibit_tanaman (
  id              BIGSERIAL        PRIMARY KEY,
  nama_bibit      TEXT             NOT NULL,
  kategori        TEXT             NOT NULL
                    CHECK (kategori IN ('Cabai & Tomat', 'Sayuran Daun', 'Buah & Melon', 'Padi & Palawija', 'Perkebunan & Rempah', 'Lainnya', 'Sayur', 'Buah', 'Palawija', 'Rempah')),
  deskripsi       TEXT,
  cara_tanam      TEXT,
  musim_tanam     TEXT,
  masa_panen      TEXT,
  gambar_url      TEXT,
  harga_estimasi  NUMERIC(12,0)    DEFAULT 0,
  stok            BOOLEAN          DEFAULT TRUE,
  created_at      TIMESTAMPTZ      DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS pesan_kontak (
  id          BIGSERIAL     PRIMARY KEY,
  nama        TEXT          NOT NULL,
  email       TEXT          NOT NULL,
  pesan       TEXT          NOT NULL,
  is_read     BOOLEAN       DEFAULT FALSE,
  created_at  TIMESTAMPTZ   DEFAULT NOW()
);

-- ================================================================
-- LANGKAH 2: AKTIFKAN RLS (ROW LEVEL SECURITY)
-- ================================================================
ALTER TABLE bibit_tanaman  ENABLE ROW LEVEL SECURITY;
ALTER TABLE pesan_kontak   ENABLE ROW LEVEL SECURITY;

-- Drop existing policies
DROP POLICY IF EXISTS "publik_read_bibit"    ON bibit_tanaman;
DROP POLICY IF EXISTS "admin_insert_bibit"   ON bibit_tanaman;
DROP POLICY IF EXISTS "admin_update_bibit"   ON bibit_tanaman;
DROP POLICY IF EXISTS "admin_delete_bibit"   ON bibit_tanaman;
DROP POLICY IF EXISTS "admin_read_bibit"     ON bibit_tanaman;
DROP POLICY IF EXISTS "admin_all_bibit"      ON bibit_tanaman;

DROP POLICY IF EXISTS "publik_insert_kontak" ON pesan_kontak;
DROP POLICY IF EXISTS "admin_read_kontak"    ON pesan_kontak;
DROP POLICY IF EXISTS "admin_update_kontak"  ON pesan_kontak;
DROP POLICY IF EXISTS "admin_delete_kontak"  ON pesan_kontak;
DROP POLICY IF EXISTS "admin_all_kontak"     ON pesan_kontak;

-- Bibit Tanaman Policies
CREATE POLICY "publik_read_bibit"    ON bibit_tanaman FOR SELECT TO anon, authenticated USING (TRUE);
CREATE POLICY "admin_all_bibit"      ON bibit_tanaman FOR ALL    TO anon, authenticated USING (TRUE) WITH CHECK (TRUE);

-- Pesan Kontak Policies
CREATE POLICY "publik_insert_kontak" ON pesan_kontak  FOR INSERT TO anon, authenticated WITH CHECK (TRUE);
CREATE POLICY "admin_all_kontak"     ON pesan_kontak  FOR ALL    TO anon, authenticated USING (TRUE) WITH CHECK (TRUE);

-- ================================================================
-- LANGKAH 3: HAPUS DATA LAMA & RESET SEQUENCE
-- ================================================================
TRUNCATE TABLE bibit_tanaman RESTART IDENTITY;


-- ================================================================
-- LANGKAH 4: INSERT SEED DATA 30 BIBIT TANAMAN UNGGUL
-- ================================================================
INSERT INTO bibit_tanaman
  (nama_bibit, kategori, deskripsi, cara_tanam, musim_tanam, masa_panen, gambar_url, harga_estimasi, stok)
VALUES

-- === CABAI & TOMAT (3 bibit) ===
('Cabai Rawit Merah (Capsicum frutescens)', 'Cabai & Tomat',
  'Varietas cabai rawit pedas unggul lokal yang sangat adaptif di dataran rendah hingga tinggi. Tahan terhadap layu bakteri dan antraknosa (patek).',
  'Semai biji 3-4 minggu dalam tray semai, pindah tanam saat tinggi 10-15 cm. Jarak tanam 50×60 cm di bedengan berpupuk kandang matang. Pasang mulsa hitam-perak.',
  'Awal musim kemarau atau akhir musim hujan (April-Juni & September-November)',
  '75-85 hari setelah tanam, panen berkelanjutan 6-8 bulan',
  'https://images.unsplash.com/photo-1588252303782-cb80119abd6d?w=400&h=300&fit=crop',
  15000, TRUE),

('Tomat Servo F1 (Solanum lycopersicum)', 'Cabai & Tomat',
  'Tomat hibrida tipe determinate tahan gemini virus (virus kuning/keriting) dan layu bakteri. Daging tebal, warna merah merata, tahan simpan dan pengangkutan jauh.',
  'Semai benih 3 minggu. Tanam dengan jarak 50×60 cm menggunakan ajir bambu 1,5 meter. Pangkas tunas air bawah untuk memaksimalkan nutrisi ke buah utama.',
  'Musim kemarau (April-Agustus) atau awal musim hujan dengan drainase baik',
  '65-70 hari setelah tanam',
  'https://images.unsplash.com/photo-1592841200221-a6898f307baa?w=400&h=300&fit=crop',
  25000, TRUE),

('Terong Ungu Mustang F1 (Solanum melongena)', 'Cabai & Tomat',
  'Terong ungu hibrida dengan buah lurus panjang 25-30 cm, kulit mengkilap, dan daging empuk manis tidak pahit. Sangat produktif dengan 12-15 buah per tanaman.',
  'Semai 3-4 minggu. Tanam di bedengan dengan jarak 60×70 cm. Beri pupuk NPK seimbang tiap 2 minggu sekali dan pupuk kandang matang sebagai pupuk dasar.',
  'Sepanjang tahun, optimal saat musim peralihan',
  '50-55 hari setelah tanam, panen tiap 3-4 hari',
  'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=400&h=300&fit=crop',
  20000, TRUE),

-- === SAYURAN DAUN (5 bibit) ===
('Bawang Merah Bima Brebes (Allium cepa var. aggregatum)', 'Sayuran Daun',
  'Varietas bawang merah lokal unggulan Brebes, umbi merah cerah, aroma tajam kuat, dan susut bobot rendah saat disimpan. Cocok untuk konsumsi rumah tangga dan industri.',
  'Gunakan umbi bibit berbobot 4-6 gram, potong 1/3 ujungnya sebelum tanam. Tanam dengan jarak 15×20 cm, kedalaman 2/3 umbi tertanam. Siram rutin dan jaga drainase.',
  'Musim kemarau (Mei-Agustus) untuk hasil umbi terbaik dan minim busuk',
  '55-60 hari setelah tanam',
  'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=400&h=300&fit=crop',
  35000, TRUE),

('Kangkung Darat Bangkok LP-1 (Ipomoea aquatica)', 'Sayuran Daun',
  'Kangkung daun sempit tegak, pertumbuhan sangat cepat, batang hijau renyah dan tidak mudah berserat. Favorit petani sayur daun skala komersial dan hidroponik.',
  'Tanam langsung biji di larikan/garitan jarak 15-20 cm atau sistem sebar merata. Siram 2x sehari dan berikan pupuk urea/NPK cair umur 7 dan 14 hari.',
  'Sepanjang tahun (dataran rendah-menengah)',
  '21-25 hari setelah tanam',
  'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&h=300&fit=crop',
  8000, TRUE),

('Bayam Hijau Maestro (Amaranthus tricolor)', 'Sayuran Daun',
  'Bayam cabut daun bulat hijau segar, lambat berbunga, dan tidak mudah rebah saat hujan deras. Tekstur daun lembut cocok untuk sayur bening.',
  'Tabur biji merata di atas bedengan gembur berhumus tipis. Tutup tipis dengan kompos atau sekam. Siram dengan semprotan halus agar biji tidak hanyut.',
  'Sepanjang tahun, butuh sinar matahari penuh',
  '20-25 hari setelah sebar',
  'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&h=300&fit=crop',
  7500, TRUE),

('Sawi Caisim Shinta (Brassica rapa var. parachinensis)', 'Sayuran Daun',
  'Caisim adaptif dataran rendah, daun lebar hijau cerah, tangkai tebal renyah. Toleran terhadap cuaca panas dan tidak mudah berbunga dini.',
  'Semai 2 minggu lalu pindah tanam jarak 20×25 cm, atau tanam langsung dengan penjarangan. Beri pupuk organik cair rutin tiap minggu.',
  'Sepanjang tahun, optimal pada musim kemarau dengan pengairan cukup',
  '25-30 hari setelah tanam',
  'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
  10000, TRUE),

('Buncis Lebat 3 (Phaseolus vulgaris)', 'Sayuran Daun',
  'Buncis tipe merambat dengan polong gilig lurus hijau muda panjang 18-22 cm, lentur tanpa serat, rasa manis renyah. Potensi hasil mencapai 20-25 ton/ha.',
  'Tanam 2 biji per lubang jarak 30×60 cm. Pasang lanjaran bambu setinggi 2 meter saat tanaman berumur 10 hari. Beri pupuk susulan NPK saat mulai berbunga.',
  'Awal musim hujan atau musim kemarau dengan pengairan teratur',
  '45-50 hari setelah tanam, panen bertahap tiap 2-3 hari',
  'https://images.unsplash.com/photo-1567375698348-5d9d5ae99de0?w=400&h=300&fit=crop',
  18000, TRUE),

-- === BUAH & MELON (8 bibit) ===
('Semangka Non-Biji Amara F1 (Citrullus lanatus)', 'Buah & Melon',
  'Semangka hibrida triploid tanpa biji bentuk bulat-oval, kulit hijau gelap lorek hitam, daging merah menyala renyah manis (kadar gula 11-13 Brix), bobot 6-9 kg.',
  'Rendam benih air hangat kuku 6-8 jam, semai di polybag. Tanam jarak 80×300 cm di bedengan mulsa. Butuh tanaman semangka berbiji sebagai polinator.',
  'Musim kemarau (Mei-Agustus) dengan sinar matahari penuh',
  '58-65 hari setelah tanam',
  'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400&h=300&fit=crop',
  45000, TRUE),

('Melon Action 434 F1 (Cucumis melo)', 'Buah & Melon',
  'Melon jaring (netted melon) berdaging tebal kehijauan-oranye, aroma harum kuat, tekstur renyah manis (13-15 Brix), bobot 2-3 kg. Tahan virus Gemini dan embun tepung.',
  'Semai 10-12 hari. Tanam di bedengan jarak 50×60 cm dengan sistem ajir tegak atau rambatan tanah. Toping pucuk utama di daun ke-12 dan pelihara 1-2 buah terbaik.',
  'Musim kemarau (April-September) untuk net sempurna dan rasa manis maksimal',
  '60-65 hari setelah tanam',
  'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&h=300&fit=crop',
  40000, TRUE),

('Pepaya California IPB 9 (Carica papaya)', 'Buah & Melon',
  'Pepaya varietas unggul riset IPB dengan buah lonjong silindris berbobot 0,8-1,5 kg, daging merah jingga padat tebal manis (11-14 Brix), tahan simpan 7-10 hari.',
  'Semai benih di polybag 1 bulan. Buat lubang tanam 50×50×50 cm jarak 2,5×2,5 m. Berikan pupuk kandang 20 kg per lubang. Pastikan lahan tidak pernah tergenang air.',
  'Awal musim hujan (Oktober-Desember) untuk pertumbuhan vegetatif awal',
  '7-8 bulan setelah tanam, panen berkelanjutan tiap minggu hingga 3 tahun',
  'https://images.unsplash.com/photo-1526318472351-c75fcf070305?w=400&h=300&fit=crop',
  25000, TRUE),

('Pisang Cavendish Sunpride (Musa acuminata)', 'Buah & Melon',
  'Bibit kultur jaringan pisang Cavendish berkualitas ekspor. Bebas penyakit layu Fusarium dan darah (Blood disease). Tandan besar berisi 8-12 sisir buah mulus manis.',
  'Gunakan bibit kultur jaringan tinggi 30 cm. Lubang tanam 60×60×60 cm jarak 2×2,5 m. Berikan dolomit dan pupuk kandang matang. Pasang ajir saat tanaman mulai berbuah.',
  'Awal musim hujan, butuh kelembaban cukup sepanjang pertumbuhan',
  '9-10 bulan setelah tanam',
  'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&h=300&fit=crop',
  35000, TRUE),

('Jeruk Nipis Tanpa Biji (Citrus aurantiifolia)', 'Buah & Melon',
  'Bibit jeruk nipis okulasi varietas seedless (tanpa biji). Buah lebat berdaging banyak air asam segar aromatik, sangat diminati restoran, industri kuliner, dan herbal.',
  'Tanam bibit hasil okulasi di lubang 50×50×50 cm jarak 4×4 meter. Beri pupuk NPK dan mikronutrien rutin. Pangkas ranting kering dan tunas air secara berkala.',
  'Awal musim hujan, cocok di dataran rendah hingga menengah',
  '1,5-2 tahun (bibit okulasi), berbuah sepanjang tahun tanpa musim',
  'https://images.unsplash.com/photo-1590502593747-42a996133562?w=400&h=300&fit=crop',
  50000, TRUE),

('Alpukat Miki (Persea americana)', 'Buah & Melon',
  'Varietas alpukat unggul dataran rendah asal Depok. Daging tebal kuning mentega tanpa serat, rasa gurih legit manis, kulit tipis mudah dikupas, tahan ulat buah.',
  'Lubang tanam 75×75×75 cm jarak 6×6 meter. Campur tanah dengan pupuk kandang kambing fermentasi. Beri mulsa tebal di sekeliling tajuk untuk menjaga kelembaban akar.',
  'Awal musim hujan, optimal di dataran rendah 10-600 MDPL',
  '3-4 tahun setelah tanam (bibit sambung pucuk)',
  'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?w=400&h=300&fit=crop',
  65000, TRUE),

('Mangga Kiojay (Mangifera indica)', 'Buah & Melon',
  'Mangga jumbo asal Thailand yang adaptif di Indonesia. Bobot buah mencapai 1-1,5 kg per butir, rasa manis segar renyah saat matang pohon, biji tipis gepeng.',
  'Tanam bibit okulasi di lubang 60×60×60 cm jarak 8×8 meter. Lakukan pemangkasan bentuk 1-3-9 untuk membentuk tajuk produktif dan mempercepat pembuahan.',
  'Awal musim hujan untuk penanaman awal bibit',
  '2,5-3 tahun (bibit okulasi)',
  'https://images.unsplash.com/photo-1553279768-865429fa0078?w=400&h=300&fit=crop',
  60000, TRUE),

('Jambu Kristal Non-Biji (Psidium guajava)', 'Buah & Melon',
  'Jambu biji dengan kandungan biji kurang dari 3%, daging buah putih renyah seperti apel, rasa manis segar berair. Sangat genjah (cepat berbuah) dan rajin berbuah.',
  'Tanam di lubang 50×50×50 cm jarak 3×3 meter. Lakukan pembungkusan (brongsong) buah saat seukuran kelereng untuk mencegah serangan lalat buah.',
  'Sepanjang tahun, butuh sinar matahari penuh',
  '8-12 bulan setelah tanam (bibit cangkok/okulasi)',
  'https://images.unsplash.com/photo-1536511135894-35e6833b3a72?w=400&h=300&fit=crop',
  40000, TRUE),

-- === PADI & PALAWIJA (7 bibit) ===
('Padi Inpari 32 HDB (Oryza sativa)', 'Padi & Palawija',
  'Varietas padi inbrida sawah irigasi berpotensi hasil 10,6 ton/ha GKP. Tahan penyakit hawar daun bakteri (HDB) strain III, IV, VIII dan blas. Nasi pulen disukai pasar.',
  'Semai 15-20 hari. Tanam pindah sistem Jajar Legowo 2:1 atau 4:1 jarak 25×12,5×50 cm dengan 1-2 bibit per rumpun. Pemupukan berimbang Urea, SP-36, dan KCl.',
  'Musim Tanam I (Oktober-Februari) & Musim Tanam II (Maret-Juni)',
  '115-120 hari setelah sebar',
  'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400&h=300&fit=crop',
  18000, TRUE),

('Jagung Manis Bonanza F1 (Zea mays saccharata)', 'Padi & Palawija',
  'Jagung manis hibrida unggul dengan tongkol besar seragam panjang 20-22 cm, bulir kuning rapat manis (tingkat brix 13-15%), tahan simpan 3-5 hari setelah panen.',
  'Tanam langsung 1 biji per lubang jarak 70×20 cm. Berikan pupuk dasar NPK dan pupuk susulan Urea umur 15 dan 30 hari. Bumbun tanah saat tanaman umur 3 minggu.',
  'Awal musim kemarau atau akhir musim hujan',
  '68-73 hari setelah tanam',
  'https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=400&h=300&fit=crop',
  30000, TRUE),

('Jagung Hibrida Pioneer P35 (Zea mays)', 'Padi & Palawija',
  'Jagung pipil hibrida andalan petani pakan ternak. Batang kokoh tahan roboh, tongkol besar berisi penuh hingga ujung, rendemen tinggi, dan tahan bulai (Peronosclerospora).',
  'Tanam 1 biji per lubang jarak 70×20 cm. Pengolahan tanah sempurna, pemupukan Urea + NPK + pupuk mikro. Bersihkan gulma sebelum umur 30 HST.',
  'Musim Tanam I (awal musim hujan) atau Musim Tanam II',
  '100-105 hari setelah tanam',
  'https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=400&h=300&fit=crop',
  75000, TRUE),

('Kedelai Anjasmoro (Glycine max)', 'Padi & Palawija',
  'Varietas kedelai berbiji besar (bobot 100 biji 14-16 gram), polong tidak mudah pecah saat panen, kadar protein tinggi (40-42%). Favorit pengrajin tahu-tempe nasional.',
  'Tanam sistem tugal 2-3 biji per lubang jarak 40×15 cm di lahan sawah bekas padi (tanpa olah tanah/TOT). Berikan inokulum Rhizobium pada benih sebelum tanam.',
  'Musim Tanam III (setelah panen padi MK2, Juli-September)',
  '85-90 hari setelah tanam',
  'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=400&h=300&fit=crop',
  22000, TRUE),

('Kacang Tanah Kancil (Arachis hypogaea)', 'Padi & Palawija',
  'Varietas kacang tanah tipe menjalar dengan polong berisi 2-3 biji bernas, rasa manis gurih, tahan layu bakteri Ralstonia. Adaptif di lahan kering dan sawah tadah hujan.',
  'Tanam 1-2 biji per lubang jarak 40×15 cm kedalaman 3-5 cm. Tanah harus gembur berpasir agar ginofor (bakal polong) mudah masuk ke dalam tanah. Berikan pupuk kalsium/kapur.',
  'Awal musim kemarau di lahan tegalan atau musim kemarau di lahan sawah',
  '90-95 hari setelah tanam',
  'https://images.unsplash.com/photo-1567375698348-5d9d5ae99de0?w=400&h=300&fit=crop',
  25000, TRUE),

('Kacang Hijau Vima 1 (Vigna radiata)', 'Padi & Palawija',
  'Varietas kacang hijau polong masak serempak (80-85% panen sekali petik), polong matang berwarna hitam tidak mudah pecah, toleran terhadap penyakit embun tepung.',
  'Tanam dengan sistem tugal jarak 40×20 cm (2 biji per lubang) di lahan sawah bekas padi tanpa olah tanah. Pengairan cukup saat tanam, berbunga, dan pengisian polong.',
  'Musim kemarau (Juli-Agustus) di lahan sawah tadah hujan/irigasi',
  '56-60 hari setelah tanam',
  'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=400&h=300&fit=crop',
  20000, TRUE),

('Ubi Jalar Ungu Antin 3 (Ipomoea batatas)', 'Padi & Palawija',
  'Ubi jalar berkulit ungu daging ungu pekat tinggi antosianin (antioksidan alami), rasa manis legit, kadar serat baik. Sangat prospektif untuk industri olahan makanan sehat.',
  'Gunakan stek pucuk sepanjang 20-25 cm. Tanam miring pada guludan tinggi 30-40 cm jarak 30×80 cm. Balik sulur saat umur 2 bulan agar tidak tumbuh akar liar di batang.',
  'Awal musim hujan atau musim kemarau dengan ketersediaan air cukup',
  '4-4,5 bulan setelah tanam',
  'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=400&h=300&fit=crop',
  15000, TRUE),

-- === PERKEBUNAN & REMPAH (7 bibit) ===
('Jahe Merah Unggul (Zingiber officinale var. rubrum)', 'Perkebunan & Rempah',
  'Bibit rimpang jahe merah tua bertunas unggul. Daging rimpang merah jingga beraroma pedas kuat khas minyak atsiri dan gingerol tinggi. Permintaan tinggi industri herbal.',
  'Semaikan rimpang 2-3 mata tunas di polybag/karung bekas atau bedengan guludan jarak 40×50 cm. Berikan naungan 30% pada 2 bulan pertama dan mulsa jerami tebal.',
  'Awal musim hujan (Oktober-Desember)',
  '9-10 bulan setelah tanam',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&h=300&fit=crop',
  30000, TRUE),

('Kunyit Kuning Super (Curcuma longa)', 'Perkebunan & Rempah',
  'Varietas kunyit unggul lokal dengan rimpang besar bulat padat, warna jingga pekat tinggi kurkumin. Sangat adaptif di bawah naungan tanaman perkebunan (tumpangsari).',
  'Tanam potongan rimpang berbobot 20-30 gram yang sudah bertunas di guludan jarak 50×50 cm. Siram teratur saat awal tumbuh, pupuk dengan kompos dan abu sekam.',
  'Awal musim hujan, toleran naungan parsial hingga 40%',
  '8-9 bulan setelah tanam',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&h=300&fit=crop',
  18000, TRUE),

('Temulawak Curcuma (Curcuma zanthorrhiza)', 'Perkebunan & Rempah',
  'Tanaman obat asli Indonesia. Rimpang besar, daging kuning-oranye terang, tinggi kurkuminoid dan xanthorrhizol. Bahan utama jamu tradisional dan suplemen.',
  'Tanam rimpang dengan 2-3 mata tunas jarak 60×60 cm di tanah gembur subur. Beri naungan pohon tahunan (sistem tumpangsari). Mulsa organik tebal agar tanah tetap lembab.',
  'Awal musim hujan, tumbuh baik di bawah naungan pohon',
  '10-12 bulan setelah tanam',
  'https://images.unsplash.com/photo-1596097634272-e0c0a97bb159?w=400&h=300&fit=crop',
  20000, TRUE),

('Kencur (Kaempferia galanga)', 'Perkebunan & Rempah',
  'Rimpang kencur kecil harum khas Indonesia. Bahan utama jamu beras kencur, bumbu masakan Sunda-Jawa, dan obat tradisional.',
  'Tanam rimpang segar utuh atau dibelah dengan 1-2 mata tunas. Jarak 20×30 cm di tanah ringan berpasir kaya humus. Siram cukup, jangan sampai tergenang.',
  'Awal musim hujan, dataran rendah-menengah',
  '8-10 bulan setelah tanam',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&h=300&fit=crop',
  22000, TRUE),

('Serai Wangi (Cymbopogon nardus)', 'Perkebunan & Rempah',
  'Serai wangi atau sitronela yang tumbuh subur di seluruh Indonesia. Minyak atsirinya banyak digunakan untuk industri kosmetik, aromaterapi, dan pengusir nyamuk alami.',
  'Tanam anakan/rumpun segar jarak 60×60 cm. Potong daun hingga tinggi 10 cm sebelum tanam agar akar tumbuh optimal. Pupuk kandang cukup untuk pertumbuhan awal.',
  'Sepanjang tahun, adaptif berbagai ketinggian',
  '6 bulan pertama, lalu panen daun tiap 3 bulan',
  'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=400&h=300&fit=crop',
  12000, TRUE),

('Lengkuas Merah (Alpinia purpurata)', 'Perkebunan & Rempah',
  'Lengkuas merah dengan kandungan minyak atsiri dan galangol tinggi. Banyak digunakan dalam pengobatan tradisional (anti-jamur, anti-bakteri) dan bumbu kuliner nusantara.',
  'Belah rimpang menjadi potongan bertunas (50-80 g). Tanam di tanah gembur kaya bahan organik jarak 40×60 cm kedalaman 5-8 cm. Beri mulsa organik tebal.',
  'Awal musim hujan, toleran naungan parsial',
  '10-12 bulan setelah tanam',
  'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=400&h=300&fit=crop',
  15000, TRUE),

('Kapulaga Jawa (Amomum compactum)', 'Perkebunan & Rempah',
  'Varietas kapulaga lokal yang sangat bernilai ekonomi tinggi. Tumbuh subur di bawah naungan pohon sengon, kelapa, atau karet. Buah aromatik untuk industri farmasi dan bumbu.',
  'Tanam anakan bertunas 2-3 batang jarak 1,5×1,5 m di bawah naungan 50-70%. Jaga kelembaban tanah dengan seresah daun. Panen saat buah berwarna coklat keabuan.',
  'Awal musim hujan, dataran tinggi 300-1000 MDPL',
  '2-3 tahun setelah tanam, panen rutin tiap 3 bulan',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&h=300&fit=crop',
  35000, TRUE);


-- ================================================================
-- LANGKAH 5: VERIFIKASI DATA
-- ================================================================
SELECT 'bibit_tanaman' AS tabel, COUNT(*) AS total FROM bibit_tanaman
UNION ALL
SELECT 'pesan_kontak', COUNT(*) FROM pesan_kontak;
