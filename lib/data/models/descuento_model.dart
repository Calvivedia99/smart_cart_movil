class Descuento {
  final int id;
  final String nombre;
  final double porcentaje;
  final DateTime? fechaInicio; 
  final DateTime? fechaFinal; 
  final bool activo;

  Descuento({
    required this.id,
    required this.nombre,
    required this.porcentaje,
    this.fechaInicio, 
    this.fechaFinal, 
    required this.activo,
  });

  factory Descuento.fromJson(Map<String, dynamic> json) {
    return Descuento(
      id: json['id'],
      nombre: json['nombre'],
      porcentaje: (json['porcentaje'] as num).toDouble(),
      fechaInicio: json['fecha_inicio'] != null
          ? DateTime.parse(json['fecha_inicio']) 
          : null,
      fechaFinal: json['fecha_final'] != null
          ? DateTime.parse(json['fecha_final']) 
          : null,
      activo: json['activo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'porcentaje': porcentaje,
      'fecha_inicio': fechaInicio?.toIso8601String(), 
      'fecha_final': fechaFinal?.toIso8601String(), 
      'activo': activo,
    };
  }
}