class Stage {
  final int id;
  final String name;
  final String format;
  final String region;
  final String startDate;
  final String endDate;
  final int? prizeAmount;
  final String? prizeCurrency;
  final String liquipedia;
  final String venue;
  final String city;
  final String country;

  Stage({
    required this.id,
    required this.name,
    required this.format,
    required this.region,
    required this.startDate,
    required this.endDate,
    required this.prizeAmount,
    required this.prizeCurrency,
    required this.liquipedia,
    required this.venue,
    required this.city,
    required this.country,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    var prize = json['prize'];
    var location = json['location'];

    return Stage(
      id: json['_id'],
      name: json['name'],
      format: json['format'],
      region: json['region'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      prizeAmount: prize['amount'],
      prizeCurrency: prize['currency'],
      liquipedia: json['liquipedia'],
      venue: location['venue'],
      city: location['city'],
      country: location['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'format': format,
      'region': region,
      'startDate': startDate,
      'endDate': endDate,
      'prize': {
        'amount': prizeAmount,
        'currency': prizeCurrency,
      },
      'liquipedia': liquipedia,
      'location': {
        'venue': venue,
        'city': city,
        'country': country,
      },
    };
  }
}