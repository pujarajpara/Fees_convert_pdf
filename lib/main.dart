// ignore_for_file: library_private_types_in_public_api



import 'package:flutter/material.dart';


import 'PdfGenerationPage.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Receipt Form',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Receipt Form'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: const PdfGenerationPage(),
      ),
    );
  }
}
