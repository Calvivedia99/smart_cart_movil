import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/usuario_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class UsuarioService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/usuarios';

  // Listar todos los usuarios
  static Future<List<Usuario>> listar() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((e) => Usuario.fromJson(e)).toList();
      } else {
        throw Exception('Error al listar usuarios: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Obtener un usuario por ID
  static Future<Usuario?> obtener(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        return Usuario.fromJson(jsonData);
      } else {
        throw Exception('Usuario no encontrado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Crear un nuevo usuario
  static Future<bool> crear(Usuario usuario) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(usuario.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al crear usuario: $e');
    }
  }

  // Actualizar un usuario
  static Future<bool> actualizar(int id, Usuario usuario) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(usuario.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar usuario: $e');
    }
  }

  // Eliminar un usuario
  static Future<bool> eliminar(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error al eliminar usuario: $e');
    }
  }
}