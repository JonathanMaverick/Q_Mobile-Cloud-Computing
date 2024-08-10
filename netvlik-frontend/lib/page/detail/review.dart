import 'package:flutter/material.dart';
import 'package:netvlik/Model/film.dart';
import 'package:netvlik/Model/review.dart';
import 'package:netvlik/Service/comment_service.dart';
import 'package:netvlik/page/edit_review_page.dart';
import 'package:netvlik/utils/user_provider.dart';
import 'package:provider/provider.dart';

class ReviewDetail extends StatefulWidget {
  const ReviewDetail({super.key, required this.film});
  final Film film;

  @override
  State<ReviewDetail> createState() => _ReviewDetailState();
}

class _ReviewDetailState extends State<ReviewDetail> {
  final CommentService _commentService = CommentService();
  late Future<List<Review>> _futureReviews;

  @override
  void initState() {
    super.initState();
    _futureReviews = _commentService.getReviewByFilm(int.parse(widget.film.id));
  }

  Future<void> _refreshReviews() async {
    setState(() {
      _futureReviews =
          _commentService.getReviewByFilm(int.parse(widget.film.id));
    });
  }

  Future<void> _editReview(Review review) async {
    final updatedReview = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReviewPage(review: review),
      ),
    );

    if (updatedReview != null) {
      await _commentService.updateReview(updatedReview);
      _refreshReviews();
    }
  }

  Future<void> _deleteReview(int reviewId) async {
    await _commentService.deleteReview(reviewId);
    _refreshReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Review>>(
        future: _futureReviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reviews available.'));
          }

          final reviews = snapshot.data!;

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ListTile(
                title:
                    Text(review.review, style: const TextStyle(fontSize: 16)),
                trailing: review.userId == Provider.of<UserProvider>(context).id
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editReview(review),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteReview(review.id),
                          ),
                        ],
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
