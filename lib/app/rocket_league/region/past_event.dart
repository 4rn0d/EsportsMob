import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/services/api_service.dart';

class PastEvent extends StatefulWidget {

  final String id;

  const PastEvent({super.key, required this.id});

  @override
  State<PastEvent> createState() => _PastEventState();
}

class _PastEventState extends State<PastEvent> {

  var _regionEvents = [];
  final _pastEvents = [];
  String _id = '';

  getPastEvent() {
    for (var event in _regionEvents){
      var eventEnd = DateTime.parse(event['endDate']);
      var fakeDate = DateTime(2024, 5, 20);
      if (fakeDate.isAfter(eventEnd)){
        setState(() {
          _pastEvents.add(event);
        });
      }
    }
  }

  toAsync() async {
    getEventByRegion(_id).then((value) => {
      _regionEvents = value,
      getPastEvent(),
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
    return Text('Past Events = ${_pastEvents.length}');
  }
}