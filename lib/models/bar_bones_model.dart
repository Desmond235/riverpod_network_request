class Activity {
  final String activity;
  final String type;
  final int participants;
  final double price;

  Activity({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
  });

  factory Activity.fromJson(Map<Object, Object?> json) {
    return Activity(
      activity: json['activity'] as String? ?? "",
      type: json['type'] as String? ?? "",
      participants: json['participants'] as int? ?? 0,
      price: json['price'] as double? ?? 0.00,
    );
  }
}
