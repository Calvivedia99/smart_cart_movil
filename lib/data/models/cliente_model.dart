// lib/data/models/cliente_model.dart

class Cliente {
  final int id;
  final String carnetIdentidad;
  final String nombre;
  final String apellido;
  final String telefono;
  final String sexo;

  Cliente({
    required this.id,
    required this.carnetIdentidad,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.sexo,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      carnetIdentidad: json['carnet_identidad'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      sexo: json['sexo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carnet_identidad': carnetIdentidad,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'sexo': sexo,
    };
  }
}
