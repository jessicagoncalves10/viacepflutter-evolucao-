import 'package:cep_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false,
    return MaterialApp(
      title: 'Busca CEP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 68)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
