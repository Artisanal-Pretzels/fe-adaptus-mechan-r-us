class Invoice {
  int invoiceID;
  String username;
  double basePrice;
  double labour;
  double parts;
  double recoveryFee;

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      json['invoiceID'] as int,
      json['username'],
      json['basePrice'].toDouble(),
      json['labour'].toDouble(),
      json['parts'].toDouble(),
      json['recoveryFee']?.toDouble()
    );
  }

  Invoice(this.invoiceID, this.username, this.basePrice, this.labour, this.parts, this.recoveryFee);

}
