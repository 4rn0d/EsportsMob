import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/services/api_service.dart';

class CurrentEvent extends StatefulWidget {

  final String id;

  const CurrentEvent({super.key, required this.id});

  @override
  State<CurrentEvent> createState() => _CurrentEventState();
}

class _CurrentEventState extends State<CurrentEvent> {

  var _regionEvents = [];
  final _currentEvents = [];
  String _id = '';

  getCurrentEvent() {
    for (var event in _regionEvents){
      var eventStart = DateTime.parse(event['startDate']);
      var eventEnd = DateTime.parse(event['endDate']);
      var fakeDate = DateTime(2024, 5, 20);
      if (fakeDate.isAfter(eventStart) && fakeDate.isBefore(eventEnd)){
        setState(() {
          _currentEvents.add(event);
        });
      }
    }
  }

  toAsync() async {
    getEventByRegion(_id).then((value) => {
      _regionEvents = value,
      getCurrentEvent(),
      setState(() {
        isLoading = false;
      })
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.id;
    toAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Current Events = ${_currentEvents.length}');
  }
}
