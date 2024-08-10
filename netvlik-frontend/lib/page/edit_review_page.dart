import 'package:flutter/material.dart';
import 'package:netvlik/Model/review.dart';

class EditReviewPage extends StatefulWidget {
  const EditReviewPage({super.key, required this.review});
  final Review review;

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reviewController.text = widget.review.review;
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _updateReview() async {
    final updatedReview = Review(
      id: widget.review.id,
      userId: widget.review.userId,
      filmId: widget.review.filmId,
      review: _reviewController.text,
    );

    Navigator.pop(context, updatedReview);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _updateReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Save Review',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
