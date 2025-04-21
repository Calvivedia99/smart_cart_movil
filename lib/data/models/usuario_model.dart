import 'perfil_model.dart';

class Usuario {
  final int id;
  final String name;
  final String email;
  final bool status;
  final int rolId;
  final String? urlFoto;
  final Perfil? perfil; // ← AÑADIDO

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.rolId,
    this.urlFoto,
    this.perfil,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      rolId: json['rol_id'],
      urlFoto: json['url_foto'],
      perfil: json['perfil'] != null ? Perfil.fromJson(json['perfil']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'rol_id': rolId,
      'url_foto': urlFoto,
    };
  }
}
