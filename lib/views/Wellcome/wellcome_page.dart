import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunnar_app/views/home/home_page.dart';
import 'package:thunnar_app/views/login/login_page.dart';

class WellcomePage extends StatefulWidget {
  const WellcomePage({super.key});

  @override
  WellcomePageState createState() => WellcomePageState();
}

class WellcomePageState extends State<WellcomePage> {


  @override
  void initState() {
    
    super.initState();

    verificarUsuario().then((temUsuario) {
      if(temUsuario){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()), 
          );
      }else{
       Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()), 
          );
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Bem vindo à página ok!')),
    ); // Adicionado o ponto-e-vírgula aqui
  }


  Future<bool> verificarUsuario() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if(token == null){
      return false;
    }else{
      return true;
    }
  }
}
