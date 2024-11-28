import 'package:flutter/material.dart';
// import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'insert.dart';

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
      backgroundColor: const Color.fromRGBO(120, 179, 206, 1),
      appBar: AppBar(
        title: const Text('Daftar buku'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchBooks,
          ),
        ],
        backgroundColor: const Color.fromRGBO(201, 230, 240, 1),
      ),
      body: buku.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: buku.length,
              itemBuilder: (context, index) {
                final book = buku[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(251, 248, 239, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
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
                  ),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            // Navigate to the insert page and await the result
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBookPage()),
            );

            // If the result is true, refresh the book list
            if (result == true) {
              fetchBooks();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.add, color: Colors.white)],
          ),
        ),
      ),
    );
  }
}
