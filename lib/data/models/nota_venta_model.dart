class DetalleVenta {
  final int productoId;
  final int cantidad;
  final double precioVenta;

  DetalleVenta({
    required this.productoId,
    required this.cantidad,
    required this.precioVenta,
  });

  factory DetalleVenta.fromJson(Map<String, dynamic> json) {
    return DetalleVenta(
      productoId: json['producto_id'],
      cantidad: json['cantidad'],
      precioVenta: (json['precio_venta'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'producto_id': productoId,
      'cantidad': cantidad,
      'precio_venta': precioVenta,
    };
  }
}

class NotaVenta {
  final int id;
  final double montoTotal;
  final int clienteId;
  final int userEmpleadoId;
  final int? descuentoId;
  final List<DetalleVenta> detalles;

  NotaVenta({
    required this.id,
    required this.montoTotal,
    required this.clienteId,
    required this.userEmpleadoId,
    this.descuentoId,
    required this.detalles,
  });

  factory NotaVenta.fromJson(Map<String, dynamic> json) {
    return NotaVenta(
      id: json['id'],
      montoTotal: (json['monto_total'] as num).toDouble(),
      clienteId: json['cliente_id'],
      userEmpleadoId: json['user_empleado_id'],
      descuentoId: json['descuento_id'],
      detalles: (json['detalles'] as List)
          .map((d) => DetalleVenta.fromJson(d))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'monto_total': montoTotal,
      'cliente_id': clienteId,
      'user_empleado_id': userEmpleadoId,
      'descuento_id': descuentoId,
      'detalles': detalles.map((d) => d.toJson()).toList(),
    };
  }
}