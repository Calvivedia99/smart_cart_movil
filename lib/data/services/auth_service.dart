import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class AuthService {
  // Login de usuario
  static Future<Map<String, dynamic>> login(
    String usuario,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'usuario': usuario, 'password': password}),
      );

      final json = jsonDecode(response.body);

      if (json['success']) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', json['data']['access']);
        await prefs.setString('user_name', json['data']['name']);
        await prefs.setString('user_rol', json['data']['rol']);
        await prefs.setInt('user_id', json['data']['user_id']); 

        return json;
      } else {
        return json;
      }
    } catch (e) {
      return {"success": false, "message": "Error de red: $e"};
    }
  }

  /// Registro de usuario
  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> data,
  ) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/register/');
      var request =
          http.MultipartRequest('POST', uri)
            ..fields['name'] = data['name']
            ..fields['email'] = data['email']
            ..fields['password'] = data['password']
            ..fields['nombre'] = data['nombre']
            ..fields['apellido'] = data['apellido']
            ..fields['telefono'] = data['telefono']
            ..fields['sexo'] = data['sexo']
            ..files.add(
              await http.MultipartFile.fromPath('url_foto', data['url_foto']),
            );

      // Send request and get response
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);

      return json;
    } catch (e) {
      return {"success": false, "message": "Error de red: $e"};
    }
  }

  /// Cierre de sesión
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
