import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> fetchAuthToken(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://monkfish-app-umzoc.ondigitalocean.app/api/user/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String authToken = data['authToken']; 
    print(authToken);// Assuming the token key in the response JSON is 'token'.
    return authToken;
  } else {
    return null;
  }
}
