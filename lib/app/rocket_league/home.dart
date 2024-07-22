import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var matches = [];

  toAsync() async {
    getMatcheByRegion('NA').then((value) => {
      matches = value,
      setState(() {
        isLoading = false;
      })
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading ? Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: const Text('NA'),
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      return Text(matches[index]["slug"]);
                    }
                  )
                ]
              );
            }
          ),
          const Expanded(
            child: ExpansionTile(
              title: Text('Hide all'),
              children: [
                Text('text'),
              ]
            ),
          ),
        ],
      ): const Center(child: CircularProgressIndicator(color: Color(0xff2071c7),))
    );
  }
}
