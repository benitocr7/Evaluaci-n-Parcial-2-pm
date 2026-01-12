import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'db_helper.dart';

class GaleriaDesdeSQLite extends StatelessWidget {
  const GaleriaDesdeSQLite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería desde SQLite')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Autor: ${DBHelper.autor}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: DBHelper.obtenerPorAutor(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final datos = snapshot.data as List<Map<String, dynamic>>;

                return ListView.builder(
                  itemCount: datos.length,
                  itemBuilder: (context, index) {
                    final item = datos[index];
                    return Card(
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: item['imageUrl'],
                          width: 60,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(item['titulo']),
                        subtitle: Text(item['autor']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
