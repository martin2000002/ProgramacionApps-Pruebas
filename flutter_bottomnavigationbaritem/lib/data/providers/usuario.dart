import 'package:flutter/material.dart';
import 'package:flutter_bottomnavigationbaritem/data/modelo/usuario_modelo.dart';
import 'package:flutter_bottomnavigationbaritem/dominio/repositorio/usuario_repositorio.dart';

class UsuarioProvider extends ChangeNotifier {
  List<UsuarioModel> _usuarios = [];
  List<UsuarioModel> _favoritos = [];
  final UsuarioRepositorio _repositorio = UsuarioRepositorio();

  List<UsuarioModel> get usuarios => _usuarios;
  List<UsuarioModel> get favoritos => _favoritos;

  UsuarioProvider() {
    _cargarFavoritos();
  }

  Future<void> _cargarFavoritos() async {
    _favoritos = await _repositorio.obtenerUsuarios();
    notifyListeners();
  }

  void agregarUsuario(String nombre, String email) {
    final id = DateTime.now().millisecondsSinceEpoch;
    
    final nuevoUsuario = UsuarioModel(
      id: id,
      nombre: nombre,
      email: email,
    );
    
    _usuarios.add(nuevoUsuario);
    notifyListeners();
  }

  void eliminarUsuario(int id) {
    _usuarios.removeWhere((usuario) => usuario.id == id);
    
    if (esFavorito(id)) {
      quitarFavorito(id);
    }
    
    notifyListeners();
  }

  void editarUsuario(int id, String nombre, String email) {
    final index = _usuarios.indexWhere((usuario) => usuario.id == id);
    if (index != -1) {
      _usuarios[index] = UsuarioModel(
        id: id,
        nombre: nombre,
        email: email,
      );
      
      final favIndex = _favoritos.indexWhere((usuario) => usuario.id == id);
      if (favIndex != -1) {
        _favoritos[favIndex] = UsuarioModel(
          id: id,
          nombre: nombre,
          email: email,
        );
        _actualizarFavoritoEnBD(_favoritos[favIndex]);
      }
      
      notifyListeners();
    }
  }

  bool esFavorito(int id) {
    return _favoritos.any((usuario) => usuario.id == id);
  }

  Future<void> agregarFavorito(UsuarioModel usuario) async {
    if (!esFavorito(usuario.id)) {
      _favoritos.add(usuario);
      await _repositorio.insertarUsuario(usuario);
      notifyListeners();
    }
  }

  Future<void> quitarFavorito(int id) async {
    _favoritos.removeWhere((usuario) => usuario.id == id);
    await _repositorio.eliminarUsuario(id);
    notifyListeners();
  }

  Future<void> _actualizarFavoritoEnBD(UsuarioModel usuario) async {
    await _repositorio.actualizarUsuario(usuario);
  }

  Future<void> reiniciarFavoritos() async {
    await _repositorio.reiniciarFavoritos();
    _favoritos.clear();
    notifyListeners();
  }
}