# Product Requirements Document (PRD)
# Go-Tani — Website Rekomendasi Bibit Tanaman

**Versi:** 1.0
**Tanggal:** 22 September 2026
**Platform:** Blogspot (Frontend/Hosting) + Supabase (Backend/Database)
**Tipe Website:** Single Page Landing Page (One Page Scroll)
**Tema Desain:** Hijau & Putih — Simple, Clean, Elegan

---

## 1. Latar Belakang

Go-Tani adalah website informasi pertanian yang berfokus pada rekomendasi bibit tanaman beserta penjelasan lengkapnya (jenis, cara tanam, musim tanam, perawatan, dsb). Website dibangun sebagai **satu halaman (single page)** menggunakan **Blogspot** sebagai platform hosting/CMS, dengan **Supabase** sebagai backend penyedia data bibit tanaman secara dinamis melalui REST API/JavaScript client.

## 2. Tujuan Produk

1. Menyediakan wadah edukasi pertanian yang mudah diakses gratis melalui Blogspot.
2. Memberikan rekomendasi bibit tanaman yang datanya dapat diperbarui secara dinamis tanpa perlu mengedit ulang halaman (via Supabase).
3. Membangun engagement melalui konten blog seputar pertanian.
4. Memberikan kanal kontak bagi pengguna yang ingin bertanya, konsultasi, atau membeli bibit.

## 3. Target Pengguna

| Segmen | Kebutuhan |
|---|---|
| Petani pemula/hobi | Info bibit yang cocok & cara menanam |
| Petani berpengalaman | Referensi varietas bibit baru |
| Penyuluh/pelajar pertanian | Bahan edukasi & referensi |
| Calon pembeli bibit | Info kontak untuk pembelian |

---

## 4. Konsep & Prinsip Desain

Go-Tani mengusung kesan **alami, bersih, dan tepercaya** — sesuai citra pertanian modern. Desain dibuat **minimalis (banyak whitespace)**, dengan aksen hijau sebagai warna dominan yang melambangkan tumbuhan, kesuburan, dan pertanian, dipadukan putih agar tampilan tetap ringan, elegan, dan mudah dibaca.

**Prinsip desain:**
- *Less is more* — hindari elemen berlebihan, fokus pada konten & gambar bibit.
- Banyak ruang kosong (whitespace) antar-section.
- Rounded corner lembut pada card/button (kesan ramah, modern).
- Shadow tipis (soft shadow), bukan bayangan tebal/keras.
- Foto/ilustrasi bertema alam & tanaman sebagai elemen visual utama.

**Mood Reference:**
Bayangkan tampilan seperti: banyak whitespace putih bersih, aksen hijau segar pada tombol & highlight, foto tanaman dengan sudut membulat lembut, tipografi rapi dengan hierarki jelas, serta transisi hover yang halus — memberi kesan **profesional namun tetap hangat dan alami**, cocok untuk brand pertanian modern.

---

## 5. Palet Warna

| Nama | Hex | Penggunaan |
|---|---|---|
| **Hijau Utama (Primary)** | `#2E7D32` | Navbar, tombol utama, heading penting |
| **Hijau Muda (Secondary)** | `#66BB6A` | Hover state, aksen, badge kategori |
| **Hijau Pastel (Light)** | `#E8F5E9` | Background section selang-seling |
| **Hijau Gelap (Dark Accent)** | `#1B5E20` | Footer, teks penekanan, border |
| **Putih (Base)** | `#FFFFFF` | Background utama, card |
| **Abu Netral (Teks sekunder)** | `#5F6368` | Teks paragraf/deskripsi |
| **Abu Terang (Border/Divider)** | `#E0E0E0` | Garis pembatas, border input |
| **Hitam Lembut (Teks utama)** | `#212121` | Judul & teks utama |

**Contoh kombinasi penggunaan:**
- Background utama: Putih (`#FFFFFF`)
- Section selang-seling: Hijau Pastel (`#E8F5E9`) agar tidak monoton
- Tombol CTA: Hijau Utama (`#2E7D32`) dengan teks putih, hover ke Hijau Muda (`#66BB6A`)
- Footer: Hijau Gelap (`#1B5E20`) dengan teks putih

---

## 6. Tipografi

| Elemen | Font | Ukuran (Desktop) | Ukuran (Mobile) | Weight |
|---|---|---|---|---|
| Logo/Judul Utama (H1) | Poppins / Montserrat | 42–48px | 28–32px | 700 (Bold) |
| Judul Section (H2) | Poppins | 28–32px | 22–24px | 600 (SemiBold) |
| Sub-judul (H3) | Poppins | 20–22px | 18px | 600 |
| Body Text | Inter / Nunito Sans | 16px | 15px | 400 (Regular) |
| Caption/Label kecil | Inter | 13–14px | 12–13px | 400–500 |
| Tombol (Button) | Poppins | 16px | 15px | 500–600 |

> Rekomendasi Google Fonts: **Poppins** (heading, kesan modern & friendly) + **Inter** atau **Nunito Sans** (body text, mudah dibaca).

- **Line-height:** 1.5–1.6 untuk paragraf agar nyaman dibaca.
- **Letter-spacing judul besar:** sedikit rapat (-0.5px) untuk kesan elegan.

---

## 7. Layout & Struktur Halaman (Single Page Scroll)

```
┌──────────────────────────────────────────┐
│  NAVBAR (sticky, background putih/blur)    │
│  Logo Go-Tani | Beranda Tentang Bibit      │
│                 Blog Kontak                │
├──────────────────────────────────────────┤
│  HERO / BERANDA (bg hijau pastel/gradasi)  │
│  Judul besar + tagline + CTA button        │
│  Ilustrasi/foto tanaman                    │
├──────────────────────────────────────────┤
│  TENTANG (bg putih)                        │
│  Teks kiri + gambar kanan (2 kolom)        │
├──────────────────────────────────────────┤
│  FITUR BIBIT (bg hijau pastel)             │
│  Search bar + filter kategori              │
│  Grid card bibit (3 kolom desktop /        │
│  1 kolom mobile)                           │
├──────────────────────────────────────────┤
│  BLOG (bg putih)                           │
│  Grid card artikel (3 kolom)               │
├──────────────────────────────────────────┤
│  KONTAK (bg hijau pastel)                  │
│  Form kiri + info kontak/map kanan         │
├──────────────────────────────────────────┤
│  FOOTER (bg hijau gelap, teks putih)       │
│  Logo, sosmed, copyright                   │
└──────────────────────────────────────────┘
```

**Grid & Spacing:**
- Container max-width: `1200px`, auto-margin center.
- Padding antar-section: `80px` top-bottom (desktop), `48px` (mobile).
- Gap antar-card: `24px`.
- Border-radius card/button: `12–16px` (kesan lembut & modern).

---

## 8. Komponen UI

### 8.1 Navbar
- Background putih dengan sedikit shadow saat scroll (`box-shadow: 0 2px 8px rgba(0,0,0,0.05)`).
- Logo teks "Go-Tani" warna hijau utama, ikon daun kecil di samping logo.
- Menu link warna abu gelap, berubah hijau saat hover/aktif.
- Versi mobile: menu jadi hamburger icon.

### 8.2 Tombol (Button)
- **Primary:** Background `#2E7D32`, teks putih, radius 30px (pill shape), padding `12px 28px`, hover → `#66BB6A` + sedikit scale-up.
- **Secondary/Outline:** Border hijau `#2E7D32`, teks hijau, background transparan, hover → isi hijau muda pastel.

### 8.3 Card Bibit
- Background putih, radius `16px`, shadow lembut (`0 4px 12px rgba(0,0,0,0.06)`).
- Gambar bibit rasio 4:3 di bagian atas card (rounded top corner).
- Nama bibit (bold), kategori (badge kecil hijau pastel dengan teks hijau tua), deskripsi singkat 2 baris (truncate).
- Tombol "Lihat Detail" kecil di bawah card.
- Hover: card sedikit terangkat (`translateY(-4px)`) + shadow lebih tebal.

### 8.4 Badge Kategori
- Bentuk pill kecil, background `#E8F5E9`, teks `#2E7D32`, font-size 12px.

### 8.5 Form Kontak
- Input field: border tipis abu (`#E0E0E0`), radius 8px, padding nyaman, focus state → border hijau `#2E7D32`.
- Label di atas input, warna abu gelap.
- Tombol submit mengikuti style Primary Button.

### 8.6 Footer
- Background hijau gelap `#1B5E20`, teks putih/abu terang.
- 3 kolom: (1) Logo & deskripsi singkat, (2) Navigasi cepat, (3) Sosial media & kontak.
- Divider tipis putih transparan sebelum copyright.

---

## 9. Ikon & Ilustrasi

- Gunakan ikon **outline/line-style** (bukan solid tebal) agar terkesan ringan — contoh: Feather Icons, Lucide, atau Font Awesome Line.
- Ikon bertema pertanian: daun, biji, matahari, tetes air, keranjang panen.
- Foto: gunakan foto natural (kebun, tangan menanam, bibit di polybag) dengan filter warna sedikit kehijauan agar konsisten dengan tema.

---

## 10. Responsive Behavior

| Breakpoint | Layout |
|---|---|
| Desktop (>1024px) | Grid 3 kolom untuk card bibit/blog, navbar horizontal |
| Tablet (768–1024px) | Grid 2 kolom, navbar tetap horizontal (lebih ringkas) |
| Mobile (<768px) | Grid 1 kolom, navbar jadi hamburger menu, hero teks center |

---

## 11. Ruang Lingkup Fitur (Scope)

Website terdiri dari **satu file HTML** (di-*custom* pada template Blogspot) yang memuat seluruh section berikut dalam satu halaman dengan navigasi *scroll/anchor link*:

1. **Beranda (Home)**
2. **Tentang (About)**
3. **Fitur Bibit (Katalog Bibit — terkoneksi Supabase)**
4. **Blog (Artikel)**
5. **Kontak**

> Catatan: Karena Blogspot pada dasarnya adalah platform blog (multi-post), section "Blog" pada landing page ini akan menampilkan **daftar/preview postingan Blogspot terbaru** (via Blogger JSON Feed API), sedangkan 4 section lain berupa konten statis/dinamis dalam satu halaman (biasanya dibuat sebagai *Page* khusus di Blogspot, bukan post).

---

## 12. Arsitektur Teknis

```
┌─────────────────────────────┐
│         BLOGSPOT             │
│  (Custom HTML/CSS/JS -       │
│   1 file, ditempel di Page)  │
│                               │
│  - Beranda                   │
│  - Tentang                   │
│  - Fitur Bibit  ───────────┐ │
│  - Blog (Blogger Feed API) │ │
│  - Kontak                  │ │
└─────────────────────────────┘ │
                                 │ fetch() via Supabase JS/REST
                                 ▼
                    ┌─────────────────────┐
                    │      SUPABASE         │
                    │  - Database (Postgres)│
                    │  - Tabel: bibit_tanaman│
                    │  - Auto REST API       │
                    │  - (Opsional) Storage  │
                    │    untuk gambar bibit  │
                    └─────────────────────┘
```

**Poin penting keterbatasan Blogspot:**
- Blogspot tidak mendukung server-side code, sehingga koneksi ke Supabase dilakukan **full client-side** via JavaScript `fetch()` memakai **Supabase Anon/Public Key**.
- Karena kunci Supabase bersifat *public-facing* di sisi client, keamanan data harus diatur lewat **Row Level Security (RLS)** di Supabase (hanya izinkan `SELECT` publik, tidak izinkan `INSERT/UPDATE/DELETE` dari publik).
- Semua kode (HTML+CSS+JS) digabung menjadi satu file agar mudah ditempel ke **Theme → Edit HTML** atau ke satu **Page** Blogspot.

---

## 13. Kebutuhan Fitur per Section

### 13.1 Beranda
- Hero banner dengan judul "Go-Tani" + tagline (misal: "Temukan Bibit Terbaik untuk Panen Terbaik").
- Gambar/ilustrasi pertanian.
- Tombol CTA menuju section "Fitur Bibit".
- Navigasi utama (sticky navbar) berisi anchor link: Beranda, Tentang, Bibit, Blog, Kontak.

### 13.2 Tentang
- Deskripsi singkat tentang Go-Tani (visi, misi, latar belakang).
- Value proposition (kenapa memilih Go-Tani).
- Opsional: statistik singkat (jumlah bibit terdaftar, jumlah artikel, dsb — bisa ambil dari Supabase `count`).

### 13.3 Fitur Bibit (Fitur Utama — terkoneksi Supabase)
**Fungsional:**
- Menampilkan daftar bibit dalam bentuk *card grid* (gambar, nama bibit, kategori, harga/estimasi, tombol "Lihat Detail").
- Data diambil real-time dari tabel Supabase via `fetch()`.
- Fitur pencarian (search by nama bibit).
- Fitur filter berdasarkan kategori (misal: sayur, buah, palawija, rempah).
- Modal/pop-up detail bibit berisi: nama, jenis, deskripsi lengkap, musim tanam, cara tanam, masa panen, gambar.
- Loading state saat data sedang diambil, dan pesan error jika koneksi gagal.

**Struktur Tabel Supabase (usulan): `bibit_tanaman`**

| Kolom | Tipe | Keterangan |
|---|---|---|
| id | uuid / int8 (PK) | ID unik |
| nama_bibit | text | Nama bibit tanaman |
| kategori | text | Sayur/Buah/Palawija/Rempah/dll |
| deskripsi | text | Penjelasan umum |
| cara_tanam | text | Panduan menanam |
| musim_tanam | text | Musim yang cocok |
| masa_panen | text | Estimasi masa panen |
| gambar_url | text | URL gambar (Supabase Storage/eksternal) |
| harga_estimasi | numeric | (opsional) |
| stok | bool/int | (opsional) status ketersediaan |
| created_at | timestamp | Default now() |

**RLS Policy yang disarankan:**
- `SELECT`: public/anon diizinkan (read-only).
- `INSERT/UPDATE/DELETE`: hanya role authenticated/admin (dikelola lewat Supabase Studio langsung, bukan dari website publik).

### 13.4 Blog
- Menampilkan daftar artikel terbaru dari Blogspot itu sendiri (memanfaatkan Blogger JSON Feed: `/feeds/posts/default?alt=json`).
- Tiap card artikel: thumbnail, judul, cuplikan (excerpt), tanggal, link "Baca selengkapnya" menuju post asli.
- Opsional: kategori/label artikel (tips menanam, hama & penyakit, berita pertanian, dsb).

### 13.5 Kontak
- Form kontak (nama, email, pesan) — karena Blogspot statis, submit form bisa diarahkan ke:
  - Supabase tabel `pesan_kontak` (insert via anon key dengan RLS insert-only), **atau**
  - Alternatif form handler pihak ketiga (misal Formspree/Google Form) jika ingin lebih sederhana.
- Info kontak langsung: nomor WhatsApp, email, alamat, jam operasional.
- Tautan sosial media (Instagram, Facebook, dsb).

---

## 14. Token CSS (Referensi Implementasi)

```css
:root {
  --color-primary: #2E7D32;
  --color-secondary: #66BB6A;
  --color-light-bg: #E8F5E9;
  --color-dark-accent: #1B5E20;
  --color-white: #FFFFFF;
  --color-text: #212121;
  --color-text-secondary: #5F6368;
  --color-border: #E0E0E0;

  --font-heading: 'Poppins', sans-serif;
  --font-body: 'Inter', sans-serif;

  --radius-card: 16px;
  --radius-button: 30px;
  --shadow-soft: 0 4px 12px rgba(0,0,0,0.06);

  --container-max: 1200px;
  --section-padding: 80px;
}
```

---

## 15. Kebutuhan Non-Fungsional

| Aspek | Kebutuhan |
|---|---|
| Responsif | Wajib mobile-friendly (grid menyesuaikan layar HP/tablet/desktop) |
| Performa | Data bibit di-*lazy load*, gambar dikompres/pakai `loading="lazy"` |
| Keamanan | RLS aktif di Supabase, hanya expose Anon Key (bukan Service Role Key) |
| SEO dasar | Meta title, meta description, alt text gambar |
| Kompatibilitas | Berjalan baik di template Blogspot standar (custom HTML/CSS/JS 1 file) |
| Aksesibilitas | Kontras warna cukup, navigasi jelas, alt text pada gambar |

---

## 16. Batasan (Constraints)

1. Blogspot tidak mendukung backend/server sendiri → semua logic di frontend (JS).
2. Update konten "Fitur Bibit" dilakukan lewat Supabase Studio (dashboard), bukan lewat edit HTML Blogspot berulang kali.
3. Section "Blog" bergantung pada API Blogger resmi (format JSON feed), bukan tabel Supabase.
4. Ukuran & kompleksitas dibatasi karena harus jadi 1 file HTML yang ditempel di Blogspot.

---

## 17. Metode Implementasi (Ringkas)

1. Buat project di Supabase → buat tabel `bibit_tanaman` (& `pesan_kontak` jika perlu) → atur RLS.
2. Ambil `Project URL` dan `Anon Public Key` dari Supabase.
3. Buat 1 file `index.html` berisi seluruh HTML+CSS+JS, dengan script fetch ke Supabase REST endpoint:
   `https://<project-ref>.supabase.co/rest/v1/bibit_tanaman?select=*`
   header: `apikey: <anon_key>` & `Authorization: Bearer <anon_key>`.
4. Tempel isi file tersebut ke Blogspot:
   - Opsi A: Buat **Page baru** di Blogspot → mode HTML → tempel seluruh kode.
   - Opsi B: Edit **Theme HTML** langsung (jika ingin ini jadi halaman utama blog).
5. Uji coba responsivitas & koneksi data di berbagai perangkat.

---

## 18. Metrik Keberhasilan (Success Metrics)

- Website berhasil menampilkan data bibit secara real-time dari Supabase tanpa error.
- Waktu loading section bibit < 3 detik pada koneksi normal.
- Form kontak berhasil mengirim/menyimpan data.
- Tampilan responsif di minimal 3 ukuran layar (mobile, tablet, desktop).
- Tampilan sesuai dengan spesifikasi desain (palet warna, tipografi, komponen UI).

---

## 19. Risiko & Mitigasi

| Risiko | Mitigasi |
|---|---|
| Anon key disalahgunakan untuk manipulasi data | Aktifkan RLS ketat, hanya izinkan SELECT publik |
| Blogspot theme membatasi custom JS | Uji di mode "Simple/Custom HTML" theme dahulu |
| CORS error saat fetch ke Supabase | Supabase secara default mengizinkan CORS untuk REST API, tetap perlu diuji |
| Data kosong/API down | Sediakan pesan fallback "Data tidak dapat dimuat" |

---

## 20. Roadmap Pengembangan Lanjutan (Opsional, di luar scope awal)

- Fitur login user untuk menyimpan bibit favorit.
- Fitur ulasan/rating bibit dari pengguna.
- Integrasi pembayaran/pemesanan bibit online.
- Dashboard admin terpisah untuk kelola data tanpa buka Supabase Studio langsung.

---

*Dokumen ini merupakan gabungan PRD dan Design Specification sebagai acuan lengkap untuk implementasi Go-Tani.*