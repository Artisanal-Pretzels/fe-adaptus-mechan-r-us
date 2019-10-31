class Review {
  int reviewID;
  int rating;
  String body;
  String username;

  Review(this.reviewID, this.rating, this.body, this.username);

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        json['reviewID'] as int,
        json['rating'] as int,
        json['body'],
        json['username']
    );
  }
}