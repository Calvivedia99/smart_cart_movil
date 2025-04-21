class TarjetaDebito {
  final int id;
  final String nro;
  final String cvc;
  final DateTime exp;
  final int userId;

  TarjetaDebito({
    required this.id,
    required this.nro,
    required this.cvc,
    required this.exp,
    required this.userId,
  });

  factory TarjetaDebito.fromJson(Map<String, dynamic> json) {
    return TarjetaDebito(
      id: json['id'],
      nro: json['nro'],
      cvc: json['cvc'],
      exp: DateTime.parse(json['exp']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nro': nro,
      'cvc': cvc,
      'exp': exp.toIso8601String(), 
      'user_id': userId,
    };
  }
}