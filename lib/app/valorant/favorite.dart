import 'package:flutter/material.dart';
import 'package:vlr/app/valorant/Models/team.dart';
import 'package:vlr/app/valorant/Services/valorant_service.dart' as api;

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}


class _FavoriteState extends State<Favorite> {

  Future<void> toListAsync() async {
    await api.getFavoriteTeams();
    setState(() {
      api.isLoading = false;
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
          backgroundColor: const Color(0xFF2f3337),
          title: const Text(
            'Following',
            style: TextStyle(
                color: Color(0xffda626c),
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Color(0xffda626c)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 900,
                      color: const Color(0xFF2f3337),
                      child: const Search(),
                    );
                  },
                );
              },
            ),
          ],
        ),
        ],
        body: !api.isLoading ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: api.favTeams.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      color: const Color(0xffda626c),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Image.network(api.favTeams[index].img)
                                    ),
                                    const Padding(padding: EdgeInsets.all(2.0)),
                                    Text(api.favTeams[index].name),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                )
              );
            }
          ),
        ): const Center(child: CircularProgressIndicator(color: Color(0xffda626c),)),
      ),
    );
  }
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final _teamController = TextEditingController();

  List<Team> _teams = [];

  var choice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choice = 'Americas';
    api.getTeamByRegion('Americas').then((value) {
      setState(() {
        _teams = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _teamController,
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Color(0xffda626c)),
                prefixIcon: Icon(Icons.search, color: Color(0xffda626c)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffda626c)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffda626c)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('Americas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black, fontSize: 20)
                  ),
                  selected: choice== 'Americas',
                  onSelected: (bool selected) {
                    setState(() {
                      choice= selected ? 'Americas' : null;
                    });
                    api.getTeamByRegion('Americas').then((value) {
                      setState(() {
                        _teams = value;
                      });
                    });
                  },
                  selectedColor: const Color(0xffda626c)
                )
              ),
              Expanded(
                child: ChoiceChip(
                  label: const Text('EMEA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontSize: 20)
                  ),
                  selected: choice== 'EMEA',
                  onSelected: (bool selected) {
                    setState(() {
                      choice= selected ? 'EMEA' : null;
                    });
                    api.getTeamByRegion('EMEA').then((value) {
                      setState(() {
                        _teams = value;
                      });
                    });
                  },
                  selectedColor: const Color(0xffda626c)
                )
              ),
              Expanded(
                  child: ChoiceChip(
                      label: const Text('Pacific',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontSize: 20)
                      ),
                      selected: choice== 'Pacific',
                      onSelected: (bool selected) {
                        setState(() {
                          choice= selected ? 'Pacific' : null;
                        });
                        api.getTeamByRegion('Pacific').then((value) {
                          setState(() {
                            _teams = value;
                          });
                        });
                      },
                      selectedColor: const Color(0xffda626c)
                  )
              ),
              Expanded(
                  child: ChoiceChip(
                      label: const Text('China',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontSize: 20)
                      ),
                      selected: choice== 'China',
                      onSelected: (bool selected) {
                        setState(() {
                          choice= selected ? 'China' : null;
                        });
                        api.getTeamByRegion('China').then((value) {
                          setState(() {
                            _teams = value;
                          });
                        });
                      },
                      selectedColor: const Color(0xffda626c)
                  )
              ),
            ]
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _teams.length,
                itemBuilder: (BuildContext context, int index) {
                  return _teams[index].name.contains(_teamController.text) ? SizedBox(
                    height: 75,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 40,
                                child: Image.network(_teams[index].img)
                            ),
                            const Padding(padding: EdgeInsets.all(8.0)),
                            Expanded(
                                child: Text(_teams[index].name)
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    if(_teams[index].isFavorite){
                                      api.favTeams.remove(_teams[index].id);
                                      for (Team team in api.favTeams) {
                                        if(team.id == _teams[index].id){
                                          api.favTeams.remove(team);
                                        }
                                      }
                                    }
                                    else{
                                      api.favTeams.add(_teams[index]);
                                    }
                                  });
                                },
                                child: !_teams[index].isFavorite ?
                                const Text('Follow', style: TextStyle(color: Color(0xffda626c)),):
                                const Text('Following', style: TextStyle(color: Color(0xFF535c65))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ): null;
                }
            ),
          ),
        ],
      ),
    );
  }
}
