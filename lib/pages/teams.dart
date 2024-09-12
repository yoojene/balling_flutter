import 'package:balling/main.dart';
import 'package:balling/models/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamDetailParams {
  final String strTeam;
  final String strBadge;
  final String strTeamShort;
  final String strStadium;
  final String strLocation;
  final String strDescriptionEN;

  TeamDetailParams(this.strTeam, this.strBadge, this.strTeamShort,
      this.strStadium, this.strLocation, this.strDescriptionEN);
}

class TeamDetail extends StatelessWidget {
  static const routeName = '/team';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BallingAppState>();

    final args = ModalRoute.of(context)!.settings.arguments as TeamDetailParams;

    var team = Teams(
      args.strTeam,
      args.strTeamShort,
      args.strStadium,
      args.strLocation,
      args.strDescriptionEN,
      args.strBadge,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        title: Text(args.strTeam),
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
                            appState.favouriteTeamNames.contains(team.strTeam),
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primaryFixedDim)),
                        onPressed: () => appState.toggleFavoriteTeam(team),
                        icon: Icon(Icons.favorite_outline)),
                    Image.network(args.strBadge),
                    SizedBox(height: 10),
                    Text('Team Acronym',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),
                    Text(args.strTeamShort,
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

                    Text('${args.strStadium}  ${args.strLocation}',
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

                    Text(args.strDescriptionEN,
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
