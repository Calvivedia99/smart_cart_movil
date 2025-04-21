import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/sucursal_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class SucursalService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/sucursales';

  // Listar todas las sucursales
  static Future<List<Sucursal>> listar() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((e) => Sucursal.fromJson(e)).toList();
      } else {
        throw Exception('Error al listar sucursales: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Obtener una sucursal por ID
  static Future<Sucursal?> obtener(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        return Sucursal.fromJson(jsonData);
      } else {
        throw Exception('Sucursal no encontrada: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Crear una nueva sucursal
  static Future<bool> crear(Sucursal sucursal) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(sucursal.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al crear sucursal: $e');
    }
  }

  // Actualizar una sucursal
  static Future<bool> actualizar(int id, Sucursal sucursal) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(sucursal.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar sucursal: $e');
    }
  }

  // Eliminar una sucursal
  static Future<bool> eliminar(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error al eliminar sucursal: $e');
    }
  }
}