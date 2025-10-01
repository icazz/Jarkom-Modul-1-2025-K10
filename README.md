# lapres-jarkom-modul1-k10
## Anggota
| Nama                      | NRP        |
| --------------------------| ---------- |
| Bayu Kurniawan            | 5027241055 |
| Ica Zika Hamizah          | 5027241058 |

## Pembahasan soal
### Nomor 1
Pertama buat rangkaian, seperti dibawah ini

![rangkaian](assets/rangkaian.png)

### Nomor 2
Config Eru sebagai router ke switch 1 dan switch 2
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.216.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.216.2.1
    netmask 255.255.255.0
```

lalu tambahkan config ke /root/.bashrc
```
apt update && apt install -y iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.216.0.0/16
echo "nameserver 192.168.122.1" > /etc/resolv.conf
```

### Nomor 3
Setiap perangkat harus punya ip, config masing masing client dulu

- Melkor
```
auto eth0
iface eth0 inet static
    address 192.216.1.2
    netmask 255.255.255.0
    gateway 192.216.1.1
```

- Manwe
```
auto eth0
iface eth0 inet static
    address 192.216.1.3
    netmask 255.255.255.0
    gateway 192.216.1.1
```

- Varda
```
auto eth0
iface eth0 inet static
    address 192.216.2.2
    netmask 255.255.255.0
    gateway 192.216.2.1
```

- Ulmo
```
auto eth0
iface eth0 inet static
    address 192.216.2.3
    netmask 255.255.255.0
    gateway 192.216.2.1
```

### Nomor 4
Semua client terhubung ke internet, agar terhubung jalankan
`echo "nameserver 192.168.122.1" > /etc/resolv.conf`

Cek dengan ping google, jika berhasil maka sudah tersambung ke internet dan cek `ip a` pastikan ip sudah benar di masing-masing client

### Nomor 5
edit `/root/.bashrc`, isi dengan config seperti apt update, apt install sesuai kebutuhan. Agar jika di restart package yang di download tidak hilang

### Nomor 6
Masuk ke manwe dengan cara `telnet 10.15.43.32 port`

Lalu download file yang sudah disediakan (traffic.sh).
Setelah terdownload jangan lupa di unzip lalu ubah permissionnya dulu agar bisa di execute. Setelah itu, jalankan filenya dan jangan lupa capture dengan wireshark

![rangkaian](assets/6_traffic.png)

MASUKIN HASIL CAPTURE WIRESHARK

### Nomor 7
Pertama buat dulu 2 user baru yaitu ainur dan malkor, ainur bisa mengakses folder shared sedangkan malkor tidak bisa mengakses folder shared.
![rangkaian](assets/7_adduser.png)

Setelah user berhasil dibuat, buat folder shared seperti gambar dibawah.
gunakan `usermod` untuk langsung menuju folder tujuan, jadi ketika d=kedua user login, akan diarahkan langsung ke `/srv/ftp/shared`.
Lalu ubah permission owner dengan `chown` agar ainur bisa membaca dan menulis di folder `shared`.
Buat permission folder shared menjadi 700, artinya hanya owner yang bisa mengakses folder `shared`.

Lalu buat file untuk mengetes apakah user ainur bisa read and write. Buat file di folder shared dan buat juga di root.
![rangkaian](assets/7_setup.png)

Coba login dengan user ainur, dan tes dengan `put` dan `get`.
Seperti gambar dibawah, ainur bisa read dan write di folder shared
![rangkaian](assets/7_ainur_login.png)

Lalu coba login dengan user melkor, dan ternyata user tidak bisa login. karena suda di set tujuan setelah login langsung masuk ke folder `shared`, maka login langsung ditolak, artinya melkor tidak bisa read dan write di folder tersebut sesuai dengan ketentuan soal.
![rangkaian](assets/7_melkor_login.png)

### Nomor 8
Pertama download dulu file `ramalan-cuaca.zip` di ulmo (maaf di gambar 'elmo' karena salah ketik) lalu unzip.

Lalu masuk di eru untuk start ftp dengan command berikut
`service vsftpd start`.

Kembali lagi ke elmo, lalu upload file yang sudah diekstrak tadi yakni `cuaca.txt` dan `mendung.jpg` menggunakan `put`.
Hasilnya bisa dilihat pada gambar dibawah, berhasil upload 2 file tersebut ke server ftp.

![rangkaian](assets/8_elmo_upload.png)

### Nomor 9
Pertama download dulu file di eru lalu start vsftpd-nya. Lalu aktifkan ftp dan upload file kitab_penciptaan.txt ke server.

Lalu pindah ke manwe dan jalankan ftp, login menggunakan user ainur lalu unduh file kitab_penciptaan.txt dari server.

Karena di soal diperintahkan untuk ubah akses agar ainur hanya bisa read, maka balik ke eru dan masukkan command `chmod 555 /srv/ftp/shared` lalu jangan lupa restart vsftpd.

Masuk ke ulmo lagi dan coba untuk upload file ke server, login dengan user ainur.

Hasilnya pasti failed, karena ainur memiliki akses read-only.

![rangkaian](assets/9_eru_upload.png)
![rangkaian](assets/9_manwe_download.png)
![rangkaian](assets/9_cek_akses_ainur.png)

### Nomor 10
Melkor melakukan ping ke eru
`ping 192.216.1.1 -c 100`
Berikut hasilnya:
![rangkaian](assets/10_hasil.png)

Analisis
- Packet Loss
Dari 100 paket yang dikirim, semua diterima (100 received). Jadi tidak ada packet loss (0%).

- Average Round Trip Time (RTT)
Nilai rata-rata RTT adalah 0.442 ms. Nilai ini tergolong sangat kecil → menunjukkan jaringan stabil.

- Dampak ke Eru
Karena tidak ada packet loss dan RTT tetap rendah, maka spam ping 100 paket tidak mempengaruhi kinerja Eru secara signifikan. Artinya server Eru masih bisa merespon normal meskipun mendapat banyak request ICMP dari Melkor.

### Nomor 11
Pertama download dulu package yang dibutuhkan yakni telnet
Lalu ubah confignya di file `/etc/inetd.conf`
cari bagian seperti ini, pastikan tidak ter-comment
```
telnet stream tcp nowait root /usr/sbin/tcpd /usr/sbin/telnetd
```
Selanjutnya coba login di eru dengan ip `telnet 192.216.1.2`. Lalu login sesuai user yang tadi di daftarkan, jika berhasil maka hasilnya seperti gambar dibawah ini.
![rangkaian](assets/11_config.png)

Setelah setup siap, start atau restart openbsd-inetd, lalu masukkan user baru dengan menggunakan useradd di ssh. Lalu jangan lupa ubah passwordnya.
![rangkaian](assets/11_user.png)

![rangkaian](assets/11_login.png)

### Nomor 12
Pertama identifikasi port yang terbuka, port 21 ternyata memakai ftp dan port 80, 666 memakai apache2.

Download dulu ftp dan apache2 dengan command dibawah ini
```
apt install netcat-openbsd
service vsftpd start
```
Setelah itu start keduanya, cek port 21, 80, dan 666. Hasilnya seperti pada gambar bahwa port 21 dan 80 terbuka sedangkan 666 tertutup.
![rangkaian](assets/12_port.png)

### Nomor 13
Untuk step pertama, download ssh dulu, jika sudah start servicenya.
lalu coba cari apakah ssh sudah menyala dan tersedia menggunakan command `netstat -tuln | grep :22`
Setelah itu, coba login menggunakan user ainur seperti dibawah ini.
![rangkaian](assets/13_eru.png)
![rangkaian](assets/13_varda_login.png)

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
- gunakan filter '_ws.col.protocol == "USBHID"' untuk menampilkan report dari penggunaan USB. Dari payload kita bisa temukan bahwa device yang digunakan adalah Keyboard.
<img width="1885" height="689" alt="image" src="https://github.com/user-attachments/assets/87678bbe-5dce-4762-9180-43126eb9849d" />


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

- menggunakan filter **tls** kita bisa menemukan banyak paket dengan protocol TLS.
<img width="1919" height="643" alt="image" src="https://github.com/user-attachments/assets/472f9a7e-785c-45b8-9bf0-1e14b5efe324" />
sayangnya informasi yang ditampilkan hanya **Application Data**. Hal ini berarti packet tersebut telah di enkripsi sehingga perlu di dekripsi terlebih dahulu.

- Pada menu **Edit -> Preference -> Protocols -> TLS -> (Pre)-Master-Secret log filename** pilih file **keyslogfile.txt** yang kita dapatkan dari soal.
<img width="1245" height="425" alt="image" src="https://github.com/user-attachments/assets/fe5873ab-d018-4fff-966d-8aa6ae974557" />
<img width="923" height="281" alt="image" src="https://github.com/user-attachments/assets/3c0242ec-d042-41e9-affa-c551b54df626" />

- setelah file keyslogfile.txt diimport, maka kini packet yang tadinya hanya berisi informasi **Application Data** kini berubah menjadi **[TLS Segment of a reassambled PSU]**
<img width="1919" height="660" alt="image" src="https://github.com/user-attachments/assets/aa0ce22e-dfbd-41ec-a78c-4bbe40d15a5d" />


