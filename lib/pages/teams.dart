import 'package:balling/main.dart';
import 'package:balling/models/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamDetail extends StatelessWidget {
  static const routeName = '/team';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BallingAppState>();

    final team = ModalRoute.of(context)!.settings.arguments as Teams;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        title: Text(team.strTeam),
      ),
      body: ListView(
        children: [
          Card(
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        selectedIcon: Icon(Icons.favorite),
                        isSelected:
                            appState.favouriteTeamIds.contains(team.idTeam),
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primaryFixedDim)),
                        onPressed: () => appState.toggleFavoriteTeam(team),
                        icon: Icon(Icons.favorite_outline)),
                    Image.network(team.strBadge),
                    SizedBox(height: 10),
                    Text('Team Acronym',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),
                    Text(team.strTeamShort,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(height: 10),

                    Text('Stadium',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),

                    Text('${team.strStadium}  ${team.strLocation}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(height: 10),

                    Text('Bio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),

                    Text(team.strDescriptionEN,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        )),
                    // Text('${args.strDescriptionEN}'),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
