# Course Explorer v2 - Flutter UI Fundamentals

**Student ID:** 2415051101  
**Name:** Jack Rich Loro  

---

## Architecture & Separation of Concerns

Proyek ini menerapkan arsitektur modular berstruktur dengan alur ketergantungan (*dependency direction*) sebagai berikut:
`Screen / Widget` -> `Provider` -> `Repository` -> `Service / Data Source`

### Tanggung Jawab Setiap Folder (`lib/`):

1. **`models/`**: Mendefinisikan struktur data terstruktur (`Course`) dan metode serialisasi/deserialisasi JSON (`fromJson`).
2. **`services/`**: Menangani detail teknis pengambilan data mentah, seperti membaca aset lokal (`rootBundle.loadString`) atau parsing JSON dasar.
3. **`repositories/`**: Menyediakan lapisan abstraksi data untuk Provider, mengisolasi logika sumber data (*Service*) dari *state management*.
4. **`providers/`**: Mengelola *application state* (`isLoading`, `error`, `courses`, `favorites`), memanggil *repository*, dan memicu pembaruan antarmuka via `notifyListeners()`.
5. **`screens/`**: Menyusun tata letak halaman utama dan navigasi responsif (`MainNavigationScreen`, `CourseScreen`, `CourseDetailScreen`, `FavoritesScreen`).
6. **`widgets/`**: Menyimpan komponen *UI* modular yang dapat digunakan kembali (*reusable*), seperti `CourseCard`.