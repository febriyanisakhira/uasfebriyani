import 'package:flutter/material.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  // Simulasi fetch data dari API olahraga sesuai link soal
  Future<List<Map<String, String>>> fetchSportsNews() async {
    await Future.delayed(const Duration(seconds: 1)); // Efek loading
    return [
      {"title": "Timnas Indonesia Raih Kemenangan Besar", "desc": "Pertandingan sengit berakhir dengan skor maut di stadion utama.", "date": "10 Juli 2026"},
      {"title": "Grand Prix Akhir Pekan Ini Siap Digelar", "desc": "Para pembalap top sudah tiba di sirkuit untuk sesi latihan bebas.", "date": "09 Juli 2026"},
      {"title": "Juara Bertahan Tumbang di Babak Perempat Final", "desc": "Kejutan besar terjadi di turnamen tenis internasional tahun ini.", "date": "08 Juli 2026"},
      {"title": "Strategi Baru Klub Basket Menghadapi Musim Depan", "desc": "Pelatih kepala mengumumkan perombakan formasi besar-besaran.", "date": "07 Juli 2026"},
      {"title": "Penyelenggaraan Maraton Sukses Diikuti Ribuan Peserta", "desc": "Acara tahunan ini berhasil memecahkan rekor jumlah peserta terbanyak.", "date": "06 Juli 2026"},
    ];
  }

  // Fungsi menampilkan detail menggunakan Dialog (Sesuai instruksi soal no 5)
  void showDetailDialog(BuildContext context, String title, String desc, String date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Tanggal: $date", style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                Text(desc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Berita Olahraga')),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchSportsNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final beritaList = snapshot.data ?? [];
          
          return ListView.builder(
            itemCount: beritaList.length,
            itemBuilder: (context, index) {
              final berita = beritaList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.sports_soccer, color: Colors.blue),
                  title: Text(berita['title']!, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(berita['date']!),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => showDetailDialog(
                    context, 
                    berita['title']!, 
                    berita['desc']!, 
                    berita['date']!
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}