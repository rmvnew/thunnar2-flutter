import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunnar_app/common/constants.dart';
import 'package:thunnar_app/views/Wellcome/wellcome_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _verSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  label: Text('E-mail'), hintText: 'Digite seu e-mail'),
              validator: (email) {
                if (email == null || email.isEmpty) {
                  return 'Digite seu  email!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _senhaController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_verSenha,
              decoration: InputDecoration(
                  label: const Text('Senha'),
                  hintText: 'Digite sua senha',
                  suffixIcon: IconButton(
                    icon: Icon(_verSenha
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () {
                      setState(() {
                        _verSenha = !_verSenha;
                      });
                    },
                  )),
              validator: (senha) {
                if (senha == null || senha.isEmpty) {
                  return 'Digite sua  senha';
                } else if (senha.length < 5) {
                  return 'Senha deve ter mais que 6 digitos';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
                child: const Text('Entrar'))
          ]),
        ),
      )),
    );
  }

  Future<void> login() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);

      var response = await http.post(url, body: {
        'email': _emailController.text,
        'password': _senhaController.text
      });

      if (response.statusCode == 200) {
        var token = json.decode(response.body)['access_token'];
        await sharedPreferences.setString('token', 'Bearer $token');

        if (!mounted) return;

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const WellcomePage()));
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('email ou senha inválidos'),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
              'Não foi possível conectar ao servidor. Tente novamente mais tarde.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
