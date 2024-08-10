import 'dart:convert';

import 'package:netvlik/Model/review.dart';
import 'package:netvlik/utils/config.dart';
import 'package:http/http.dart' as http;

class CommentService {
  final String commentAPI = '${Config.apiUrl}/comments/';

  Future<void> postComment(int userId, int filmId, String comment) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'user_id': userId,
      'film_id': filmId,
      'comment': comment,
    });

    try {
      final response = await http.post(
        Uri.parse('$commentAPI/create'),
        headers: headers,
        body: body,
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      throw Exception('Failed to post comment: $e');
    }
  }

  Future<List<Review>> getReviewByFilm(int filmId) async {
    try {
      final response = await http.get(Uri.parse('$commentAPI/film/$filmId'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Review.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  Future<void> updateReview(Review review) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'user_id': review.userId,
      'film_id': review.filmId,
      'comment': review.review,
    });

    try {
      final response = await http.put(
        Uri.parse('$commentAPI/update/${review.id}'),
        headers: headers,
        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update review');
      }
    } catch (e) {
      throw Exception('Failed to update review: $e');
    }
  }

  Future<void> deleteReview(int reviewId) async {
    try {
      final response =
          await http.delete(Uri.parse('$commentAPI/delete/$reviewId'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete review');
      }
    } catch (e) {
      throw Exception('Failed to delete review: $e');
    }
  }
}
