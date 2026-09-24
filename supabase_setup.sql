-- ================================================================
--  GO-TANI — SQL Editor: Complete Database Setup
--  Jalankan di: Supabase Dashboard → SQL Editor
-- ================================================================


-- ================================================================
-- LANGKAH 1: BUAT TABEL
-- ================================================================

CREATE TABLE IF NOT EXISTS bibit_tanaman (
  id              BIGSERIAL        PRIMARY KEY,
  nama_bibit      TEXT             NOT NULL,
  kategori        TEXT             NOT NULL
                    CHECK (kategori IN ('Sayur','Buah','Palawija','Rempah','Lainnya')),
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

CREATE TABLE IF NOT EXISTS blog_posts (
  id            BIGSERIAL     PRIMARY KEY,
  judul         TEXT          NOT NULL,
  slug          TEXT          NOT NULL UNIQUE,
  konten        TEXT,
  excerpt       TEXT,
  thumbnail_url TEXT,
  kategori      TEXT          DEFAULT 'Umum',
  author        TEXT          DEFAULT 'Tim Go-Tani',
  is_published  BOOLEAN       DEFAULT TRUE,
  created_at    TIMESTAMPTZ   DEFAULT NOW(),
  updated_at    TIMESTAMPTZ   DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS layanan (
  id          BIGSERIAL     PRIMARY KEY,
  nama        TEXT          NOT NULL,
  deskripsi   TEXT,
  ikon        TEXT          DEFAULT 'sprout',
  urutan      INTEGER       DEFAULT 0,
  is_active   BOOLEAN       DEFAULT TRUE,
  created_at  TIMESTAMPTZ   DEFAULT NOW()
);


-- ================================================================
-- LANGKAH 2: AKTIFKAN RLS
-- ================================================================
ALTER TABLE bibit_tanaman  ENABLE ROW LEVEL SECURITY;
ALTER TABLE pesan_kontak   ENABLE ROW LEVEL SECURITY;
ALTER TABLE blog_posts     ENABLE ROW LEVEL SECURITY;
ALTER TABLE layanan        ENABLE ROW LEVEL SECURITY;

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
DROP POLICY IF EXISTS "publik_read_blog"     ON blog_posts;
DROP POLICY IF EXISTS "admin_insert_blog"    ON blog_posts;
DROP POLICY IF EXISTS "admin_update_blog"    ON blog_posts;
DROP POLICY IF EXISTS "admin_delete_blog"    ON blog_posts;
DROP POLICY IF EXISTS "admin_read_blog"      ON blog_posts;
DROP POLICY IF EXISTS "admin_all_blog"       ON blog_posts;
DROP POLICY IF EXISTS "publik_read_layanan"  ON layanan;
DROP POLICY IF EXISTS "admin_manage_layanan" ON layanan;
DROP POLICY IF EXISTS "admin_all_layanan"    ON layanan;

-- Bibit Tanaman Policies
-- Publik & Admin dapat membaca, menambah, mengubah, dan menghapus bibit
CREATE POLICY "publik_read_bibit"    ON bibit_tanaman FOR SELECT TO anon, authenticated USING (TRUE);
CREATE POLICY "admin_all_bibit"      ON bibit_tanaman FOR ALL    TO anon, authenticated  USING (TRUE) WITH CHECK (TRUE);

-- Pesan Kontak Policies
-- Pengunjung publik (anon) dapat mengirim pesan kontak
CREATE POLICY "publik_insert_kontak" ON pesan_kontak  FOR INSERT TO anon, authenticated WITH CHECK (TRUE);
-- Admin dapat membaca, menandai terbaca, dan menghapus pesan kontak
CREATE POLICY "admin_all_kontak"     ON pesan_kontak  FOR ALL    TO anon, authenticated  USING (TRUE) WITH CHECK (TRUE);

-- Blog Posts Policies
-- Publik & Admin dapat membaca artikel
CREATE POLICY "publik_read_blog"     ON blog_posts    FOR SELECT TO anon, authenticated USING (TRUE);
-- Admin memiliki akses penuh (CRUD) ke tabel blog_posts
CREATE POLICY "admin_all_blog"       ON blog_posts    FOR ALL    TO anon, authenticated USING (TRUE) WITH CHECK (TRUE);

-- Layanan Policies
-- Publik & Admin dapat membaca layanan
CREATE POLICY "publik_read_layanan"  ON layanan       FOR SELECT TO anon, authenticated USING (TRUE);
-- Admin memiliki akses penuh (CRUD) ke daftar layanan
CREATE POLICY "admin_all_layanan"    ON layanan       FOR ALL    TO anon, authenticated USING (TRUE) WITH CHECK (TRUE);



-- ================================================================
-- LANGKAH 3: HAPUS DATA LAMA (opsional)
-- ================================================================
TRUNCATE TABLE bibit_tanaman RESTART IDENTITY;
TRUNCATE TABLE blog_posts    RESTART IDENTITY;
TRUNCATE TABLE layanan       RESTART IDENTITY;


-- ================================================================
-- LANGKAH 4: INSERT DATA LAYANAN
-- ================================================================
INSERT INTO layanan (nama, deskripsi, ikon, urutan) VALUES
(
  'Rekomendasi Bibit Unggul',
  'Kami menyediakan rekomendasi bibit tanaman unggul pilihan petani Indonesia, lengkap dengan informasi varietasnya yang terverifikasi dan terpercaya.',
  'sprout',
  1
),
(
  'Panduan Cara Tanam',
  'Setiap bibit dilengkapi panduan menanam step-by-step yang mudah dipahami, mulai dari persiapan lahan, teknik tanam, pemupukan, hingga panen.',
  'book-open',
  2
),
(
  'Info Musim & Panen',
  'Dapatkan informasi lengkap tentang musim tanam terbaik, estimasi masa panen, dan kondisi ideal untuk setiap jenis tanaman.',
  'calendar',
  3
),
(
  'Konsultasi Pertanian',
  'Punya masalah di ladang? Kirimkan pertanyaan Anda melalui form kontak dan tim kami siap membantu memberikan solusi terbaik.',
  'message-circle',
  4
),
(
  'Data Real-Time',
  'Semua data bibit diperbarui secara real-time dari database kami. Informasi selalu akurat, terkini, dan relevan untuk kebutuhan Anda.',
  'database',
  5
),
(
  'Akses Gratis Selamanya',
  'Go-Tani berkomitmen menyediakan informasi pertanian berkualitas yang dapat diakses secara gratis oleh seluruh petani Indonesia.',
  'heart',
  6
);


-- ================================================================
-- LANGKAH 5: INSERT DATA BLOG
-- ================================================================
INSERT INTO blog_posts (judul, slug, excerpt, konten, thumbnail_url, kategori, author) VALUES
(
  'Tips Menanam Bawang Merah Bima Brebes agar Umbi Besar',
  'tips-menanam-bawang-merah-bima-brebes',
  'Bawang merah Bima Brebes adalah varietas andalan petani Indonesia. Pelajari teknik budidaya yang benar mulai dari persiapan lahan, jarak tanam ideal, hingga penanganan hama utama agar hasil panen maksimal.',
  'Bawang merah Bima Brebes merupakan varietas unggulan asal Brebes, Jawa Tengah yang paling banyak ditanam petani Indonesia. Dengan potensi hasil 10-18 ton/ha, varietas ini menjadi tulang punggung produksi bawang merah nasional.

## Persiapan Lahan
Siapkan bedengan dengan lebar 1-1,2 meter dan tinggi 30-40 cm. Pastikan lahan mendapatkan sinar matahari penuh sepanjang hari. pH tanah ideal 5,5-7,0 dengan drainase yang baik untuk mencegah busuk umbi.

## Teknik Penanaman
Gunakan bibit umbi (bukan benih biji) berukuran 4-6 gram per umbi. Tanam dengan jarak 15×20 cm, kedalaman 2/3 bagian umbi tertanam. Potong ujung umbi sebelum tanam untuk mempercepat pertumbuhan tunas.

## Pemupukan
- Pupuk dasar: Kompos 20 ton/ha + NPK 16-16-16 200 kg/ha saat tanam
- Susulan 1 (umur 20 hari): Urea 100 kg/ha + KCl 50 kg/ha
- Susulan 2 (umur 35 hari): NPK 100 kg/ha + pupuk daun

## Pengendalian Hama
Hama utama: ulat bawang (Spodoptera exigua) dan penyakit layu Fusarium. Semprot insektisida dan fungisida preventif setiap 5-7 hari sejak umur 2 minggu.',
  'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=800&h=500&fit=crop&q=80',
  'Tips Menanam',
  'Tim Go-Tani'
),
(
  'Cara Mengatasi Penyakit Antraknosa pada Cabai Rawit',
  'cara-mengatasi-antraknosa-cabai-rawit',
  'Antraknosa atau patek adalah penyakit paling merusak pada tanaman cabai. Kenali gejala awal, faktor penyebab, dan cara penanganan organik maupun kimia yang efektif untuk melindungi kebun cabai Anda.',
  'Antraknosa (Colletotrichum spp.) atau yang dikenal petani sebagai penyakit "patek" merupakan ancaman utama tanaman cabai di Indonesia. Serangan berat dapat menyebabkan kehilangan panen hingga 80%.

## Gejala Penyakit
- Bercak coklat kehitaman pada buah yang melekuk ke dalam
- Buah menjadi keriput dan berwarna oranye hingga merah sebelum waktunya
- Pada kondisi lembab, tampak massa spora berwarna oranye di tengah bercak
- Daun dan ranting juga bisa terserang dengan bercak tidak beraturan

## Faktor Penyebab
Penyakit ini dipicu oleh kelembaban tinggi, curah hujan berlebih, dan sirkulasi udara buruk. Jamur menyebar melalui percikan air hujan dan serangga.

## Pengendalian Organik
- Semprot larutan bawang putih (200g/liter) setiap 3 hari
- Aplikasi Trichoderma sp. pada media tanam
- Pangkas daun yang sakit dan bakar

## Pengendalian Kimia
Gunakan fungisida berbahan aktif mankozeb, klorotalonil, atau azoksistrobin. Rotasi bahan aktif setiap 2-3 aplikasi untuk mencegah resistensi.',
  'https://images.unsplash.com/photo-1588252303782-cb80119abd6d?w=800&h=500&fit=crop&q=80',
  'Hama & Penyakit',
  'Tim Go-Tani'
),
(
  'Panduan Budidaya Pepaya California IPB 9 untuk Pemula',
  'panduan-budidaya-pepaya-california-ipb9',
  'Pepaya California IPB 9 menjadi primadona petani Indonesia berkat produktivitasnya yang tinggi. Simak panduan lengkap dari pemilihan bibit, penanaman, pemupukan, hingga pasca panen yang menguntungkan.',
  'Pepaya California atau IPB 9 merupakan hasil riset Institut Pertanian Bogor (IPB) yang kini mendominasi 70% pasar pepaya Indonesia. Dengan daging oranye tebal manis (TSS 11-14 brix), pepaya ini sangat digemari konsumen.

## Keunggulan IPB 9
- Bobot buah ideal 0,5-1,5 kg — pas untuk pasar modern
- Tahan simpan 7-10 hari setelah panen
- Produktif sepanjang tahun di dataran rendah
- Potensi hasil 80-120 ton/ha/tahun

## Persiapan Bibit
Semai benih dalam polybag kecil berisi campuran tanah, kompos, dan arang sekam (2:1:1). Siram setiap hari, bibit siap pindah tanam setelah 1 bulan atau tinggi 15-20 cm.

## Penanaman
Buat lubang tanam 50×50×50 cm dengan jarak 2,5×2,5 meter. Isi lubang dengan campuran tanah galian + pupuk kandang 20 kg. Pilih sistem 1 pohon betina + 1 pohon jantan per 10 pohon untuk pembuahan optimal.

## Pemupukan Rutin
NPK (15-15-15) 200 gram per pohon setiap bulan. Tingkatkan pupuk K (kalium) saat fase pembungaan dan pembesaran buah untuk rasa yang lebih manis.',
  'https://images.unsplash.com/photo-1526318472351-c75fcf070305?w=800&h=500&fit=crop&q=80',
  'Panduan Budidaya',
  'Tim Go-Tani'
),
(
  'Mengenal Musim Tanam yang Tepat untuk Hasil Panen Optimal',
  'musim-tanam-tepat-hasil-panen-optimal',
  'Memilih waktu tanam yang tepat adalah kunci keberhasilan panen. Pelajari pola musim tanam Indonesia dan strategi terbaik untuk memaksimalkan produktivitas lahan Anda sepanjang tahun.',
  'Indonesia memiliki dua musim utama yang sangat mempengaruhi keputusan tanam petani: musim hujan (Oktober-April) dan musim kemarau (Mei-September). Memahami pola ini adalah kunci profitabilitas usaha tani.

## Kalender Tanam Indonesia
### Musim Hujan (Oktober - April)
Cocok untuk: padi sawah, jagung, kedelai, singkong, ubi jalar, dan tanaman yang membutuhkan banyak air.

### Musim Kemarau (Mei - September)
Cocok untuk: bawang merah, bawang putih, cabai, semangka, melon, dan tanaman yang sensitif terhadap genangan.

## Strategi Multi-Komoditas
Petani sukses biasanya menanam 2-3 komoditas berbeda secara berselang untuk menjamin pendapatan sepanjang tahun:
1. **Pola 1**: Padi (MH) → Bawang Merah (MK1) → Cabai (MK2)
2. **Pola 2**: Jagung (MH) → Kedelai (MK1) → Singkong (MH berikutnya)
3. **Pola 3**: Sayuran (sepanjang tahun) + Buah-buahan (tahunan)

## Tips Antisipasi Iklim
Pantau informasi BMKG untuk prediksi curah hujan bulanan. Sesuaikan jadwal tanam dengan prakiraan iklim untuk menghindari gagal panen akibat kekeringan atau banjir.',
  'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=500&fit=crop&q=80',
  'Edukasi Pertanian',
  'Tim Go-Tani'
),
(
  'Pupuk Organik vs Kimia: Mana yang Lebih Baik untuk Bibit?',
  'pupuk-organik-vs-kimia-untuk-bibit',
  'Perdebatan pupuk organik vs kimia selalu menjadi topik hangat di kalangan petani. Artikel ini mengulas kelebihan dan kekurangan keduanya secara objektif untuk membantu Anda memilih strategi pemupukan terbaik.',
  'Pilihan pupuk yang tepat sangat menentukan kualitas dan kuantitas hasil panen. Berikut perbandingan objektif antara pupuk organik dan anorganik (kimia):

## Pupuk Organik
### Kelebihan
- Memperbaiki struktur tanah secara permanen
- Meningkatkan aktivitas mikroorganisme menguntungkan
- Menyediakan nutrisi lengkap (makro + mikro) secara lambat
- Ramah lingkungan dan meningkatkan nilai jual produk (organik premium)
- Biaya jangka panjang lebih murah jika membuat sendiri

### Kekurangan
- Ketersediaan nutrisi lambat (tidak cocok untuk fase kritis tanaman)
- Perlu volume besar untuk memenuhi kebutuhan nutrisi

## Pupuk Kimia (Anorganik)
### Kelebihan
- Ketersediaan nutrisi cepat dan terukur
- Dosis presisi sesuai kebutuhan tanaman
- Efektif untuk mengatasi defisiensi nutrisi akut

### Kekurangan
- Penggunaan berlebihan merusak struktur tanah
- Dapat mencemari lingkungan jika tidak terkelola
- Tanaman menjadi "ketergantungan" pupuk kimia

## Rekomendasi: Sistem Terpadu
Gunakan kombinasi 70% pupuk organik + 30% pupuk kimia. Pupuk organik sebagai pembenah tanah jangka panjang, pupuk kimia sebagai "booster" pada fase kritis (awal tumbuh, pembungaan, pembuahan).',
  'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=800&h=500&fit=crop&q=80',
  'Edukasi Pertanian',
  'Tim Go-Tani'
),
(
  'Jahe Merah: Peluang Emas Rempah Bernilai Tinggi',
  'jahe-merah-peluang-emas-rempah',
  'Jahe merah kini menjadi komoditas primadona industri herbal dan farmasi Indonesia. Harganya 3-5 kali lebih tinggi dari jahe biasa. Pelajari cara budidaya dan pemasaran jahe merah yang menguntungkan.',
  'Jahe merah (Zingiber officinale var. rubrum) mengalami lonjakan permintaan luar biasa dalam 5 tahun terakhir, terutama dari industri jamu, minuman kesehatan, dan farmasi. Harga jual di tingkat petani mencapai Rp 35.000-60.000/kg.

## Mengapa Jahe Merah?
- Kandungan gingerol dan shogaol tertinggi dibanding jahe biasa — berkhasiat sebagai antiinflamasi, antioksidan, dan imunomodulator
- Permintaan industri terus meningkat seiring tren kesehatan alami pasca pandemi
- Cocok ditanam di lahan sempit, pekarangan rumah, atau tumpangsari
- Masa panen 8-10 bulan dengan harga jual premium

## Persiapan Bibit
Pilih rimpang jahe merah dari tanaman berumur minimal 10 bulan. Potong 30-40 gram per potongan dengan 2-3 mata tunas. Angin-anginkan di tempat teduh 2-3 hari hingga luka mengering (jangan terkena sinar matahari langsung).

## Perawatan Utama
- Kelembaban tanah: kunci utama, gunakan mulsa jerami tebal 5-10 cm
- Naungan: 30-40% di musim kemarau dengan paranet
- Pemupukan: kompos 5 kg/m² saat tanam + pupuk kandang cair tiap bulan

## Pemasaran
Jalin kemitraan langsung dengan pabrik jamu, pengepul herbal, atau jual melalui marketplace digital. Sertifikasi organik meningkatkan harga jual 2-3 kali lipat.',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=800&h=500&fit=crop&q=80',
  'Komoditas Unggulan',
  'Tim Go-Tani'
);


-- ================================================================
-- LANGKAH 6: INSERT DATA BIBIT — 30 Varietas
-- ================================================================
INSERT INTO bibit_tanaman
  (nama_bibit, kategori, deskripsi, cara_tanam, musim_tanam, masa_panen, gambar_url, harga_estimasi, stok)
VALUES

-- 🥬 SAYUR
('Bawang Merah Bima Brebes', 'Sayur',
  'Varietas unggulan asal Brebes, Jawa Tengah. Bawang merah paling banyak ditanam petani Indonesia dengan umbi merah-ungu kompak dan rasa tajam khas. Produktivitas 10-18 ton/ha.',
  'Siapkan bedengan lebar 1-1,2 m. Tanam umbi bibit (4-6 g) secara langsung dengan jarak 15×20 cm dan kedalaman ⅔ bagian umbi. Beri pupuk NPK 16-16-16 saat tanam dan pupuk susulan umur 20 & 35 hari. Hindari lahan tergenang.',
  'Musim kemarau (Mei–September), butuh irigasi rutin',
  '60-70 hari setelah tanam',
  'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=400&h=300&fit=crop',
  85000, TRUE),

('Bawang Putih Lumbu Hijau', 'Sayur',
  'Varietas bawang putih lokal dataran tinggi asal Temanggung & Tawangmangu. Siung besar, aroma kuat, dan kadar minyak atsiri tinggi. Favorit petani Jawa Tengah & DIY.',
  'Tanam siung tunggal (bibit) jarak 15×20 cm, kedalaman 3-5 cm di tanah gembur berdrainase baik. Ideal di ketinggian 700-1000 mdpl. Beri pupuk kandang 20 ton/ha sebelum tanam, pupuk NPK saat umur 2 & 6 minggu.',
  'Musim kemarau (Mei–Agustus), dataran tinggi 700-1000 mdpl',
  '90-120 hari setelah tanam',
  'https://images.unsplash.com/photo-1506368249639-73a05d6f6488?w=400&h=300&fit=crop',
  95000, TRUE),

('Cabai Merah Keriting TM 999', 'Sayur',
  'Hibrida unggul paling luas ditanam petani Sumatera dan Jawa. Buah keriting panjang 15-18 cm, merah cerah, pedas sedang, dan tahan virus kuning (begomovirus). Potensi hasil 15-20 ton/ha.',
  'Semai benih dalam tray/polybag semai selama 25-30 hari. Pindah tanam jarak 60×70 cm di bedengan. Pupuk dasar: kompos + NPK. Pemupukan susulan tiap 2 minggu. Pasang ajir bambu saat umur 3 minggu.',
  'Sepanjang tahun (dataran rendah <400 mdpl), puncak harga Desember–Februari',
  '90-120 hari setelah tanam',
  'https://images.unsplash.com/photo-1607532941433-304659e8198a?w=400&h=300&fit=crop',
  35000, TRUE),

('Cabai Rawit Bhaskara', 'Sayur',
  'Varietas cabai rawit putih-merah produktif dari Jawa Timur. Buah kecil 3-5 cm, sangat pedas (>100.000 SHU), tahan antraknosa. Petani Jawa Timur dan Lombok banyak menanam ini.',
  'Semai 3 minggu. Tanam jarak 50×60 cm. Siram tiap pagi. Pupuk kandang saat tanam, NPK tiap 2 minggu. Semprot fungisida preventif saat musim hujan untuk cegah antraknosa.',
  'Sepanjang tahun (optimal kemarau)',
  '75-90 hari setelah tanam',
  'https://images.unsplash.com/photo-1588252303782-cb80119abd6d?w=400&h=300&fit=crop',
  30000, TRUE),

('Tomat Servo F1', 'Sayur',
  'Hibrida indeterminate tahan layu Fusarium dan virus TMV. Buah bulat merah seragam 80-120 gram, kulit tebal tahan angkut jauh. Sangat populer di petani Sumatera Barat, Jawa Barat, dan Sulawesi.',
  'Semai benih, pindah tanam umur 21-25 hari jarak 60×70 cm. Wajib gunakan ajir/tiang penopang. Sistem irigasi tetes ideal. Pangkas tunas lateral hingga menyisakan 2-3 batang utama.',
  'Dataran menengah-tinggi (400-1200 mdpl), suhu 18-25°C',
  '70-85 hari setelah pindah tanam',
  'https://images.unsplash.com/photo-1592841200221-a6898f307baa?w=400&h=300&fit=crop',
  40000, TRUE),

('Sawi Hijau Tosakan', 'Sayur',
  'Sawi hijau lokal paling banyak ditanam di Jawa dan Sumatera. Daun lebar dengan tulang daun putih tebal, rasa sedikit pahit-gurih khas. Tahan panas, cocok dataran rendah.',
  'Taburkan benih langsung di bedengan atau semai dulu. Jarak tanam 25×25 cm. Siram 2× sehari. Pupuk urea tiap 10 hari. Bisa panen bertahap dengan memotong daun luar.',
  'Sepanjang tahun, optimal saat cuaca tidak terlalu panas',
  '30-40 hari setelah tanam',
  'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
  8000, TRUE),

('Kangkung Bangkok LP1', 'Sayur',
  'Kangkung darat impor dari Thailand yang kini menjadi standar budidaya petani Indonesia. Batang besar renyah, daun lebar berwarna hijau tua, produktif dan cepat panen.',
  'Rendam benih 8 jam lalu tanam langsung di bedengan jarak 20×20 cm. Siram pagi-sore. Pemupukan urea tiap 10 hari. Panen dengan potong batang, biarkan tunas baru tumbuh untuk panen berikutnya.',
  'Sepanjang tahun (tahan panas & hujan)',
  '25-30 hari setelah tanam',
  'https://images.unsplash.com/photo-1597362925123-77861d3fbac7?w=400&h=300&fit=crop',
  7000, TRUE),

('Terong Ungu Mustang F1', 'Sayur',
  'Hibrida terong ungu panjang (25-30 cm) yang tahan Phytophthora dan virus. Daging putih lembut, tidak pahit. Populer di pasar Jabodetabek, Surabaya, dan Makassar.',
  'Semai benih 3-4 minggu. Pindah tanam jarak 70×60 cm. Pasang ajir bambu. Pupuk NPK rutin + pupuk daun. Panen saat buah belum terlalu keras agar rasa tetap manis.',
  'Dataran rendah-menengah, sepanjang tahun',
  '60-90 hari setelah tanam',
  'https://images.unsplash.com/photo-1473093226795-af9932fe5856?w=400&h=300&fit=crop',
  28000, TRUE),

('Timun Venus F1', 'Sayur',
  'Timun hibrida terbanyak ditanam petani Jawa Tengah dan Jawa Timur. Buah silindris hijau 15-20 cm, biji kecil, renyah, tidak pahit. Tahan antraknosa dan bercak daun.',
  'Tanam benih langsung 2 biji/lubang jarak 60×40 cm. Beri turus/rambatan bambu. Pupuk NPK saat tanam dan umur 3 minggu. Panen buah muda agar tanaman terus produktif.',
  'Musim kemarau dengan irigasi, atau awal musim hujan',
  '35-40 hari setelah tanam',
  'https://images.unsplash.com/photo-1604977042946-1eecc30f269e?w=400&h=300&fit=crop',
  20000, TRUE),

('Bayam Brasil (Bayam Petik)', 'Sayur',
  'Bayam Brasil atau bayam petik yang banyak dibudidayakan petani pinggiran kota Indonesia. Tumbuh tegak, daun besar hijau tua, dan bisa dipanen berulang kali dari tanaman yang sama.',
  'Semai benih atau stek batang. Tanam jarak 30×30 cm. Siram tiap hari. Beri pupuk organik cair tiap 2 minggu. Petik daun muda bagian atas, biarkan batang terus bercabang.',
  'Sepanjang tahun (sangat tahan panas)',
  '30-40 hari setelah tanam (panen terus-menerus)',
  'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&h=300&fit=crop',
  5000, TRUE),

-- 🍉 BUAH
('Pepaya California (IPB 9)', 'Buah',
  'Pepaya hibrida hasil riset IPB yang kini mendominasi pasar pepaya Indonesia. Buah lonjong 0,5-1,5 kg, daging oranye tebal manis (TSS 11-14 brix), tahan simpan 7-10 hari. Sangat produktif sepanjang tahun.',
  'Semai benih dalam polybag, pindah ke lahan umur 1 bulan. Jarak 2,5×2,5 m. Beri pupuk kandang 20 kg/pohon saat tanam. NPK rutin setiap bulan. Pilih 1 pohon betina + 1 jantan per 10 pohon.',
  'Dataran rendah, sepanjang tahun',
  '9-12 bulan (panen terus-menerus hingga 2-3 tahun)',
  'https://images.unsplash.com/photo-1526318472351-c75fcf070305?w=400&h=300&fit=crop',
  12000, TRUE),

('Pisang Cavendish G9', 'Buah',
  'Varietas pisang ekspor terbesar Indonesia, dibudidayakan luas di Lampung, Jawa Timur, dan Sulawesi. Buah lurus seragam, manis, tahan transportasi jarak jauh. Bebas biji.',
  'Tanam anakan/bonggol sehat jarak 3×3 m. Pilih lahan berdrainase baik. Pupuk NPK + organik tiap bulan. Bungkus tandan dengan plastik OPP untuk kualitas premium. Potong pelepah tua secara rutin.',
  'Dataran rendah-menengah (<600 mdpl), curah hujan 1200-2500 mm/tahun',
  '10-12 bulan setelah tanam (tandan/sisir)',
  'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&h=300&fit=crop',
  25000, TRUE),

('Mangga Gedong Gincu', 'Buah',
  'Mangga premium asli Cirebon, Jawa Barat. Kulit buah merah-oranye menggiurkan, daging kuning tebal, manis harum, serat halus. Harga jual tertinggi di pasar mangga Indonesia dan diekspor ke Timur Tengah.',
  'Tanam bibit okulasi/cangkok jarak 8×8 m. Beri pupuk kandang saat tanam. Pangkas ranting agar tajuk terbuka. Pupuk NPK tiap 4 bulan. Semprot ZPT untuk merangsang berbunga di luar musim.',
  'Dataran rendah 0-400 mdpl, musim berbuah Desember–Maret',
  '4-5 bulan setelah bunga (mulai produksi tahun ke-4)',
  'https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?w=400&h=300&fit=crop',
  65000, TRUE),

('Jeruk Siam Madu Karo', 'Buah',
  'Jeruk siam premium asal Tanah Karo, Sumatera Utara. Kulit tipis hijau-kuning, daging oranye manis-segar, biji sedikit. Terkenal di pasar Medan dan diekspor ke Singapura & Malaysia.',
  'Tanam bibit okulasi jarak 4×4 m di lahan berdrainase baik. Ideal di ketinggian 700-1200 mdpl. Pemupukan 4× setahun dengan NPK + pupuk mikro (Zn, B). Jaga pH tanah 5,5-6,5.',
  'Dataran tinggi Sumatera (700-1200 mdpl), panen Mei–Agustus',
  '2-3 tahun setelah tanam (bibit okulasi)',
  'https://images.unsplash.com/photo-1611080626919-7cf5a9dbab12?w=400&h=300&fit=crop',
  55000, TRUE),

('Semangka Inul (Non Biji)', 'Buah',
  'Semangka tanpa biji F1 hibrida yang digemari petani Banten, Indramayu, dan Lampung. Bobot 4-8 kg, daging merah solid manis (kadar gula 12 brix), tahan crack saat hujan.',
  'Semai benih 5-7 hari (benih semangka tanpa biji perlu perlakuan khusus: rendam air hangat 30°C selama 12 jam). Tanam jarak 2×1 m dengan polinator semangka berbiji. Beri mulsa plastik hitam-perak.',
  'Musim kemarau (April–September), dataran rendah',
  '65-70 hari setelah tanam',
  'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400&h=300&fit=crop',
  85000, TRUE),

('Melon Glamour F1', 'Buah',
  'Melon net premium yang banyak dibudidayakan di greenhouse Jawa Tengah (Wonosobo, Magelang) dan Bali. Bobot 1,5-2,5 kg, daging putih-krem manis (TSS >14 brix), kulit jaring halus.',
  'Wajib pakai greenhouse/naungan plastik UV. Tanam jarak 60×50 cm dengan vertikal trellis. 1 tanaman 1 buah (sisakan 1 buah terbaik). Irigasi tetes. Pupuk KNO3 tinggi saat pembesaran buah.',
  'Sepanjang tahun (dalam greenhouse), optimal kemarau',
  '60-70 hari setelah tanam',
  'https://images.unsplash.com/photo-1571167366136-b57e23d8869d?w=400&h=300&fit=crop',
  95000, TRUE),

('Rambutan Rapiah', 'Buah',
  'Rambutan lokal unggul asal Bogor yang menjadi raja rambutan Indonesia. Rambut merah-kuning tebal, daging putih tebal kering (tidak basah), manis legit, biji kecil mudah lepas dari daging.',
  'Tanam bibit okulasi/cangkok jarak 8×8 m. Beri pupuk kandang 30 kg/pohon saat tanam. Pangkas tajuk setelah panen. Aplikasikan pupuk NPK 4× setahun + pupuk mikro Mg dan B.',
  'Dataran rendah-menengah (<600 mdpl), panen Desember–Januari',
  '3-4 tahun setelah tanam (bibit okulasi)',
  'https://images.unsplash.com/photo-1563227812-0ea4c22e6cc8?w=400&h=300&fit=crop',
  60000, TRUE),

('Pisang Kepok Tanjung', 'Buah',
  'Pisang kepok varietas lokal asal Banjarmasin, Kalimantan Selatan. Banyak diolah menjadi pisang goreng, keripik, dan kolak. Buah bersudut jelas, kuning-oranye matang, rasa manis-gurih.',
  'Tanam anakan sehat jarak 3×3 m. Cocok di lahan rawa/gambut bergambut tipis seperti di Kalimantan. Pupuk organik tinggi. Biarkan 1 anakan pengganti per rumpun untuk produktivitas berkelanjutan.',
  'Dataran rendah-rawa, sepanjang tahun (Kalimantan & Sumatera)',
  '12-14 bulan setelah tanam',
  'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&h=300&fit=crop',
  20000, TRUE),

-- 🌽 PALAWIJA
('Jagung Manis Bonanza F1', 'Palawija',
  'Jagung manis hibrida paling populer di Indonesia (Jawa, Sumatera, Sulawesi). Tongkol besar seragam panjang 22-25 cm, biji kuning emas rapi, kadar gula sangat tinggi. Cocok dijual segar maupun diolah.',
  'Tanam 1 benih/lubang jarak 75×25 cm kedalaman 3-5 cm. Pupuk Urea 200 kg/ha + SP36 100 kg/ha + KCl 100 kg/ha. Pupuk susulan Urea umur 3 dan 6 minggu. Siram cukup, terutama saat pembungaan.',
  'Musim kemarau maupun hujan (adaptif), dataran rendah-menengah',
  '70-75 hari setelah tanam',
  'https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=400&h=300&fit=crop',
  32000, TRUE),

('Kedelai Anjasmoro', 'Palawija',
  'Varietas kedelai nasional terpopuler, hasil pemuliaan Balitkabi Malang. Biji besar seragam (10,53 g/100 biji), kulit kuning mengkilap, kadar protein 41,78%. Potensi hasil 2,03 ton/ha. Cocok dibuat tahu & tempe berkualitas.',
  'Tanam 2-3 benih/lubang jarak 40×15 cm. Inokulasi benih dengan Rhizobium sebelum tanam untuk meningkatkan fiksasi N. Pupuk SP36 + KCl saat tanam. Jaga dari gulma 30 hari pertama.',
  'Musim kemarau (MK II: Juni–September) dengan irigasi',
  '82-92 hari setelah tanam',
  'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?w=400&h=300&fit=crop',
  22000, TRUE),

('Kacang Tanah Kelinci', 'Palawija',
  'Varietas kacang tanah paling luas ditanam di Jawa (Tuban, Blitar, Pati). Polong 2 biji isian penuh, kulit biji merah muda, rasa gurih. Tahan penyakit karat daun dan bercak daun. Hasil 1,5-2,5 ton polong kering/ha.',
  'Tanam langsung jarak 20×30 cm kedalaman 3 cm. Beri Dolomit 1 ton/ha sebelum tanam untuk tanah masam. Lakukan pembumbunan saat tanaman mulai berbunga. Hindari genangan mutlak.',
  'Musim kemarau (Maret–Agustus), lahan tadah hujan',
  '90-100 hari setelah tanam',
  'https://images.unsplash.com/photo-1567892737950-30c4db37cd89?w=400&h=300&fit=crop',
  28000, TRUE),

('Singkong Gajah (UJ 5)', 'Palawija',
  'Varietas ubi kayu unggul paling banyak ditanam di Lampung, Jawa Tengah, dan Sulawesi. Umbi putih besar, kandungan pati tinggi (>25%), rendah HCN. Cocok untuk industri tapioka dan pakan ternak.',
  'Tanam stek batang panjang 25-30 cm (3-5 ruas) di lahan yang sudah dibajak. Jarak 80×80 cm atau 100×100 cm. Beri pupuk NPK 500 kg/ha saat tanam dan susulan umur 3 bulan.',
  'Awal musim hujan (Oktober–Desember) atau awal kemarau',
  '9-10 bulan setelah tanam',
  'https://images.unsplash.com/photo-1563288527-ef1f9cd04cf5?w=400&h=300&fit=crop',
  8000, TRUE),

('Ubi Jalar Cilembu', 'Palawija',
  'Ubi jalar premium asli Sumedang, Jawa Barat. Terkenal dengan rasa madu yang keluar saat dipanggang (oven). Kulit krem-coklat, daging oranye-krem, sangat manis. Harga jual premium 3-5× ubi biasa.',
  'Tanam stek pucuk (30-35 cm) di guludan/bedengan tinggi jarak 25-30 cm dalam baris, antar baris 70-80 cm. Tanah gembur ringan berpasir sangat ideal. Tidak perlu banyak pupuk N (membuat umbi berair).',
  'Dataran tinggi Jawa Barat (Sumedang, Majalengka), sepanjang tahun',
  '4-5 bulan setelah tanam',
  'https://images.unsplash.com/photo-1596097634272-e0c0a97bb159?w=400&h=300&fit=crop',
  15000, TRUE),

('Jagung Hibrida Bisi 18', 'Palawija',
  'Jagung hibrida paling banyak ditanam petani Indonesia untuk keperluan pakan ternak dan industri. Tahan penyakit bulai (Peronosclerospora maydis) dan toleran kekeringan. Potensi hasil 11-13 ton/ha.',
  'Tanam 1-2 benih/lubang jarak 75×40 cm. Pupuk rekomendasi: Urea 300 kg + SP36 100 kg + KCl 75 kg per ha. Susulan Urea 2× saat umur 3 dan 6 minggu. Lakukan penyiangan 2× selama pertumbuhan.',
  'Musim hujan maupun kemarau (sangat adaptif)',
  '98-102 hari setelah tanam',
  'https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=400&h=300&fit=crop',
  65000, TRUE),

-- 🌿 REMPAH
('Jahe Merah (Zingiber officinale var. rubrum)', 'Rempah',
  'Jahe merah paling diminati industri herbal dan farmasi Indonesia. Kandungan gingerol dan shogaol tertinggi dibanding jenis jahe lain. Rimpang kecil merah-kemerahan, rasa sangat pedas dan panas. Harga 3-5× jahe biasa.',
  'Potong rimpang segar (30-40 g, 2-3 mata tunas). Angin-anginkan 2-3 hari di tempat teduh. Tanam di lahan gembur berhumus jarak 25×40 cm kedalaman 7-10 cm. Tutup mulsa jerami tebal. Siram rutin agar lembab.',
  'Awal musim hujan (September–November), dataran rendah-menengah',
  '8-10 bulan setelah tanam',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&h=300&fit=crop',
  35000, TRUE),

('Kunyit Kuning Lokal Jawa', 'Rempah',
  'Kunyit kuning varietas lokal Jawa dengan kadar kurkumin tertinggi (>5%). Rimpang besar, warna oranye pekat, aroma kuat. Bahan utama jamu beras kencur, jamu kunyit asam, dan bumbu nasi kuning.',
  'Belah rimpang dengan 2-3 tunas. Tanam di tanah gembur kaya humus jarak 30×60 cm kedalaman 5-7 cm. Beri naungan 30% di awal pertumbuhan. Siram 3 hari sekali. Beri pupuk kandang saat tanam dan umur 4 bulan.',
  'Awal musim hujan, adaptif dataran rendah-tinggi',
  '9-10 bulan setelah tanam',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&h=300&fit=crop',
  18000, TRUE),

('Temulawak (Curcuma xanthorrhiza)', 'Rempah',
  'Tanaman obat asli Indonesia yang banyak dibudidayakan petani Jawa Tengah dan Jawa Timur. Rimpang besar, daging kuning-oranye terang, tinggi kurkuminoid dan xanthorrhizol. Bahan utama jamu tradisional dan suplemen.',
  'Tanam rimpang dengan 2-3 mata tunas jarak 60×60 cm di tanah gembur subur. Beri naungan pohon tahunan (sistem tumpangsari). Mulsa organik tebal agar tanah tetap lembab dan gembur.',
  'Awal musim hujan, tumbuh baik di bawah naungan pohon',
  '10-12 bulan setelah tanam',
  'https://images.unsplash.com/photo-1596097634272-e0c0a97bb159?w=400&h=300&fit=crop',
  20000, TRUE),

('Kencur (Kaempferia galanga)', 'Rempah',
  'Rimpang kencur kecil harum khas Indonesia, tidak bisa digantikan rempah lain. Bahan utama jamu beras kencur, rokok kretek, dan masakan Sunda-Jawa. Petani Jawa Barat dan Jawa Tengah banyak membudidayakannya.',
  'Tanam rimpang segar utuh atau dibelah dengan 1-2 mata tunas. Jarak 20×30 cm di tanah ringan berpasir kaya humus. Cocok tumpangsari di bawah pohon. Siram cukup, jangan sampai tergenang.',
  'Awal musim hujan, dataran rendah-menengah',
  '8-10 bulan setelah tanam',
  'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?w=400&h=300&fit=crop',
  22000, TRUE),

('Serai Wangi (Cymbopogon nardus)', 'Rempah',
  'Serai wangi atau sitronela yang tumbuh subur di seluruh Indonesia. Minyak atsirinya banyak digunakan untuk industri kosmetik, aromaterapi, dan repelen nyamuk alami.',
  'Tanam anakan/rumpun segar jarak 60×60 cm. Potong daun hingga tinggi 10 cm sebelum tanam agar akar tumbuh optimal. Pupuk kandang cukup untuk pertumbuhan awal. Minimal 3 bulan baru mulai panen daun.',
  'Sepanjang tahun, adaptif berbagai ketinggian',
  '6 bulan pertama, lalu panen daun tiap 3 bulan',
  'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=400&h=300&fit=crop',
  12000, TRUE),

('Lengkuas Merah (Alpinia purpurata)', 'Rempah',
  'Lengkuas merah dengan kandungan minyak atsiri dan galangol lebih tinggi dari lengkuas putih. Banyak digunakan dalam pengobatan tradisional Jawa dan Sumatera (anti-jamur, anti-bakteri). Harga jual lebih tinggi dari lengkuas biasa.',
  'Belah rimpang menjadi beberapa bagian bertunasnya (50-80 g/bagian). Tanam di tanah gembur kaya bahan organik jarak 40×60 cm kedalaman 5-8 cm. Tumpangsari dengan tanaman peneduh. Beri mulsa organik tebal.',
  'Awal musim hujan, toleran naungan parsial',
  '10-12 bulan setelah tanam',
  'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=400&h=300&fit=crop',
  15000, TRUE);


-- ================================================================
-- LANGKAH 7: VERIFIKASI DATA
-- ================================================================
SELECT 'bibit_tanaman' AS tabel, COUNT(*) AS total FROM bibit_tanaman
UNION ALL
SELECT 'blog_posts', COUNT(*) FROM blog_posts
UNION ALL
SELECT 'layanan', COUNT(*) FROM layanan
UNION ALL
SELECT 'pesan_kontak', COUNT(*) FROM pesan_kontak;


