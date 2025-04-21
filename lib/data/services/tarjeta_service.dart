import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/tarjeta_model.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class TarjetaService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/tarjetas';

  // Listar todas las tarjetas
  static Future<List<TarjetaDebito>> listar() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((e) => TarjetaDebito.fromJson(e)).toList();
      } else {
        throw Exception('Error al listar tarjetas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Obtener una tarjeta por ID
  static Future<TarjetaDebito?> obtener(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'];
        return TarjetaDebito.fromJson(jsonData);
      } else {
        throw Exception('Tarjeta no encontrada: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Registrar una nueva tarjeta
  static Future<bool> crear(TarjetaDebito tarjeta) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tarjeta.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al registrar tarjeta: $e');
    }
  }

  // Actualizar la información de una tarjeta
  static Future<bool> actualizar(int id, TarjetaDebito tarjeta) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(tarjeta.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar tarjeta: $e');
    }
  }

  // Eliminar una tarjeta por su ID
  static Future<bool> eliminar(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error al eliminar tarjeta: $e');
    }
  }
}