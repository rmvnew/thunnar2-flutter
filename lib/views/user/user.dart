import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunnar_app/common/constants.dart';
import 'package:thunnar_app/services/api_service.dart';

class UserSearchScreen extends StatefulWidget {
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  String _query = '';
  List<dynamic> _users = [];
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  void _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentToken = prefs.getString('token');
    _token = '$currentToken';
  }

  void _search() async {
    final users = await fetchUsers(ApiConstants.user, _token,
        search: 'user_name=$_query');
    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Usuários'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
              onSubmitted: (value) => _search(),
              decoration: InputDecoration(
                labelText: 'Buscar',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              final user = _users[index];
              // Substitua '??' por um valor padrão ou lógica alternativa para campos que podem ser null
              final userName = user['user_name'] ?? 'Nome não disponível';
              final userEmail = user['user_email'] ?? 'E-mail não disponível';

              return ListTile(
                title: Text(userName),
                subtitle: Text(userEmail),
                onTap: () {
                  toast(userName);
                },
              );
            },
          )),
        ],
      ),
    );
  }

  toast(String userName) async {
    Fluttertoast.showToast(
      msg: userName,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
    );
  }
}
