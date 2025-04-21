class Viaje {
  final int id;
  final DateTime fecha;
  final String horaInicio;
  final String horaLlegada;
  final int notaVentaId;
  final int usuarioId;

  Viaje({
    required this.id,
    required this.fecha,
    required this.horaInicio,
    required this.horaLlegada,
    required this.notaVentaId,
    required this.usuarioId,
  });

  factory Viaje.fromJson(Map<String, dynamic> json) {
    return Viaje(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      horaInicio: json['hora_inicio'],
      horaLlegada: json['hora_llegada'],
      notaVentaId: json['nota_venta_id'],
      usuarioId: json['usuario_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'hora_inicio': horaInicio,
      'hora_llegada': horaLlegada,
      'nota_venta_id': notaVentaId,
      'usuario_id': usuarioId,
    };
  }
}