import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thunnar_app/common/constants.dart';

Future<List<dynamic>> fetchUsers(String query, String token,
    {String? search}) async {
  var currentSearch = search != null ? '?$search' : '';

  print(ApiConstants.baseUrl + query + currentSearch);

  final response = await http.get(
    // Uri.parse('SUA_URL_API/usuarios?q=$query'),
    Uri.parse(ApiConstants.baseUrl + query + currentSearch),
    headers: {
      'Authorization': token,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> decoded = json.decode(response.body);
    return List<dynamic>.from(decoded['items']);
  } else {
    throw Exception('Falha ao carregar usuários');
  }
}
