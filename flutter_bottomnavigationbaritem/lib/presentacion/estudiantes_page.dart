import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bottomnavigationbaritem/data/modelo/usuario_modelo.dart';
import 'package:flutter_bottomnavigationbaritem/data/providers/usuario.dart';

class EstudiantesPage extends StatefulWidget {
  const EstudiantesPage({super.key});

  @override
  State<EstudiantesPage> createState() => _EstudiantesPageState();
}

class _EstudiantesPageState extends State<EstudiantesPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _agregarUsuario(BuildContext context) {
    if (nombreController.text.isEmpty || emailController.text.isEmpty) return;
    
    Provider.of<UsuarioProvider>(context, listen: false).agregarUsuario(
      nombreController.text,
      emailController.text,
    );
    
    nombreController.clear();
    emailController.clear();
  }

  Future<void> _editarUsuario(BuildContext context, UsuarioModel usuario) async {
    nombreController.text = usuario.nombre;
    emailController.text = usuario.email;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Estudiante'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<UsuarioProvider>(context, listen: false).editarUsuario(
                  usuario.id,
                  nombreController.text,
                  emailController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<UsuarioProvider>(context, listen: false).reiniciarFavoritos();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favoritos reiniciados')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _agregarUsuario(context),
              child: const Text('Agregar Estudiante'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<UsuarioProvider>(
                builder: (context, provider, child) {
                  if (provider.usuarios.isEmpty) {
                    return const Center(
                      child: Text('No hay estudiantes registrados'),
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: provider.usuarios.length,
                    itemBuilder: (context, index) {
                      final usuario = provider.usuarios[index];
                      final esFavorito = provider.esFavorito(usuario.id);
                      
                      return Card(
                        child: ListTile(
                          title: Text(usuario.nombre),
                          subtitle: Text(usuario.email),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Botón de favorito
                              IconButton(
                                icon: Icon(
                                  esFavorito ? Icons.favorite : Icons.favorite_border,
                                  color: esFavorito ? Colors.red : null,
                                ),
                                onPressed: () {
                                  if (esFavorito) {
                                    provider.quitarFavorito(usuario.id);
                                  } else {
                                    provider.agregarFavorito(usuario);
                                  }
                                },
                              ),
                              // Botón de editar
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editarUsuario(context, usuario),
                              ),
                              // Botón de eliminar
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  provider.eliminarUsuario(usuario.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}