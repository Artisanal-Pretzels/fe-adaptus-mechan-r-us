class User {
  int userID;
  String username;
  String name;
  String email;
  String phoneNumber;
  int garageID;

  User(this.userID, this.username, this.name, this.email, this.phoneNumber, this.garageID);

  factory User.fromJson(Map<String, dynamic> json) {
    return User (
      json['userID'] as int,
      json['username'],
      json['name'],
      json['email'],
      json['phoneNumber'],
      json['garageID'] as int
    );
  }
}