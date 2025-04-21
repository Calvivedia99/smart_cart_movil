class Ubicacion {
  final int id;
  final String nroCasa;
  final String nombre;
  final String? descripcion;
  final double latitud;
  final double longitud;
  final int userId;

  Ubicacion({
    required this.id,
    required this.nroCasa,
    required this.nombre,
    this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.userId,
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) {
    return Ubicacion(
      id: json['id'],
      nroCasa: json['nro_casa'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nro_casa': nroCasa,
      'nombre': nombre,
      'descripcion': descripcion,
      'latitud': latitud,
      'longitud': longitud,
      'user_id': userId,
    };
  }
}