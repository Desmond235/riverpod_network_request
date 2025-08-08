class Activity {
  final String key;
  final String activity;
  final String type;
  final int participants;
  final double price;

  Activity({
    required this.key,
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
  });

  Activity.fromJSon(Map<String, dynamic> json)
    : key = json['key'],
      activity = json['activity'],
      type = json['type'],
      participants = json['participants'],
      price = (json['price'] as num).toDouble();

}
