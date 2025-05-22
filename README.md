# Face Detection App

Aplikasi Flutter untuk mendeteksi wajah manusia menggunakan TensorFlow Lite dengan model yang dilatih menggunakan Teachable Machine.

## 📱 Tentang Aplikasi

Aplikasi ini merupakan sample project sederhana yang dapat mendeteksi apakah dalam sebuah gambar terdapat wajah atau tidak. Model machine learning dibuat menggunakan platform [Teachable Machine](https://teachablemachine.withgoogle.com/train/image) dari Google yang mudah digunakan untuk pemula.

## 🚀 Fitur

- Deteksi wajah dari foto kamera
- Deteksi wajah dari galeri
- Interface sederhana dengan floating action buttons
- Menggunakan model TensorFlow Lite untuk performa optimal
- Hasil deteksi real-time

## 📦 Instalasi

1. **Clone repository:**
```bash
git clone https://github.com/yourusername/face-detection.git
cd face-detection
```

2. **Tambahkan file model ke folder `assets/`:**
   - `model_unquant.tflite` (model yang sudah dilatih)
   - `labels.txt` (label untuk klasifikasi)

3. **Install dependencies dan jalankan aplikasi:**
```bash
flutter pub get
flutter run
```

## 🛠️ Requirements

- Flutter 3.0+
- Perangkat Android/iOS
- File model dari Teachable Machine
- Kamera atau akses galeri

## 🧠 Cara Membuat Model

1. Kunjungi [Teachable Machine](https://teachablemachine.withgoogle.com/train/image)
2. Pilih "Image Project" → "Standard image model"
3. Buat dua kelas:
   - **Class 1:** "Wajah" (upload gambar dengan wajah)
   - **Class 2:** "Bukan Wajah" (upload gambar tanpa wajah)
4. Train model dengan menekan tombol "Train Model"
5. Export model:
   - Pilih "TensorFlow Lite"
   - Download "Unquantized" model
   - Rename file menjadi `model_unquant.tflite`

## ⚙️ Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.1.2
  camera: ^0.10.0+5
  tflite_v2: ^1.0.0
```

## 📁 Struktur Project

```
face-detection/
├── lib/
│   ├── main.dart
│   └── ... (other dart files)
├── assets/
│   ├── model_unquant.tflite
│   └── labels.txt
├── pubspec.yaml
└── README.md
```

## 🎯 Cara Penggunaan

1. Buka aplikasi
2. Tekan tombol kamera untuk mengambil foto baru
3. Atau tekan tombol galeri untuk memilih foto yang sudah ada
4. Aplikasi akan menampilkan hasil deteksi: "Face" atau "No Face"

## 📝 Catatan Penting

- Menggunakan model unquantized untuk akurasi yang lebih baik
- Model ini hanya sample dan mungkin membutuhkan data training yang lebih banyak untuk hasil optimal
- Aplikasi mendukung pengambilan gambar dari kamera dan galeri
- Interface sederhana cocok untuk pembelajaran dan pengembangan lebih lanjut

## 🔧 Troubleshooting

**Model tidak load:**
- Pastikan file `model_unquant.tflite` dan `labels.txt` ada di folder `assets/`
- Cek `pubspec.yaml` untuk memastikan assets sudah terdaftar

**Kamera tidak bisa diakses:**
- Pastikan permission kamera sudah diberikan
- Cek pengaturan aplikasi di device

## 📄 License

Project ini dibuat untuk tujuan pembelajaran dan sample development.

## 🤝 Kontribusi

Silakan buat pull request atau issue untuk perbaikan dan pengembangan aplikasi ini.

---

**Catatan:** Ini adalah project sample untuk pembelajaran machine learning dan Flutter development. Model yang digunakan dibuat menggunakan Teachable Machine dan mungkin membutuhkan peningkatan untuk penggunaan production.