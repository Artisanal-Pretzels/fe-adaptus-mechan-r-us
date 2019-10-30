class SingleGarage {
  int garageID;
  String garageName;
  String description;
  String imagePath;
  double basePrice;
  String phoneNumber;
  dynamic address;
  dynamic invoices;
  List reviews;

  SingleGarage(
      this.garageID,
      this.garageName,
      this.description,
      this.imagePath,
      this.basePrice,
      this.phoneNumber,
      this.address,
      this.invoices,
      this.reviews);

  factory SingleGarage.fromJson(Map<String, dynamic> json) {
    return SingleGarage(
        json['garageID'] as int,
        json['garageName'],
        json['description'],
        json['imagePath'],
        json['basePrice'].toDouble(),
        json['phoneNumber'],
        json['address'],
        json['invoices'],
        json['reviews']);
  }
}
