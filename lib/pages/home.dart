import 'package:balling/models/player.dart';
import 'package:balling/models/team.dart';
import 'package:balling/pages/player.dart';
import 'package:balling/pages/team.dart';
import 'package:flutter/material.dart';
import 'package:balling/services/api.dart';

enum SegmentType { players, teams }

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _foundItems = []; // Update the list view with these
  List listItems = []; // All items from the API
  SegmentType segment = SegmentType.players;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Called once when the widget is created
    readJson(type: segment.name).then((value) => {
          setState(() {
            listItems = value;
            _foundItems = listItems;
          })
        });
  }

  // https://www.youtube.com/watch?v=pUV5v240po0
  void _filterItems(String searchTerm) {
    List results = [];
    if (searchTerm.isEmpty) {
      results = listItems;
    } else {
      if (segment == SegmentType.players) {
        results = listItems
            .where((item) => item['strPlayer']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
            .toList();
      } else {
        results = listItems
            .where((item) => item['strTeam']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
            .toList();
      }
    }

    setState(() {
      _foundItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    controller: _controller,
                    hintText: 'Search',
                    onChanged: (value) => _filterItems(value),
                    leading: Icon(Icons.search),
                    trailing: <Widget>[
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _foundItems = listItems;
                            });
                            _controller.clear();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ))),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton(
                style: SegmentedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(200, 16, 46, 0.3),
                  foregroundColor: Color.fromRGBO(29, 66, 138, 1),
                  selectedForegroundColor: Colors.white,
                  selectedBackgroundColor: Color.fromRGBO(29, 66, 138, 1),
                ),
                segments: const [
                  ButtonSegment<SegmentType>(
                      value: SegmentType.players, label: Text('Players')),
                  ButtonSegment(value: SegmentType.teams, label: Text('Teams'))
                ],
                selected: <SegmentType>{segment},
                onSelectionChanged: (Set<SegmentType> selection) {
                  print(selection);
                  setState(() {
                    // By default there is only a single segment that can be
                    // selected at one time, so its value is always the first
                    // item in the selected set.
                    segment = selection.first;

                    _controller.clear();
                    readJson(type: segment.name).then((value) => {
                          setState(() {
                            listItems = value;
                            _foundItems = listItems;
                          })
                        });
                    print(_foundItems);
                  });
                }),
          ],
        ),
        Expanded(
            child: ListView.separated(
          itemCount: _foundItems.length,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(segment == SegmentType.players
                  ? _foundItems[index]['strCutout']
                  : _foundItems[index]['strBadge']),
            ),
            title: Text(segment == SegmentType.players
                ? _foundItems[index]['strPlayer']
                : _foundItems[index]['strTeam']),
            subtitle: Text(segment == SegmentType.players
                ? _foundItems[index]['strPosition'] +
                    '\n' +
                    _foundItems[index]['strNumber']
                : _foundItems[index]['strTeamShort']),
            trailing: Icon(Icons.chevron_right),
            onTap: () => {
              segment == SegmentType.players
                  ? Navigator.pushNamed(context, PlayerDetail.routeName,
                      arguments: Player(
                          _foundItems[index]['idPlayer'],
                          _foundItems[index]['strPlayer'],
                          _foundItems[index]['strNumber'],
                          _foundItems[index]['strCutout'],
                          _foundItems[index]['strPosition'],
                          _foundItems[index]['strDescriptionEN']))
                  : Navigator.pushNamed(context, TeamDetail.routeName,
                      arguments: Team(
                        _foundItems[index]['idTeam'],
                        _foundItems[index]['strTeam'],
                        _foundItems[index]['strTeamShort'],
                        _foundItems[index]['strStadium'],
                        _foundItems[index]['strLocation'],
                        _foundItems[index]['strDescriptionEN'],
                        _foundItems[index]['strBadge'],
                      ))
            },
          ),
          separatorBuilder: (context, index) => Divider(),
        ))
      ],
    );
  }
}
