import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/viaje_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class ViajeService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/viajes';

  // Listar todos los viajes
  static Future<List<Viaje>> listar() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((e) => Viaje.fromJson(e)).toList();
      } else {
        throw Exception('Error al listar viajes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Obtener un viaje por ID
  static Future<Viaje?> obtener(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        return Viaje.fromJson(jsonData);
      } else {
        throw Exception('Viaje no encontrado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Crear un nuevo viaje
  static Future<bool> crear(Viaje viaje) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(viaje.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al crear viaje: $e');
    }
  }

  // Actualizar un viaje
  static Future<bool> actualizar(int id, Viaje viaje) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(viaje.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar viaje: $e');
    }
  }

  // Eliminar un viaje
  static Future<bool> eliminar(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error al eliminar viaje: $e');
    }
  }
}