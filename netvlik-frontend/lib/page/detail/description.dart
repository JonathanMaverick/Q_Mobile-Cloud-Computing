import 'package:flutter/material.dart';
import 'package:netvlik/Model/film.dart';
import 'package:netvlik/Service/comment_service.dart';
import 'package:netvlik/utils/user_provider.dart';
import 'package:provider/provider.dart';

class DescriptionDetail extends StatefulWidget {
  const DescriptionDetail({super.key, required this.film});
  final Film film;

  @override
  State<DescriptionDetail> createState() => _DescriptionDetailState();
}

class _DescriptionDetailState extends State<DescriptionDetail> {
  final TextEditingController _reviewController = TextEditingController();
  final CommentService _commentService = CommentService();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> addReview() async {
    final review = _reviewController.text;
    if (review.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a review')),
      );
      return;
    }

    try {
      // Ensure filmId is parsed correctly
      final filmId = int.parse(widget.film.id);
      final userId = Provider.of<UserProvider>(context, listen: false).id;

      await _commentService.postComment(userId, filmId, review);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review successfully submitted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }

    _reviewController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 200,
                height: 300,
                child: Image.network(
                  widget.film.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.film.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              'Rating: ${widget.film.rating}',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.film.description,
              style: const TextStyle(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Add Your Review:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              style: const TextStyle(fontSize: 12.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter your review here',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Submit Review',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
