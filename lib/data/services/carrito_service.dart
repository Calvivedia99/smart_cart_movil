import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_cart_movil/data/models/carrito.dart';
import 'package:smart_cart_movil/data/services/api_config.dart';

class CarritoService {
  static final String _baseUrl = '${ApiConfig.baseUrl}/carritos';

  // Listar todos los carritos
  static Future<List<Carrito>> getAllCarritos() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body)['data'];
        return json.map((e) => Carrito.fromJson(e)).toList();
      } else {
        throw Exception('Error al obtener los carritos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Obtener un carrito por ID
  static Future<Carrito?> getCarritoById(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id/'));
      if (response.statusCode == 200) {
        return Carrito.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Carrito no encontrado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // Crear un nuevo carrito
  static Future<bool> createCarrito(Carrito carrito) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/crear/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(carrito.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error al crear el carrito: $e');
    }
  }

  // Actualizar un carrito
  static Future<bool> updateCarrito(int id, Carrito carrito) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/actualizar/$id/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(carrito.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar el carrito: $e');
    }
  }

  // Eliminar un carrito
  static Future<bool> deleteCarrito(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/eliminar/$id/'));
      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Error al eliminar el carrito: $e');
    }
  }
}