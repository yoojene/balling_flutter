import 'package:flutter/material.dart';
import 'package:balling/services/api.dart';

enum SegmentType { players, teams }

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Called once when the widget is created

    readJson(type: segment.name).then((value) => {
          setState(() {
            listItems = value;
          })
        });
  }

  List listItems = [];
  SegmentType segment = SegmentType.players;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
                hintText: 'Search',
                onChanged: (value) => {
                      print(value),
                      setState(() {
                        listItems = listItems.where((item) {
                          return item['strPlayer']
                              .toLowerCase()
                              .contains(value.toLowerCase());
                          // else if (item['strTeam']
                          //     .toLowerCase()
                          //     .contains(value.toLowerCase())) return item;
                        }).toList();
                        print(listItems);
                      })
                    }),
          )),
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

                    readJson(type: segment.name).then((value) => {
                          setState(() {
                            listItems = value;
                          })
                        });
                  });
                }),
          ],
        ),
        Expanded(
          child: ListView(
              children: ListTile.divideTiles(context: context, tiles: [
            if (listItems.isNotEmpty)
              for (var item in listItems)
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(segment == SegmentType.players
                        ? item['strCutout']
                        : item['strBadge']),
                  ),
                  title: Text(segment == SegmentType.players
                      ? item['strPlayer']
                      : item['strTeam']),
                  subtitle: Text(segment == SegmentType.players
                      ? item['strPosition'] + '\n' + item['strNumber']
                      : item['strTeamShort']),
                  trailing: Icon(Icons.chevron_right),
                ),
          ]).toList()),
        )
      ],
    );
  }
}
