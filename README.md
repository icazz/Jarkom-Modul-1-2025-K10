# lapres-jarkom-modul1-k10

### 14. Setelah gagal mengakses FTP, Melkor melancarkan serangan brute force terhadap  Manwe. Analisis file capture yang disediakan dan identifikasi upaya brute force Melkor. (link file) nc 10.15.43.32 3401

penyelesaian :
- gunakan display filter ‘http’ kemudian cari username dan password yang berhasil didapatkan dari brute force degnan cara mencari packet terakhir.
<img width="1312" height="177" alt="image" src="https://github.com/user-attachments/assets/c793244c-9fc7-40a3-a907-47a5cdd287ed" />
- gunakan Follow -> HTTP Stream untuk melihat informasi lainnya seperti username, password, credentials dll.
<img width="563" height="430" alt="image" src="https://github.com/user-attachments/assets/31c5aebe-13f9-454d-830a-8739b153b54c" />
<img width="540" height="119" alt="image" src="https://github.com/user-attachments/assets/527f86d7-37f7-47c0-bc33-40d29a907ee5" />

- dari informasi tersebut dapat digunakan untuk menyelesaikan soal yang ada.
<img width="1124" height="517" alt="image" src="https://github.com/user-attachments/assets/8b4d6b45-cd24-4719-b37b-dd4c3b5dfe99" />

### 15. Melkor menyusup ke ruang server dan memasang keyboard USB berbahaya pada node Manwe. Buka file capture dan identifikasi pesan atau ketikan (keystrokes) yang berhasil dicuri oleh Melkor untuk menemukan password rahasia. (link file) nc 10.15.43.32 3402

penyelesaian :

### 16. Melkor semakin murka ia meletakkan file berbahaya di server milik Manwe. Dari file capture yang ada, identifikasi file apa yang diletakkan oleh Melkor. (link file) nc 10.15.43.32 3403

penyelesaian :
- gunakan display filter ‘ftp’ untuk melacak file yang berbahaya dengan menggunakan Follow -> TCP Stream sehingga menampilkan informasi sebagai berikut.
<img width="710" height="259" alt="image" src="https://github.com/user-attachments/assets/a14291c8-5950-4250-a878-b5bddc24c8bd" />
<img width="423" height="757" alt="image" src="https://github.com/user-attachments/assets/88dba394-40ba-457d-be57-cf6b493f725b" />

- dari sana kita juga menemukan 5 file yang diduga mengandung malware. diantaranya:  q.exe, w.exe, e.exe, r.exe, dan t.exe

Dalam mode PASV FTP server mengirim tuple (a,b,c,d,p1,p2) di mana a.b.c.d adalah alamat IP dan p1/p2 adalah dua byte yang mewakili port 16-bit. Port TCP/UDP disimpan dalam dua byte: byte tinggi (high byte) dan byte rendah (low byte). Nilai numeriknya dihitung sebagai:

port = (high_byte * 256) + low_byte

contoh: kita ingin mencari port dimana file q.exe bisa didapatkan. kita bisa menggunakan perhitungan diatas sehingga didapatkan port dari hasil perhitungan dari persamaan berikut
q.exe — (...,199,145)

High_byte = 199, Low_byte = 145

port = 199 * 256 + 145

Jadi port = 51,089.

- gunakan port tersebut sebagai filter lalu pilih salah satu package dengan isi q.exe
<img width="1876" height="247" alt="image" src="https://github.com/user-attachments/assets/a69e5613-27ea-4e52-b3d3-c7dd7acc3e12" />
- simpan file dengan cara Follow -> TCP Stream -> ganti tampilannya dari ASCII ke Raw -> simpan dengan nama file 'q.exe'
<img width="1269" height="304" alt="image" src="https://github.com/user-attachments/assets/a4283fd6-91ac-4848-8813-b886aad6cef2" />
- lakukan hashing terhadap file tersebut sehingga mendapatkan hasil seperti gambar di bawah.
<img width="907" height="50" alt="image" src="https://github.com/user-attachments/assets/11085287-e1a6-4dcf-98ba-3198494c92a5" />

- ulangi tahap diatas pada file w.exe, e.exe, r.exe, dan t.exe.

- gunakan semua informasi yang ada untuk mendapatkan flag untuk soal ini.
<img width="1259" height="534" alt="image" src="https://github.com/user-attachments/assets/26d2f860-4480-4ca9-8293-87135d871486" />

### 17. Manwe membuat halaman web di node-nya yang menampilkan gambar cincin agung. Melkor yang melihat web tersebut merasa iri sehingga ia meletakkan file berbahaya agar web tersebut dapat dianggap menyebarkan malware oleh Eru. Analisis file capture untuk menggagalkan rencana Melkor dan menyelamatkan web Manwe. (link file) nc 10.15.43.32 3404

penyelesaian :
- gunakan display filter ‘http’ untuk mendapatkan package dengan protokol http, kita dapat menemukan file-file mencurigakan dengan cara melihatnya melalui file -> export objects -> http.
<img width="1504" height="170" alt="image" src="https://github.com/user-attachments/assets/fca2ae87-f463-4a24-bb53-19e997018ce2" />
<img width="1499" height="341" alt="image" src="https://github.com/user-attachments/assets/156ac358-a1e6-49c3-92fd-62f776ff6a5e" />
- informasi tersebut dapat digunakan untuk mendapatkan flag dengan cara melakukan hashing pada file knr.exe
<img width="1316" height="568" alt="image" src="https://github.com/user-attachments/assets/d888e435-15b6-49a2-9cbb-67476e7b7eb9" />

### 18. Karena rencana Melkor yang terus gagal, ia akhirnya berhenti sejenak untuk berpikir. Pada saat berpikir ia akhirnya memutuskan untuk membuat rencana jahat lainnya dengan meletakkan file berbahaya lagi tetapi dengan metode yang berbeda. Gagalkan lagi rencana Melkor dengan mengidentifikasi file capture yang disediakan agar dunia tetap aman. (link file) nc 10.15.43.32 3405

penyelesaian :

### 19. Manwe mengirimkan email berisi surat cinta kepada Varda melalui koneksi yang tidak terenkripsi. Melihat hal itu Melkor sipaling jahat langsung melancarkan aksinya yaitu meneror Varda dengan email yang disamarkan. Analisis file capture jaringan dan gagalkan lagi rencana busuk Melkor. (link file) nc 10.15.43.32 3406

penyelesaian :
- gunakan display filter ‘smtp’ untuk melacak email yang dikirimkan dan kita dapat melihat pesan yang dikirimkan dengan cara Follow -> TCP stream.
 <img width="1564" height="374" alt="image" src="https://github.com/user-attachments/assets/9cf8b637-d768-4424-b408-874e4a13a1c9" />
 <img width="1560" height="270" alt="image" src="https://github.com/user-attachments/assets/aa36ab37-c88b-4a20-86c6-7ef36052ae4a" />
- gunakan informasi yang sudah didapatkan untuk menemukan flag pada soal ini.
<img width="1529" height="516" alt="image" src="https://github.com/user-attachments/assets/4997909d-15b9-477b-b3c2-db340617736b" />

### 20. Untuk yang terakhir kalinya, rencana besar Melkor yaitu menanamkan sebuah file berbahaya kemudian menyembunyikannya agar tidak terlihat oleh Eru. Tetapi Manwe yang sudah merasakan adanya niat jahat dari Melkor, ia menyisipkan bantuan untuk mengungkapkan rencana Melkor. Analisis file capture dan identifikasi kegunaan bantuan yang diberikan oleh Manwe untuk menggagalkan rencana jahat Melkor selamanya. (link file) nc 10.15.43.32 3407
