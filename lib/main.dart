import 'package:flutter/material.dart';
import 'package:thunnar_app/views/Wellcome/bemvindo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diario',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3:true,
        primarySwatch: Colors.blue
      ),
      home: const BemVindoPage(),
    );
  }
}



