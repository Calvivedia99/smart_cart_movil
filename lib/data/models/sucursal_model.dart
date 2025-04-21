class Sucursal {
  final int id;
  final String nombre;
  final String telefono;
  final String direccion;

  Sucursal({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.direccion,
  });

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      direccion: json['direccion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'direccion': direccion,
    };
  }
}