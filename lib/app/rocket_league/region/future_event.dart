import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/services/api_service.dart';

class FutureEvent extends StatefulWidget {

  final String id;

  const FutureEvent({super.key, required this.id});

  @override
  State<FutureEvent> createState() => _FutureEventState();
}

class _FutureEventState extends State<FutureEvent> {

  var _regionEvents = [];
  final _futureEvents = [];
  String _id = '';

  getFutureEvent() {
    for (var event in _regionEvents){
      var eventStart = DateTime.parse(event['startDate']);
      var fakeDate = DateTime(2024, 5, 20);
      if (fakeDate.isBefore(eventStart)){
        setState(() {
          _futureEvents.add(event);
        });
      }
    }
  }

  toAsync() async {
    getEventByRegion(_id).then((value) => {
      _regionEvents = value,
      getFutureEvent(),
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
    return Text('Future Events = ${_futureEvents.length}');
  }
}
