import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/region/current_event.dart';
import 'package:vlr/app/rocket_league/region/future_event.dart';
import 'package:vlr/app/rocket_league/region/past_event.dart';
import 'package:vlr/app/rocket_league/services/api_service.dart' as api;

class RegionDetail extends StatefulWidget {

  final String id;

  const RegionDetail({super.key, required this.id});

  @override
  State<RegionDetail> createState() => _RegionDetailState();
}

class _RegionDetailState extends State<RegionDetail> {
  bool isFavorite = false;

  String _id = '';

  getFavorite() async{
    api.isEventFavorite(widget.id).then((value) {
      setState(() {
        isFavorite = value;
      });
    });
  }

  List<DropdownMenuEntry<dynamic>> _dropDownMenuEntries = [const DropdownMenuEntry(label: '2024', value: 2024), const DropdownMenuEntry(label: '2023', value: 2023)];

  @override
  void initState() {
    super.initState();
    getFavorite();
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
          return [
            SliverAppBar.large(
              backgroundColor: const Color(0xff2071c7),
              titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
              actions: [
                DropdownMenu(
                  initialSelection: _dropDownMenuEntries[0],
                  inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.white
                    ),
                    filled: true,
                    fillColor: Color(0xff124376)
                  ),
                  dropdownMenuEntries: _dropDownMenuEntries
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        api.updateFavorite(_id);
                        isFavorite = !isFavorite;
                      });
                    },
                    child: isFavorite ? const Text('Following') : const Text('Follow')
                )
              ],
              title: Text(_id),
              bottom: const TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(child: Text("Current", style: TextStyle(color: Colors.white),)),
                  Tab(child: Text("Future", style: TextStyle(color: Colors.white))),
                  Tab(child: Text("Past", style: TextStyle(color: Colors.white))),
                  Tab(child: Text("Statistics", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ];
          },
          body: TabBarView(
            children: <Widget>[
              Center(
                child: CurrentEvent(id: _id),
              ),
              Center(
                child: FutureEvent(id: _id),
              ),
              Center(
                child: PastEvent(id: _id,),
              ),
              const Center(
                child: Text("Statistics"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
