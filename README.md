# Aplikasi Katalog Smartphone Samsung
Nama: Prakasa Wira Mukti  
NIM: 2409116054  
Kelas: B 2024  

## Deskripsi Project  
Aplikasi Katalog Smartphone Samsung adalah sebuah platform digital berbasis mobile yang dirancang untuk mengelola dan mendokumentasikan informasi lini smartphone Samsung secara sistematis. Dibangun dengan antarmuka pengguna (UI) bergaya monokrom yang adaptif terhadap Dark/Light Mode, aplikasi ini memiliki navigasi layaknya etalase digital. Pengguna yang terautentikasi dapat dengan mudah melakukan manajemen data secara real-time mulai dari menambahkan informasi handphone samsung, melihat spesifikasi detail dan harga, memperbarui informasi, hingga menghapus data katalog yang sudah tidak relevan.

## Struktur Folder  
samsung/  
│  
├── lib/  
│   ├── models/  
│   │   └── katalog.dart           
│   │  
│   ├── pages/                      
│   │   ├── form_page.dart         
│   │   ├── home_page.dart         
│   │   ├── login_page.dart        
│   │   └── register_page.dart    
│   │  
│   └── main.dart  

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

- Edit Data (Update): Mengubah data produk yang sudah ada. Saat tombol edit ditekan, form akan otomatis terisi dengan data lama agar mudah diganti.

- Hapus Data (Delete): Menghapus produk dari database langsung melalui ikon tempat sampah di masing masing card produk.

**3. UI/UX**    
- Desain Monokrom Adaptif: Aplikasi sekarang menggunakan skema warna hitam dan putih. Warna latar belakang, tombol, dan teks akan berganti saat pengguna mengganti mode Terang ke Gelap.

- Grid Layout Produk: Daftar HP tersusun rapi menjadi sejajar dengan ukuran tinggi yang sama rata (fixed height) menggunakan sistem Grid.

- Dilengkapi dengan ornamen visual seperti Bintang Rating dan Indikator Varian Warna yang ada. Terdapat juga Tombol Varian Memori (256 GB, 512 GB, 1 TB) yang interaktif. Saat pengguna memilih kapasitas memori yang lebih besar, harga produk yang tertera di bagian bawah kartu akan otomatis berubah.

- Pop-up Detail Spesifikasi (Dialog): Fitur interaktif baru di mana pengguna bisa menekan tombol melengkung "Lebih detail" untuk memunculkan kotak pop-up yang berisi informasi tahun rilis dan spesifikasi lengkap dari database.

- Tombol edit dan hapus: Tombol edit dan hapus sekarang dirubah dari segi warna menjadi abu abu di pojok kanan atas gambar HP agar tidak terlihat mengganggu estetika cardnya.

**4. Validasi & Format Data**    
- Currency Formatter: Saat user mengetik angka di kolom Harga, sistem akan otomatis menambahkan titik setiap 3 angka (misal: mengetik 15000 otomatis menjadi 15.000).

- Format Tampilan Rupiah di Beranda: Harga murni dari database (misal: 10000000) otomatis diformat menjadi Rp 10.000.000 saat ditampilkan di kartu produk.

- Parsing: fitur untuk menghapus titik pada harga sebelum dikirim ke database, agar Supabase bisa menyimpannya sebagai angka (Integer).

- Blokir Input Huruf: Kolom Harga dan Tahun dikunci hanya untuk keyboard angka (digitsOnly).

- Validasi Form Kosong: Sistem menolak proses simpan jika ada satupun kolom (Nama, Harga, dsb) yang masih kosong.

## Widget Yang Digunakan   
**1. Widget Struktur & Tata Letak (Layout)**  
Widget ini berfungsi sebagai kerangka untuk mengatur letak posisi elemen di layar.

- Scaffold : Kanvas utama untuk setiap halaman. Menyediakan ruang untuk AppBar, body, dan FloatingActionButton.

- AppBar : Bar navigasi di bagian atas layar (menampilkan judul, tombol tema, dan logout).

- Container : Digunakan untuk membuat badge memori (512GB/256GB) dan membungkus kartu HP.

- Column : Menyusun elemen secara vertikal (dari atas ke bawah). Contoh: Menyusun TextField di halaman Form/Login.

- Row : Menyusun elemen secara horizontal (menyamping). Contoh: Menyusun bintang rating, titik warna, dan tombol Edit/Hapus.

- Stack : Menumpuk beberapa widget. Digunakan di kartu produk agar tombol Edit/Hapus bisa melayang di atas gambar HP.

- Positioned : Digunakan untuk mengatur posisi spesifik (misal: ditaruh tepat di pojok kanan atas).

- Padding : Memberikan jarak di bagian dalam konten agar tidak menempel ke pinggir layar.

- SizedBox : Memberikan jarak kosong antar elemen (sebagai spasi), atau untuk "memaksa" ukuran gambar/kotak agar spesifik.

- Spacer : Widget elastis yang mendorong elemen lain. Digunakan di dalam kartu produk agar Harga dan Tombol "Lebih detail" selalu terdorong ke bagian paling bawah, tidak peduli seberapa panjang nama HP-nya.

- SingleChildScrollView : Membuat area layar bisa di-scroll ke bawah.

- GridView.builder : Widge pembuat grid. Mengatur daftar HP agar terlihat rapi menjadi kolom dengan tinggi yang seragam.

**2. Widget Visual & Tampilan (UI Components)**  
Widget ini adalah elemen yang langsung dilihat oleh mata pengguna.

- Text : Untuk menampilkan semua tulisan (Judul, Harga, Spesifikasi, dll).

- Icon : Untuk menampilkan grafis ikon bawaan (gembok, email, bintang rating, sun/moon, dll).

- Image.network : Mengambil dan menampilkan gambar HP langsung dari URL internet/Supabase.

- CircleAvatar : Membuat bentuk lingkaran sempurna. Digunakan untuk membuat bulatan-bulatan kecil varian warna HP (Hitam, Abu, Biru).

**3. Widget Tombol & Input (Inputs & Actions)**  
Widget ini berfungsi untuk interaksi user (diketik atau diklik).

- TextField : Kolom tempat pengguna mengetik teks (Email, Password, Nama HP, Harga, dsb).

- ElevatedButton : Tombol utama (Tombol Login, Buat Akun, Simpan). 

- OutlinedButton : Tombol sekunder dengan garis tepi (Tombol "Lebih detail" di Beranda dan "Belum punya akun" di Login).

- IconButton : Tombol yang murni berupa ikon tanpa kotak/teks (Tombol Tema, Logout, Edit, dan Hapus).

- TextButton : Tombol berupa teks sederhana tanpa batas (border). Digunakan untuk tombol "Tutup" pada pop-up spesifikasi.

- FloatingActionButton : Tombol utama berbentuk bulat yang selalu melayang di sudut kanan bawah Beranda (Tombol Tambah +).

**4. Widget Dialog & Notifikasi**  
- AlertDialog : Muncul lewat fungsi showDialog(). Ini adalah kotak pop-up melayang di tengah layar yang muncul saat Anda mengklik tombol "Lebih detail" untuk membaca spesifikasi.  
    
**5. Widget Logika & State Management**  
Widget ini mengurus aliran data dan perubahan status layar.

- MaterialApp :root widget di file main.dart yang membungkus seluruh aplikasi dan mengatur tema global (font, dark mode).

- StreamBuilder : Widgetyang mendengarkan database Supabase. Kalau ada data ditambah/dihapus, makan akan otomatis me-refresh daftar HP tanpa perlu refresh secara manual.

- ValueListenableBuilder : Mendengarkan klik pada tombol Dark/Light Mode dan secara instan mengubah warna seluruh aplikasi tanpa perlu refresh halaman.
  
- StatefulBuilder & GestureDetector: Diaplikasikan di dalam kartu produk untuk menangkap sentuhan interaktif (HitTestBehavior.opaque) pada kotak varian memori (256GB/512GB/1TB). Widget ini memungkinkan setiap kartu memperbarui status yang dipilih dan menghitung ulang harga secara real-time.
  
- CircularProgressIndicator : Animasi lingkaran mutar yang muncul saat aplikasi sedang loading (loading login, register, atau menyimpan data ke server). 

## Setup Supabase  

**1. Membuat Project Baru di Supabase**    
- Disini saya membuat New Project, lalu pilih Organization.
- Lalu saya memberi nama project,membuat Database Password, dan memiilih Region server.

**2. Menghubungkan ke Supabase**    
- Di menu sebelah kiri, klik Project Settings (ikon gir paling bawah). Pilih menu API Keys.
- Di sana akan terlihat Publishable key dan copy(ini akan digunakan sebagai anon key).
- Lalu buka Data API. Copy url yang ada di API URL
- Buat file .env di root project dan paste url dan anon key nya(lihat contoh di .env):  
SUPABASE_URL=YOUR_SUPABASE_URL  
SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY  

**3. Mengaktifkan Fitur Autentikasi (Login & Register)**  
Karena aplikasi memiliki LoginPage dan RegisterPage, saya menyalakan fitur Email Auth dengan cara:  

- Ke menu kiri Supabase, masuk ke menu Authentication > Providers.
- Klik Email untuk Enable Email provider.
- lalu saya mematikan toggle Confirm email agar tidak perlu repot memverifikasi email asli setiap kali membuat akun dummy di halaman Register.  
<img width="960" height="470" alt="Image" src="https://github.com/user-attachments/assets/5c446bc2-e302-4268-a3f9-b845f4d2f8bd" />

**4. Membuat Database (Tabel katalog)**   
- Di menu kiri Supabase, saya masuk ke Table Editor, lalu saya klik Create a new table.  
- Saya mematikan centang Enable Row Level Security (RLS) untuk sementara waktu agar bisa melakukan CRUD (Create, Read, Update, Delete) dari aplikasi tanpa halangan 
- Lalu saya menambahkan tabel beserta kolomnya yaitu:

    - id - Biasanya sudah ada otomatis.
    - created_at - Biasanya sudah ada otomatis.
    - nama
    - harga
    - tahun
    - gambar
    - spesifikasi  
<img width="229" height="245" alt="Image" src="https://github.com/user-attachments/assets/da7cbf5b-3469-4e85-a90d-7588c1fc7de8" />

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

## Cara Menjalankan Project  
- Clone repository:  
git clone https://github.com/Franzwurstt/minpro2pab.git  
cd minpro2pab  


- Install dependencies:  
flutter pub get


- Jalankan aplikasi:  
flutter run


## Screenshot Aplikasi
**1. Light Mode**
- tampilan page login (kalau belum buat akun register terlebih dahulu)
<img width="960" height="511" alt="Image" src="https://github.com/user-attachments/assets/535fc600-13d4-4a08-916f-e0f56b9f89eb" />

- tampilan page register
<img width="960" height="509" alt="Image" src="https://github.com/user-attachments/assets/1e1ef656-9fac-45be-b02c-ca11aed05887" />

- balik ke page login kalau sudah registrasi akun
<img width="960" height="509" alt="Image" src="https://github.com/user-attachments/assets/5d187c82-f988-4e7c-843e-50794fccaa8c" />

- tampilan home page (belum ada katalognya)
<img width="959" height="509" alt="Image" src="https://github.com/user-attachments/assets/effbcbd3-98f3-40bd-a039-38fbafe5f2ef" />

- tampilan form page (buat isi data smartphone)
<img width="960" height="506" alt="Image" src="https://github.com/user-attachments/assets/880c612f-5d2b-411e-84e9-cb6de01fa0bb" />

- tampilan home page setelah diisi data (bisa memilih storage handphone)
<img width="957" height="509" alt="Image" src="https://github.com/user-attachments/assets/9b8e92ce-a367-41df-9a62-64cc5eeec25f" />

<img width="960" height="509" alt="Image" src="https://github.com/user-attachments/assets/e25be059-bdbb-4abb-9a3f-fd866b9f2ff1" />

- tampilan detail spesifikasi
<img width="960" height="508" alt="Image" src="https://github.com/user-attachments/assets/7d4effb5-ae2f-4c2f-8b1a-9bb82d848a38" />

- tampilan edit page
<img width="960" height="509" alt="Image" src="https://github.com/user-attachments/assets/a1cb7b54-ef7c-4c4f-9607-fe2a7faaf71e" />

- tampilan setelah delete 
<img width="960" height="509" alt="Image" src="https://github.com/user-attachments/assets/cb853c9b-aab8-4175-9578-2d61511e1162" />

**2. Dark Mode**
- mode gelap (untuk mengaktifkan darkmode klik logo bulan)
<img width="960" height="509" alt="Image" src="https://github.com/user-attachments/assets/7a781c68-ee58-43c2-b34c-8e6021ed0a52" />
<img width="960" height="446" alt="Image" src="https://github.com/user-attachments/assets/a68c215f-354e-4ea5-96b9-8d918730a66d" />

- tampilan darkmode lainnya

<img width="958" height="508" alt="Image" src="https://github.com/user-attachments/assets/f409599b-8907-4d07-8e6d-256056e75f31" />

<img width="959" height="509" alt="Image" src="https://github.com/user-attachments/assets/d2ecacdc-4f38-48cf-a153-a945e09c13cc" />

<img width="960" height="508" alt="Image" src="https://github.com/user-attachments/assets/fd231e40-94ba-439e-8a77-15245c543230" />

<img width="959" height="508" alt="Image" src="https://github.com/user-attachments/assets/43cb7b81-a948-48c9-8360-e0e44b7d0c8c" />

## Dataset dari Supabase
- data email dummy dan data hp
<img width="910" height="350" alt="Image" src="https://github.com/user-attachments/assets/42d7039d-d3a8-40fe-8fb2-d83264a8aa53" />

<img width="914" height="335" alt="Image" src="https://github.com/user-attachments/assets/fc19e11d-8b46-4c8c-bd44-963195c58400" />





