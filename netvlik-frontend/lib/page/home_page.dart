import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netvlik/Model/film.dart';
import 'package:netvlik/Service/film_service.dart';
import 'package:netvlik/utils/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  final FilmService _filmService = FilmService();
  List<Film> _films = [];

  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> fetchFilms() async {
    try {
      final films = await _filmService.fetchTopFilms();

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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello ${userProvider.username}!',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              CarouselSlider(
                  items: _films
                      .map((film) => Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: Image.network(
                                      film.imageUrl,
                                      fit: BoxFit.cover,
                                      width: 1000,
                                      height:
                                          150, // Adjust height to fit content
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  film.name,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.33,
                  )),
              const SizedBox(
                  height: 2), // Space between carousel and About Us section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  'Netvlik is a leading global streaming service, founded in 1997 by Reed Hastings and Marc Randolph. Initially a DVD rental service, Netvlik transitioned to online streaming in 2007. Today, it offers a vast library of films, TV shows, documentaries, and original content known as Netvlik Originals. Available in over 190 countries, Netvlik has millions of subscribers worldwide, transforming the way people consume entertainment by offering personalized viewing experiences through advanced recommendation algorithms.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left),
            ],
          ),
        ),
      ),
    );
  }
}
