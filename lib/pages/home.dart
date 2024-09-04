import 'package:flutter/material.dart';

enum SegmentType { players, teams }

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SegmentType segment = SegmentType.players;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SegmentedButton(
            style: SegmentedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.red,
              selectedForegroundColor: Colors.white,
              selectedBackgroundColor: Colors.green,
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
              });
            }),
      ],
    );
  }
}
