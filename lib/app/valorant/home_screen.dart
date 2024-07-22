import 'package:flutter/material.dart';
import 'package:vlr/app/valorant/Services/valorant_service.dart' as api;
import 'Services/data_service.dart' as data;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    api.fetchUpcomingMatches();
    api.fetchCompletedMatches();
    api.fetchLiveMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !api.isLoading ? Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.matchList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: const Color(0xFF535c65),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFF535c65),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 10.0)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(api.countryToFlag(data.matchList[index]['flag1']),
                                  style: const TextStyle(fontSize: 16.0)),
                              Text(api.countryToFlag(data.matchList[index]['flag2']),
                                  style: const TextStyle(fontSize: 16.0)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 210.0,
                                child: Text(data.matchList[index]["team1"],
                                  style: const TextStyle(fontSize: 14.0),),
                              ),
                              SizedBox(
                                width: 210.0,
                                child: Text(data.matchList[index]["team2"],
                                    style: const TextStyle(fontSize: 14.0)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (data.matchList[index]['category'] == 0)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                data.matchList[index]["score1"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                            Text(
                                data.matchList[index]["score2"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                          ],
                        ),
                      if (data.matchList[index]['category'] == 1)
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 14.0,
                                )
                            ),
                            Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 14.0,
                                )
                            ),
                          ],
                        ),
                      if (data.matchList[index]['category'] == 2)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                data.matchList[index]["score1"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                            Text(
                                data.matchList[index]["score2"],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFd4d4d4)
                                )
                            ),
                          ],
                        ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 7.0)),
                          if (data.matchList[index]['category'] == 0)
                            Text(data.matchList[index]["time_completed"]
                                .toString()
                                .replaceAll('ago', ''),
                                style: const TextStyle(fontSize: 10.0)),
                          if (data.matchList[index]['category'] == 1)
                            Text(data.matchList[index]["time_until_match"]
                                .toString()
                                .replaceAll('from now', ''),
                                style: const TextStyle(
                                    fontSize: 10.0, color: Colors.green)),
                          if (data.matchList[index]['category'] == 2)
                            Text(data.matchList[index]["time_until_match"]
                                .toString()
                                .replaceAll('from now', ''),
                                style: const TextStyle(
                                    fontSize: 10.0, color: Colors.red)),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
                );
              }
            ),
          )
        ],
      ): const Center(child: CircularProgressIndicator(color: Color(0xffda626c),))
    );
  }
}