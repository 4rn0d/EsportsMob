import 'package:flutter/material.dart';
import 'package:vlr/app/rocket_league/region/region_detail.dart';

import '../../valorant/Services/valorant_service.dart';

class Regions extends StatefulWidget {
  const Regions({super.key});

  @override
  State<Regions> createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {

  @override
  void initState() {
    super.initState();
  }

  var regions = ['NA', 'EU', 'OCE', 'SAM', 'ASIA', 'ME', 'AF', 'INT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: regions.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegionDetail(
                          id: regions[index],
                        ),
                      )
                  );
                },
                child: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(countryToFlag(regions[index])),
                      ),
                      Text(regions[index]),
                    ],
                  ),
                ),
              )
            );
          }
        ),
      ),
    );
  }
}
