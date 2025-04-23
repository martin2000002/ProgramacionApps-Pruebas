import 'package:flutter_bottomnavigationbaritem/data/db/data_base.dart';
import 'package:flutter_bottomnavigationbaritem/data/modelo/usuario_modelo.dart';

class UsuarioRepositorio {
  final DataBaseSqlite dbb = DataBaseSqlite();

  Future<void> insertarUsuario(UsuarioModel usuario) async {
    final db = await dbb.database;
    await db.insert('usuarios', usuario.toMap());
  }

  Future<List<UsuarioModel>> obtenerUsuarios() async {
    final db = await dbb.database;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return UsuarioModel.fromMap(maps[i]);
    });
  }

  Future<void> eliminarUsuario(int id) async {
    final db = await dbb.database;
    await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> actualizarUsuario(UsuarioModel usuario) async {
    final db = await dbb.database;
    await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<void> reiniciarFavoritos() async {
    final db = await dbb.database;
    await db.delete('usuarios');
  }
}