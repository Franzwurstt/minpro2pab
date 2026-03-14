# Aplikasi Katalog Smartphone Samsung
Nama: Prakasa Wira Mukti  
NIM: 2409116054  
Kelas: B 2024  

## Deskripsi Project


## Fitur Aplikasi
**1. Fitur Autentikasi (Keamanan Pengguna)**    
- Registrasi Akun (Sign Up): Pengguna baru dapat membuat akun menggunakan kombinasi email dan password.

- Validasi Registrasi: Mencegah user mendaftar jika format email salah, password kurang dari 6 karakter, atau password tidak cocok dengan kolom konfirmasi.

- Login Akun (Sign In): Masuk ke dalam aplikasi menggunakan akun yang sudah terdaftar di Supabase.

- Auto-Login (Session Check): Jika user sebelumnya sudah login dan belum logout, aplikasi akan otomatis melompat ke halaman Beranda (HomePage) tanpa menyuruh user login ulang saat aplikasi dibuka.

- Logout: Keluar dari sesi akun dan kembali ke halaman Login.

**2. Manajemen Data Produk (CRUD)**    
- Tambah Data (Create): Menginput produk baru dengan detail lengkap: Nama HP, Harga, Tahun Rilis, URL Gambar, dan Spesifikasi.

- Tampil Data (Read): Menampilkan daftar smartphone yang akan ter-update secara instan (live) di layar jika ada perubahan data, karena ada teknologi Stream dari Supabase.

- Edit Data (Update): Mengubah data produk yang sudah ada. Saat tombol edit ditekan, form akan otomatis terisi dengan data lama agar mudah diperbaiki.

- Hapus Data (Delete): Menghapus produk dari database langsung melalui ikon tempat sampah di masing-masing kartu produk.

**3. UI/UX**    
- Tema Terang & Gelap (Light/Dark Mode): Terdapat tombol di pojok kanan atas (AppBar) untuk mengubah warna latar dan teks aplikasi sesuai kenyamanan mata pengguna.

- Desain Kartu: Menampilkan produk dalam bentuk kotak-kotak (Grid Card) menggunakan widget Wrap, sehingga tampilannya rapi baik saat dibuka di PC maupun di HP.

- Custom Typography: Tampilan tulisan menggunakan jenis font Outfit dari paket Google Fonts.

- Empty State: Jika database kosong (belum ada produk), aplikasi tidak hanya menampilkan layar putih, melainkan menampilkan ikon HP abu-abu beserta teks pesan "Tambah Dulu".

- Indikator Loading: Menampilkan ikon loading memutar (CircularProgressIndicator) saat sistem sedang memproses login, register, atau menyimpan data, agar user tahu aplikasi sedang bekerja.

- Sistem Notifikasi (Snackbar): Memunculkan pop-up notifikasi di bawah layar (Warna Hijau jika sukses, Warna Merah jika gagal/ada kesalahan input).

**4. Validasi & Format Data**    
- Currency Formatter: Saat user mengetik angka di kolom Harga, sistem akan otomatis menambahkan titik setiap 3 angka (misal: mengetik 15000 otomatis menjadi 15.000).

- Format Tampilan Rupiah di Beranda: Harga murni dari database (misal: 10000000) otomatis diformat menjadi Rp 10.000.000 saat ditampilkan di kartu produk.

- Parsing: fitur untuk menghapus titik pada harga sebelum dikirim ke database, agar Supabase bisa menyimpannya sebagai angka (Integer).

- Blokir Input Huruf: Kolom Harga dan Tahun dikunci hanya untuk keyboard angka (digitsOnly).

- Validasi Form Kosong: Sistem menolak proses simpan jika ada satupun kolom (Nama, Harga, dsb) yang masih kosong.

## Widget Yang Digunakan   
**1. Widget Layout & Structure**  
- Scaffold : Kerangka dasar halaman. Menyediakan tempat untuk AppBar, body, dan FloatingActionButton.

- AppBar : Bar navigasi di bagian atas layar (menampilkan judul halaman, tombol tema, dan tombol logout).

- Container : Kotak fleksibel yang bisa diberi styling. Dipakai untuk membuat warna gradien pada AppBar dan kotak bingkai gambar.

- Column : Menyusun widget secara vertikal (dari atas ke bawah). Sangat sering dipakai di form dan isi kartu produk.

- Row : Menyusun widget secara horizontal (menyamping). Dipakai untuk menata posisi deretan tombol (Edit dan Hapus).

- SizedBox : Digunakan untuk memberikan jarak kosong (spacing) antar elemen, atau memberikan ukuran pasti pada suatu widget.

- Center : Memosisikan widget tepat di tengah layar (seperti teks "Tambah Dulu" atau ikon loading).

- Padding : Memberikan ruang atau bantalan di bagian dalam widget agar konten tidak menempel ke tepi layar atau tepi kartu.

- SingleChildScrollView : Membuat area layar bisa di-scroll ke bawah (mencegah error overflow jika form sangat panjang atau layar HP kecil).

- Wrap : Widget pintar yang Anda gunakan di HomePage untuk menyusun Card ke samping, dan otomatis menurunkannya ke baris baru jika lebar layar sudah tidak muat (membuat aplikasi jadi responsif).

**2. Widget Visual Component**  
- Text : Untuk menampilkan semua tulisan (Judul, Harga, Spesifikasi, dll).

- Icon : Untuk menampilkan ikon-ikon bawaan Material Design (ikon gembok, email, hapus, edit, logout, matahari/bulan).



 - Image.network : Menampilkan gambar smartphone yang bersumber dari URL internet/Supabase.

 - Image.memory : Menampilkan preview gambar sementara yang baru saja dipilih dari galeri HP/PC sebelum di-upload.

- Card : Membuat kotak dengan efek bayangan (elegan) untuk membungkus data setiap produk di halaman beranda.

- ClipRRect : Memotong ujung gambar agar menjadi tumpul/melengkung (rounded corners) agar terlihat modern dan serasi dengan bingkai Card.

**3. Widget Input & Button**  
- TextField : Kolom tempat pengguna mengetik teks atau angka (Input Email, Password, Nama HP, Harga, Tahun, Spesifikasi).

- ElevatedButton : Tombol utama dengan efek timbul dan warna solid (Tombol "Login", "Buat Akun", "Simpan", "Update").

- OutlinedButton : Tombol sekunder dengan garis pinggir namun tanpa warna latar belakang (Tombol "Belum punya akun? Register").

- IconButton : Tombol yang hanya berupa ikon tanpa kotak/teks (Tombol Edit, Hapus, Logout, dan Tema).

- FloatingActionButton (FAB) : Tombol utama yang melayang di sudut kanan bawah layar (Tombol "Tambah" di halaman Beranda).

- GestureDetector : Widget tak terlihat yang berfungsi mendeteksi sentuhan/ketukan. Digunakan pada area gambar di form agar saat diklik bisa membuka galeri.

**4. Widget State Management & Utilitas Tersembunyi**  
- MaterialApp : Widget akar (root) yang membungkus seluruh aplikasi, mengatur tema global (font, warna gelap/terang), dan rute.

- StreamBuilder : Widget super yang mendengarkan aliran data (stream) dari Supabase. Ia bertugas me-refresh UI secara otomatis setiap kali ada perubahan data di database.

- ValueListenableBuilder : Mendengarkan perubahan variabel tema (Terang/Gelap) dan langsung mengubah tampilan aplikasi tanpa perlu reload manual.

- CircularProgressIndicator : Animasi lingkaran berputar yang menandakan aplikasi sedang memproses sesuatu (Loading saat login, register, atau menyimpan data).  

## Setup Supabase  
Agar kode main.dart Anda bisa terhubung dengan database yang baru saja dibuat, harus memasukkan kuncinya:

Di menu sebelah kiri, klik Project Settings (ikon gir paling bawah). Pilih menu API Keys.
Di sana Anda akan melihat Publishable key dan copy(ini akan digunakan sebagai anon key).
Lalu buka Data API. Copy url yang ada di API URL

Buka file main.dart di laptop Anda, lalu copy-paste kedua kode tersebut ke bagian ini:  
Dart  
  await Supabase.initialize(  
    url: 'COPY_URL_PROJECT_ANDA_DI_SINI',   
    anonKey: 'COPY_ANON_KEY_ANDA_DI_SINI',  
  );  

## Cara Penggunaan Singkat  

**1. Memulai Aplikasi (Login & Register)**   
- Membuat Akun: Saat pertama kali membuka aplikasi, Anda akan berada di halaman Login. Jika belum memiliki akun, klik tombol "Belum punya akun? Register". Masukkan email dan password Anda, lalu klik Buat Akun.

- Masuk Aplikasi: Setelah berhasil mendaftar, kembali ke halaman awal. Masukkan email dan password yang baru saja dibuat, kemudian klik Login. (Aplikasi akan mengingat akun Anda, jadi Anda tidak perlu login ulang saat membuka aplikasi esok hari).

**2. Menjelajahi Beranda (Home)**  
- Setelah login, Anda akan masuk ke halaman Beranda. Di sini Anda bisa melihat:

- Daftar Produk: Semua smartphone yang sudah didata akan tampil dalam bentuk kotak-kotak (card) yang rapi.

- Ubah Tema (Terang/Gelap): Di pojok kanan atas layar, terdapat ikon Matahari atau Bulan. Klik ikon tersebut jika Anda ingin mengubah warna latar aplikasi menjadi gelap (Dark Mode) agar mata tidak cepat lelah, atau sebaliknya.

**3. Menambahkan HP Baru ke Katalog**  
- Klik tombol "+" (Tambah) berwarna biru yang melayang di pojok kanan bawah layar.

- Anda akan dibawa ke halaman Tambah Katalog.

- Isi Data: Ketik Nama HP, Harga, Tahun Rilis, dan Spesifikasi.
(Catatan: Saat mengetik harga jutaan, titik pemisah ribuan akan muncul secara otomatis, misal: 15.000.000).

- Upload Gambar: Klik kotak abu-abu yang bertuliskan "Pilih Gambar dari Perangkat". Galeri atau file explorer Anda akan terbuka. Pilih foto HP yang ingin di-upload.

- Jika semua sudah terisi, klik tombol Simpan. Anda akan otomatis kembali ke Beranda dan HP baru tersebut akan langsung muncul di layar!

**4. Mengedit Data (Update)**  
- Jika ada kesalahan penulisan atau perubahan harga, Anda tidak perlu menghapus datanya.

- Cari HP yang ingin diubah di halaman Beranda.

- Klik ikon Pensil/Edit berwarna biru yang ada di dalam kartu HP tersebut.

- Halaman form akan terbuka dengan data yang sudah terisi. Silakan ubah bagian yang diperlukan (misalnya mengganti harga atau memilih gambar baru).

- Klik tombol Update untuk menyimpan perubahan.

**5. Menghapus Data (Delete)**  
- Jika HP sudah tidak dijual atau ingin dihapus dari katalog:

- Cari kartu HP tersebut di halaman Beranda.

- Klik ikon Tempat Sampah berwarna merah.

- Data akan langsung terhapus dan hilang dari layar Beranda secara otomatis.

**6. Keluar dari Aplikasi (Logout)**  
Jika Anda sudah selesai bertugas atau ingin berganti akun admin lain, klik ikon Pintu Keluar/Logout yang terletak di pojok kanan atas layar sebelah tombol Tema. Anda akan dikembalikan ke halaman Login.

## Struktur Folder
 
 

## Screenshot Aplikasi





