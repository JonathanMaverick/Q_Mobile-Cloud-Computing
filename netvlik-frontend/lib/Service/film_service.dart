import 'dart:convert';
import 'package:netvlik/Model/film.dart';
import 'package:netvlik/utils/config.dart';
import 'package:http/http.dart' as http;

class FilmService {
  final String filmAPI = '${Config.apiUrl}/films/';

  Future<List<Film>> fetchTopFilms() async {
    try {
      final response = await http.get(Uri.parse('$filmAPI/top'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Film.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load films');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Film>> fetchAllFilms() async {
    try {
      final response = await http.get(Uri.parse(filmAPI));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Film.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load films');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
