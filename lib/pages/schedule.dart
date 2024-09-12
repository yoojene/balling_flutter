import 'package:balling/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List listItems = []; // All items from the API

  @override
  void initState() {
    super.initState();
    // Called once when the widget is created
    readJson(type: 'events').then((value) => {
          setState(() {
            listItems = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var event in listItems)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['strEvent'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(event['dateEvent']),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(event['strHomeTeamBadge']),
                              ),
                              SizedBox(height: 10),
                              event['intHomeScore'] != null
                                  ? Text(
                                      event['intHomeScore'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              int.parse(event['intHomeScore']) >
                                                      int.parse(
                                                          event['intAwayScore'])
                                                  ? Colors.green
                                                  : Colors.red),
                                    )
                                  : Text('Not Played'),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(event['strAwayTeamBadge']),
                              ),
                              SizedBox(height: 10),
                              event['intAwayScore'] != null
                                  ? Text(
                                      event['intAwayScore'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              int.parse(event['intHomeScore']) <
                                                      int.parse(
                                                          event['intAwayScore'])
                                                  ? Colors.green
                                                  : Colors.red),
                                    )
                                  : Text('Not Played'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      HtmlWidget(event['strResult']),
                    ],
                  ),
                )),
          )
      ],
    );
  }
}
