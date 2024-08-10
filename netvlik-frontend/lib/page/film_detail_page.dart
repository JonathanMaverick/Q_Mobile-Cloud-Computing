import 'package:flutter/material.dart';
import 'package:netvlik/Model/film.dart';

class FilmDetailPage extends StatelessWidget {
  final Film film;
  const FilmDetailPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(film.imageUrl),
            const SizedBox(height: 16),
            Text(
              film.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(film.description),
            const SizedBox(height: 16),
            Text(
              'Rating: ${film.rating}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
