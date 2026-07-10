import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../detail_berita_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      _news = List.generate(5, (index) => {
        "title": "Berita Utama Olahraga #${index + 1}",
        "author": "Redaksi Sport",
        "description": "Ini adalah deskripsi singkat berita utama ke-${index + 1} untuk halaman Beranda.",
        "content": "Ini adalah isi konten lengkap berita utama ke-${index + 1}."
      });
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home - 5 Berita Terbaru')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              // Menampilkan maksimal hanya 5 data berita sesuai instruksi nomor 4
              itemCount: _news.length > 5 ? 5 : _news.length,
              itemBuilder: (context, index) {
                final item = _news[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(item['title'] ?? 'No Title', maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(item['description'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBeritaPage(article: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}