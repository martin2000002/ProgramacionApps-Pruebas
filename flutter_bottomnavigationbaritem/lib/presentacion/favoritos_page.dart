import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bottomnavigationbaritem/data/providers/usuario.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes Favoritos'),
      ),
      body: Consumer<UsuarioProvider>(
        builder: (context, provider, child) {
          if (provider.favoritos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No tienes estudiantes favoritos',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: provider.favoritos.length,
            itemBuilder: (context, index) {
              final favorito = provider.favoritos[index];
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.favorite, color: Colors.white),
                  ),
                  title: Text(favorito.nombre),
                  subtitle: Text(favorito.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      provider.quitarFavorito(favorito.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}