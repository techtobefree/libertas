class Sponsor {
  final String id;
  final String amount;
  final String userId;

  Sponsor({
    required this.id,
    required this.amount,
    required this.userId,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json['_id'] ?? '',
      amount: json['amount'] ?? '',
      userId: json['user'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'amount': amount,
      'user': userId,
    };
  }
}
