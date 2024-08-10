class Review {
  final int userId;
  final int filmId;
  final String review;
  final int id;

  Review(
      {required this.filmId,
      required this.userId,
      required this.review,
      required this.id});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'],
      filmId: json['film_id'],
      review: json['comment'],
      id: json['id'],
    );
  }
}
