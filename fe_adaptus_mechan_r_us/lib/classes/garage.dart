class Garage {
  int garageID;
  String garageName;
  double ratings;
  double basePrice;
  dynamic distance;



  Garage(this.garageID, this.garageName, this.ratings, this.basePrice, this.distance);

  factory Garage.fromJson(Map<String, dynamic> json) {
    return Garage(
      json['garageID'] as int,
      json['garageName'],
      json['ratings'].toDouble(),
      json['basePrice'].toDouble(),
      json['distance']
    );
  }
}


//garageID: json['garageID'] as int, garageName: json['garageName'], ratings: json['ratings'] as double, basePrice: json['basePrice'] as double, distance: json['distance'] as Map