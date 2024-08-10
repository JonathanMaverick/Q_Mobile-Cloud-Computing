import 'package:netvlik/utils/config.dart';

class Film {
  final String name;
  final String imageUrl;
  final String description;
  final String rating;

  Film(
      {required this.name,
      required this.imageUrl,
      required this.description,
      required this.rating});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      name: json['name'],
      imageUrl: '${Config.apiUrl}/${json['image']}',
      description: json['description'],
      rating: json['rating'].toString(),
    );
  }
}
