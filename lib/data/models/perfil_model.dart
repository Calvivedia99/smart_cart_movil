class Perfil {
  final String nombre;
  final String apellido;
  final String telefono;
  final String sexo;

  Perfil({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.sexo,
  });

  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      sexo: json['sexo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'sexo': sexo,
    };
  }
}
