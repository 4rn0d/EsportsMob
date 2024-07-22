import 'package:vlr/app/valorant/Services/valorant_service.dart' as service;
class Event {
  final String id;
  final String name;
  final String status;
  final String prizepool;
  final String dates;
  final String season;
  final String country;
  final String img;

  bool get isFavorite {
    return service.isTeamFavorite(name);
  }

  String get league {
    return service.eventToLeague(this);
  }

  Event({
    required this.id,
    required this.name,
    required this.status,
    required this.prizepool,
    required this.dates,
    required this.season,
    required this.country,
    required this.img,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      prizepool: json['prizepool'],
      dates: json['dates'],
      season: json['season'],
      country: json['country'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'prizepool': prizepool,
      'dates': dates,
      'season': season,
      'country': country,
      'img': img,
    };
  }
}

