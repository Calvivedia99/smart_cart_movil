// lib/data/models/producto_model.dart

class Producto {
  final int id;
  final String nombre;
  final double precio;
  final int stock;
  final bool status;
  final String? urlFoto;
  final String categoriaNombre;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.status,
    this.urlFoto,
    required this.categoriaNombre,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      precio: json['precio'],
      stock: json['stock'],
      status: json['status'],
      urlFoto: json['url_foto'],
      categoriaNombre: json['categoria_nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
      'status': status,
      'url_foto': urlFoto,
      'categoria_nombre': categoriaNombre,
    };
  }
}
