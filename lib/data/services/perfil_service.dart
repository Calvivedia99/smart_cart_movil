import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/perfil_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class PerfilService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/perfil';

  // Obtener un perfil por ID
  static Future<Perfil?> obtener(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        return Perfil.fromJson(jsonData);
      } else {
        throw Exception('Perfil no encontrado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener perfil: $e');
    }
  }

  // Crear un nuevo perfil
  static Future<bool> crear(Perfil perfil) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(perfil.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al crear perfil: $e');
    }
  }

  // Actualizar un perfil
  static Future<bool> actualizar(int id, Perfil perfil) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(perfil.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar perfil: $e');
    }
  }

  // Eliminar un perfil
  static Future<bool> eliminar(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error al eliminar perfil: $e');
    }
  }
}