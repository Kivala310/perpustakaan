import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://fhzegdpraccgghyyjgge.supabase.co',
      anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZoemVnZHByYWNjZ2doeXlqZ2dlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1NTMxNTksImV4cCI6MjA0NzEyOTE1OX0.rrw8vrEMUhj2J2L6ERuxQ-28D6OjdDLjbrV0fxipUOk');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digital Library',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
