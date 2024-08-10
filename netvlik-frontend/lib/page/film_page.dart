import 'package:flutter/material.dart';
import 'package:netvlik/Model/film.dart';
import 'package:netvlik/Service/film_service.dart';
import 'package:netvlik/page/film_card.dart';

class FilmPage extends StatefulWidget {
  const FilmPage({super.key});

  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<Film> _films = [];
  final FilmService _filmService = FilmService();

  Future<void> fetchFilms() async {
    try {
      final films = await _filmService.fetchAllFilms();
      if (mounted) {
        setState(() {
          _films = films;
        });
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackbar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.57),
              padding: const EdgeInsets.all(8.0),
              itemCount: _films.length,
              itemBuilder: (context, index) {
                final film = _films[index];
                return FilmCard(film: film);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
