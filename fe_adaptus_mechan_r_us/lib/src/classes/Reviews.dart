class Reviews {
  int reviewID;
  int rating;
  String body;
  String username;


  Reviews(this.reviewID, this.rating, this.body, this.username);

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
        json['reviewID'] as int,
        json['rating'] as int,
        json['body'],
        json['username'];
    }
}