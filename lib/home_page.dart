import 'package:flutter/material.dart';
// import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
// Buat variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> buku = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Panggil fungsi untuk fetchbook
  }

// Fungsi untuk mengambil data buku dari Supabase
  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client.from('buku').select();

    setState(() {
      buku = List<Map<String, dynamic>>.from(response);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar buku'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: fetchBooks,
            ),
          ],
        ),
        body: buku.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: buku.length,
                itemBuilder: (context, index) {
                  final book = buku[index];
                  return ListTile(
                    title: Text(
                      book['judul'] ?? 'Tidak ada judul',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['penulis'] ?? 'Tidak ada penulis',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        Text(
                          book['deskripsi'] ?? 'Tidak ada deskripsi',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 13),
                        )
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
