// https://zsr.octane.gg/events

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';


bool isLoading = false;
final db = FirebaseFirestore.instance;

fetchMatches(String event, int stage) async {
  isLoading = true;
  String startDate = '${DateTime.now().year}-${DateTime.now().month - 1}-${DateTime.now().day}';
  String url = 'https://zsr.octane.gg/matches?event=$event&stage=$stage';
  final response = await SingletonDio.getDio().get(url);
  if (response.statusCode == 200) {
    var result = jsonDecode(response.data)['matches'];
    var matches = [];
    for(var match in result) {
      match['event'] = match['event']['slug'];
      final ref = db.collection('games').doc('rocketLeague').collection('matches');
      var snapshot = await ref.get();
      int score = 0;
      for (var doc in snapshot.docs){
        var data = doc.data();
        if (data['_id'] == match['_id']){
          score++;
          break;
        }
      }
      if (score == 0){
        matches.add(match);
      }
    }
    isLoading = false;
    return matches;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Matches');
  }
}

fetchEvents() async {
  isLoading = true;
  String year = DateTime.now().year.toString();
  final response = await SingletonDio.getDio().get('https://zsr.octane.gg/events?name=RLCS&perPage=400&after=$year-01-01');
  if (response.statusCode == 200) {
    var result = jsonDecode(response.data)['events'];
    for(var event in result) {
      var stages = event['stages'];
      event.remove('stages');
      final eventsRef = db.collection('games').doc('rocketLeague').collection('events');
      var snapshot = await eventsRef.get();
      int score = 0;
      for (var doc in snapshot.docs){
        var data = doc.data();
        if (data['_id'] == event['_id']){
          score++;
          break;
        }
      }
      if (score == 0){
        eventsRef.doc(event["slug"]).set(event);
        for(var stage in stages){
          final stagesRef = eventsRef.doc(event["slug"]).collection('stages');
          stagesRef.doc(stage["name"]).set(stage);

          final matchRef = stagesRef.doc(stage["name"]).collection('matches');
          var matches = await fetchMatches(event['_id'], stage['_id']);
          for (var match in matches){
            matchRef.doc(match["slug"]).set(match);
          }
        }
      }
    }
    isLoading = false;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Events');
  }
}

updateFavorite(String id) async {
  final ref = db.collection('users').doc('test').collection('favorites').doc('regions');
  if (await isEventFavorite(id)){
    ref.update({
      'ids': FieldValue.arrayRemove([id])
    });
  }
  else{
    ref.update({
      'ids': FieldValue.arrayUnion([id])
    });
  }
}

Future<bool> isEventFavorite(String id) async{
  final ref = db.collection('users').doc('test').collection('favorites').doc('regions');
  var snapshot = await ref.get();
  var favs = snapshot.data()!;
  if (favs['ids'].length != 0) {
    for (var region in favs['ids']) {
      if (region == id) {
        return true;
      }
      return false;
    }
  }
  return false;
}

getEventByRegion(String region) async {
  isLoading = true;
  var events = [];
  final eventsRef = db.collection('games').doc('rocketLeague').collection('events');
  var eventQuery = eventsRef.where("region", isEqualTo: region);
  var regionEnvents = await eventQuery.get();
  for (var eventSnapshot in regionEnvents.docs) {
    events.add(eventSnapshot.data());
  }
  isLoading = false;
  return events;
}

getMatcheByRegion(String region) async {
  isLoading = true;
  var matches = [];
  final eventsRef = db.collection('games').doc('rocketLeague').collection('events');
  var eventQuery = eventsRef.where("region", isEqualTo: region);
  var regionEnvents = await eventQuery.get();
  for (var eventSnapshot in regionEnvents.docs) {
    final stageRef = eventsRef.doc(eventSnapshot.id).collection('stages');
    var stages = await stageRef.get();
    for (var stageSnapshot in stages.docs){
      final matchRef = stageRef.doc(stageSnapshot.id).collection('matches');
      var matchCollection = await matchRef.get();
      for(var matchSnapshot in matchCollection.docs){
        var matchData = matchSnapshot.data();
        var matchDate = DateTime.parse(matchData['date']);
        if (matchDate.isAfter(DateTime(2024, 5, 19))){
          matches.add(matchSnapshot.data());
        }
      }
    }
  }
  isLoading = false;
  return matches;
}

class SingletonDio {

  static Dio getDio() {
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    return dio;
  }
}