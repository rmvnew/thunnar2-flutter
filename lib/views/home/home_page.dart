import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunnar_app/views/login/login_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            
            ElevatedButton(onPressed: (){
              deslogar();
            }, child: const Text('Deslogar'))
          ]),
        )
        ),
      
    );
  }


  deslogar()async {


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('token');

    if(!mounted) return;

    Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const LoginPage()
          )
        );


  }

}