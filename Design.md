# Design Specification (UI/UX)
# Go-Tani — Website Rekomendasi Bibit Tanaman

**Versi:** 1.0
**Tanggal:** 22 September 2026
**Tema:** Hijau & Putih — Simple, Clean, Elegan

---

## 1. Konsep Desain

Go-Tani mengusung kesan **alami, bersih, dan tepercaya** — sesuai citra pertanian modern. Desain dibuat **minimalis (banyak whitespace)**, dengan aksen hijau sebagai warna dominan yang melambangkan tumbuhan, kesuburan, dan pertanian, dipadukan putih agar tampilan tetap ringan, elegan, dan mudah dibaca.

**Prinsip desain:**
- *Less is more* — hindari elemen berlebihan, fokus pada konten & gambar bibit.
- Banyak ruang kosong (whitespace) antar-section.
- Rounded corner lembut pada card/button (kesan ramah, modern).
- Shadow tipis (soft shadow), bukan bayangan tebal/keras.
- Foto/ilustrasi bertema alam & tanaman sebagai elemen visual utama.

---

## 2. Palet Warna

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

## 3. Tipografi

| Elemen | Font | Ukuran (Desktop) | Ukuran (Mobile) | Weight |
|---|---|---|---|---|
| Logo/Judul Utama (H1) | Poppins / Montserrat | 42–48px | 28–32px | 700 (Bold) |
| Judul Section (H2) | Poppins | 28–32px | 22–24px | 600 (SemiBold) |
| Sub-judul (H3) | Poppins | 20–22px | 18px | 600 |
| Body Text | Inter / Nunito Sans | 16px | 15px | 400 (Regular) |
| Caption/Label kecil | Inter | 13–14px | 12–13px | 400–500 |
| Tombol (Button) | Poppins | 16px | 15px | 500–600 |

> Rekomendasi Google Fonts: **Poppins** (heading, kesan modern & friendly) + **Inter** atau **Nunito Sans** (body text, mudah dibaca).

**Line-height:** 1.5–1.6 untuk paragraf agar nyaman dibaca.
**Letter-spacing judul besar:** sedikit rapat (-0.5px) untuk kesan elegan.

---

## 4. Layout & Struktur Halaman (Single Page Scroll)

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

## 5. Komponen UI

### 5.1 Navbar
- Background putih dengan sedikit shadow saat scroll (`box-shadow: 0 2px 8px rgba(0,0,0,0.05)`).
- Logo teks "Go-Tani" warna hijau utama, ikon daun kecil di samping logo.
- Menu link warna abu gelap, berubah hijau saat hover/aktif.
- Versi mobile: menu jadi hamburger icon.

### 5.2 Tombol (Button)
- **Primary:** Background `#2E7D32`, teks putih, radius 30px (pill shape), padding `12px 28px`, hover → `#66BB6A` + sedikit scale-up.
- **Secondary/Outline:** Border hijau `#2E7D32`, teks hijau, background transparan, hover → isi hijau muda pastel.

### 5.3 Card Bibit
- Background putih, radius `16px`, shadow lembut (`0 4px 12px rgba(0,0,0,0.06)`).
- Gambar bibit rasio 4:3 di bagian atas card (rounded top corner).
- Nama bibit (bold), kategori (badge kecil hijau pastel dengan teks hijau tua), deskripsi singkat 2 baris (truncate).
- Tombol "Lihat Detail" kecil di bawah card.
- Hover: card sedikit terangkat (`translateY(-4px)`) + shadow lebih tebal.

### 5.4 Badge Kategori
- Bentuk pill kecil, background `#E8F5E9`, teks `#2E7D32`, font-size 12px.

### 5.5 Form Kontak
- Input field: border tipis abu (`#E0E0E0`), radius 8px, padding nyaman, focus state → border hijau `#2E7D32`.
- Label di atas input, warna abu gelap.
- Tombol submit mengikuti style Primary Button.

### 5.6 Footer
- Background hijau gelap `#1B5E20`, teks putih/abu terang.
- 3 kolom: (1) Logo & deskripsi singkat, (2) Navigasi cepat, (3) Sosial media & kontak.
- Divider tipis putih transparan sebelum copyright.

---

## 6. Ikon & Ilustrasi

- Gunakan ikon **outline/line-style** (bukan solid tebal) agar terkesan ringan — contoh: Feather Icons, Lucide, atau Font Awesome Line.
- Ikon bertema pertanian: daun, biji, matahari, tetes air, keranjang panen.
- Foto: gunakan foto natural (kebun, tangan menanam, bibit di polybag) dengan filter warna sedikit kehijauan agar konsisten dengan tema.

---

## 7. Responsive Behavior

| Breakpoint | Layout |
|---|---|
| Desktop (>1024px) | Grid 3 kolom untuk card bibit/blog, navbar horizontal |
| Tablet (768–1024px) | Grid 2 kolom, navbar tetap horizontal (lebih ringkas) |
| Mobile (<768px) | Grid 1 kolom, navbar jadi hamburger menu, hero teks center |

---

## 8. Contoh Token CSS (Referensi Implementasi)

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

## 9. Mood Reference (Deskripsi Visual)

Bayangkan tampilan seperti: banyak whitespace putih bersih, aksen hijau segar pada tombol & highlight, foto tanaman dengan sudut membulat lembut, tipografi rapi dengan hierarki jelas, serta transisi hover yang halus — memberi kesan **profesional namun tetap hangat dan alami**, cocok untuk brand pertanian modern.

---

*Dokumen desain ini menjadi acuan visual saat implementasi kode HTML/CSS satu file untuk Blogspot.*