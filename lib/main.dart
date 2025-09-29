import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wireframe Buku Novel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const MenuUtama(),
    );
  }
}

// ==================== PHONE MOCKUP ====================
class PhoneMockup extends StatelessWidget {
  final Widget child;
  const PhoneMockup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 520,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              // Status bar palsu
              Container(
                height: 22,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "9:41",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.signal_cellular_4_bar, size: 12),
                        SizedBox(width: 2),
                        Icon(Icons.wifi, size: 12),
                        SizedBox(width: 2),
                        Icon(Icons.battery_full, size: 12),
                      ],
                    ),
                  ],
                ),
              ),
              // Isi halaman
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== MENU UTAMA ====================
class MenuUtama extends StatelessWidget {
  const MenuUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: PhoneMockup(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "📚 Menu Utama Buku Novel",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _menuButton(context, "Tambah Buku", TambahBukuPage()),
                _menuButton(context, "Lihat Daftar Buku", LihatDaftarPage()),
                _menuButton(context, "Hapus Buku", HapusBukuPage()),
                _menuButton(context, "Keluar", KeluarPage()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String label, Widget page) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[400],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(label),
      ),
    );
  }
}

// ==================== TAMBAH BUKU ====================
class TambahBukuPage extends StatelessWidget {
  TambahBukuPage({super.key});

  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PhoneMockup(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Tambah Buku",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _inputField("Judul Buku", judulController),
              _inputField("Penulis", penulisController),
              _inputField("Tahun Terbit", tahunController),
              _inputField("Genre", genreController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Buku berhasil ditambahkan (dummy)!"),
                    ),
                  );
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }
}

// ==================== LIHAT DAFTAR ====================
class LihatDaftarPage extends StatelessWidget {
  const LihatDaftarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyBuku = List.generate(5, (i) => "Novel ke-${i + 1}");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PhoneMockup(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: dummyBuku.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.book_outlined),
                title: Text(dummyBuku[index]),
                subtitle: const Text("Penulis tidak diketahui"),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==================== HAPUS BUKU ====================
class HapusBukuPage extends StatelessWidget {
  const HapusBukuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyBuku = List.generate(6, (i) => "Novel ${i + 1}");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PhoneMockup(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: dummyBuku.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text(dummyBuku[index])),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Icon(Icons.delete, color: Colors.red[400]),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ==================== KELUAR ====================
class KeluarPage extends StatelessWidget {
  const KeluarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PhoneMockup(
        child: const Center(
          child: Text(
            "Terima kasih!\nAnda telah keluar dari aplikasi.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
