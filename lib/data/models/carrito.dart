class Carrito {
  final int id;
  final DateTime fecha;
  final double monto;
  final int userClienteId;
  final int? ubicacionId;

  Carrito({
    required this.id,
    required this.fecha,
    required this.monto,
    required this.userClienteId,
    this.ubicacionId,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) {
    return Carrito(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      monto: (json['monto'] as num).toDouble(),
      userClienteId: json['user_cliente'],
      ubicacionId: json['ubicacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'monto': monto,
      'user_cliente': userClienteId,
      'ubicacion': ubicacionId,
    };
  }
}