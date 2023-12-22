import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunnar_app/views/Wellcome/wellcome_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _clearSharedPreferences();
  runApp(const MyApp());
}

Future<void> _clearSharedPreferences() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  print("SharedPreferences cleared");
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
      home: const WellcomePage(),
    );
  }
}



