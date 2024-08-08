import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netvlik/config.dart';
import 'package:netvlik/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<dynamic> _films = [];
  Map<String, String> _filmsImage = {};
  bool _isLoading = true;

  Future<void> fetchFilms() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.apiUrl}/users/films'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> films = json.decode(response.body);

        setState(() {
          _films = films;
          _filmsImage = {
            for (var film in films)
              film["name"]: "http://127.0.0.1:3000/${film["image"]}"
          };
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          _showErrorSnackbar(context, 'Failed to load films');
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        _showErrorSnackbar(context, 'An error occurred: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Hello ${userProvider.username}!',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              CarouselSlider(
                  items: _films
                      .map((film) => Container(
                            margin: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  _filmsImage[film["name"]] ??
                                      'https://via.placeholder.com/150',
                                  fit: BoxFit.cover,
                                  width: 1000,
                                )),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
