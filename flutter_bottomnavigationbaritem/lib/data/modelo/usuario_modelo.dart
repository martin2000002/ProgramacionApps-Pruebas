import 'package:flutter_bottomnavigationbaritem/dominio/entidades/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel(
      {required super.id, required super.nombre, required super.email});

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
        id: map['id'], nombre: map['nombre'], email: map['email']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nombre': nombre,
      'email': email,
    };

    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }
}
