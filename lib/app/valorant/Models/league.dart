import 'package:vlr/app/valorant/Models/event.dart';
import 'package:vlr/app/valorant/Services/valorant_service.dart' as service;
class League {
  final String id;
  final String name;
  final String country;
  final String img;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.img,
  });

  bool get isFavorite {
    return service.isTeamFavorite(id);
  }

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: service.eventToLeague(Event.fromJson(json)).toLowerCase().replaceAll(' ', '-'),
      name: service.eventToLeague(Event.fromJson(json)),
      country: json['country'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'img': img,
    };
  }
}