import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../detail_berita_page.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List _news = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('https://fakenews.squirro.com/news/sport'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _news = data['articles'] ?? [];
          _isLoading = false;
        });
      } else {
        _loadFallbackData();
      }
    } catch (e) {
      _loadFallbackData();
    }
  }

  void _loadFallbackData() {
    setState(() {
      _news = [
        {"title": "Indonesia Siap Hadapi Laga Kualifikasi Asia", "author": "Budi", "description": "Persiapan matang tim nasional sepak bola.", "content": "Konten berita olahraga 1."},
        {"title": "Pembalap Nasional Naik Podium di Mandalika", "author": "Siti", "description": "Prestasi membanggakan di kancah internasional.", "content": "Konten berita olahraga 2."},
        {"title": "Turnamen Bulu Tangkis Indonesia Open Dimulai", "author": "Andi", "description": "Para atlet papan atas berkumpul di Jakarta.", "content": "Konten berita olahraga 3."},
        {"title": "Klub Basket Lokal Cetak Sejarah Baru", "author": "Rian", "description": "Kemenangan beruntun di liga musim ini.", "content": "Konten berita olahraga 4."},
        {"title": "Gaya Hidup Sehat Melalui Lari Marathon", "author": "Eka", "description": "Komunitas lari kota menggelar acara bersama.", "content": "Konten berita olahraga 5."}
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semua Berita (Sport)')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length, // Menampilkan data keseluruhan dari API
              itemBuilder: (context, index) {
                final item = _news[index];
                return ListTile(
                  leading: const Icon(Icons.sports_soccer, color: Colors.blue),
                  title: Text(item['title'] ?? 'No Title'),
                  subtitle: Text('Penulis: ${item['author'] ?? 'Unknown'}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Ketika item diklik, direct ke halaman detail berita (Instruksi No 5)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBeritaPage(article: item),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}