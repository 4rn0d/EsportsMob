import 'package:flutter/material.dart';
import 'package:vlr/app/valorant/Services/data_service.dart' as data;
import 'package:vlr/app/valorant/Services/valorant_service.dart' as api;


class Leagues extends StatefulWidget {
  const Leagues({super.key});

  @override
  State<Leagues> createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {

  Future<void> toListAsync() async {
    setState(() {
      data.leagues.sort((a, b) {
        if(b.isFavorite) {
          return 1;
        }
        return -1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    toListAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !api.isLoading ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: data.leagues.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 75,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Image.network(data.leagues[index].img)
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Expanded(
                        child: Text(data.leagues[index].name)
                      ),
                      TextButton(
                        onPressed: (){
                          if (data.leagues[index].isFavorite){
                            setState(() {
                              api.removeFavoriteLeague(data.leagues[index]);
                            });
                          }
                          else{
                            setState(() {
                              api.addFavoriteLeague(data.leagues[index]);
                            });
                          }
                        },
                        child: !data.leagues[index].isFavorite ?
                          const Icon(Icons.star_outline, color: Colors.black,):
                          const Icon(Icons.star, color: Colors.black,)
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ): const Center(child: CircularProgressIndicator(color: Color(0xffda626c),)),
    );
  }
}
